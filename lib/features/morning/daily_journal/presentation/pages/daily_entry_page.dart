import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/core/widgets/unsaved_changes_dialog.dart';
import 'package:super_brain/features/morning/daily_journal/domain/entities/daily_entry.dart';
import 'package:super_brain/features/morning/daily_journal/presentation/providers/daily_journal_providers.dart';

class DailyEntryPage extends ConsumerStatefulWidget {
  const DailyEntryPage({super.key, this.entry, this.isReadOnly = false});

  final DailyEntry? entry;
  final bool isReadOnly;

  @override
  ConsumerState<DailyEntryPage> createState() => _DailyEntryPageState();
}

class _DailyEntryPageState extends ConsumerState<DailyEntryPage> {
  late final TextEditingController _contentController;
  late final TextEditingController _reflectionController;
  late final TextEditingController _gratitudeController;
  late final TextEditingController _goalsController;
  final _formKey = GlobalKey<FormState>();

  // Track initial values to detect changes
  String _initialContent = '';
  String _initialReflection = '';
  String _initialGratitude = '';
  String _initialGoals = '';
  String? _initialMood;
  DateTime? _initialEntryDate;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _contentController = TextEditingController();
    _reflectionController = TextEditingController();
    _gratitudeController = TextEditingController();
    _goalsController = TextEditingController();

    // Store initial values
    if (widget.entry != null) {
      _initialContent = widget.entry!.content;
      _initialReflection = widget.entry!.reflection ?? '';
      _initialGratitude = widget.entry!.gratitudeList.join('\n');
      _initialGoals = widget.entry!.goalsForToday.join('\n');
      _initialMood = widget.entry!.mood;
      _initialEntryDate = widget.entry!.entryDate;
    } else {
      _initialContent = '';
      _initialReflection = '';
      _initialGratitude = '';
      _initialGoals = '';
      _initialMood = null;
      _initialEntryDate = DateTime.now();
    }

    // Set up editing if entry is provided
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.entry != null) {
        ref.read(dailyEntryFormProvider.notifier).setEditingEntry(widget.entry);
        _loadEntryData();
      } else {
        // For new entries, set today's date
        ref.read(dailyEntryFormProvider.notifier).updateEntryDate(DateTime.now());
      }
    });
  }

  void _loadEntryData() {
    final entry = widget.entry!;
    _contentController.text = entry.content;
    _reflectionController.text = entry.reflection ?? '';
    _gratitudeController.text = entry.gratitudeList.join('\n');
    _goalsController.text = entry.goalsForToday.join('\n');
  }

  @override
  void dispose() {
    _contentController.dispose();
    _reflectionController.dispose();
    _gratitudeController.dispose();
    _goalsController.dispose();
    super.dispose();
  }

  /// Check if there are unsaved changes in the form
  bool _hasUnsavedChanges() {
    if (widget.isReadOnly) return false;

    final formState = ref.read(dailyEntryFormProvider);

    return _contentController.text != _initialContent ||
        _reflectionController.text != _initialReflection ||
        _gratitudeController.text != _initialGratitude ||
        _goalsController.text != _initialGoals ||
        formState.mood != _initialMood ||
        formState.entryDate != _initialEntryDate;
  }

  /// Handle back button press with confirmation
  Future<bool> _onWillPop() async {
    if (!_hasUnsavedChanges()) {
      return true;
    }

    return await UnsavedChangesDialog.show(
      context,
      title: 'Modifications non sauvegardées',
      content: 'Vous avez des modifications non sauvegardées. Que voulez-vous faire ?',
      onSave: () {
        Navigator.of(context).pop();
        _saveDailyEntry();
      },
      onDiscard: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.entry != null;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isReadOnly
                ? 'Lecture'
                : isEditing
                ? 'Modifier l\'entrée'
                : 'Nouvelle entrée',
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          actions: widget.isReadOnly
              ? [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => DailyEntryPage(entry: widget.entry)));
                    },
                  ),
                ]
              : null,
        ),
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Date selector
                    _buildDateSelector(context, theme),
                    const SizedBox(height: 24),

                    // Main content section
                    _buildMainContentSection(theme),
                    const SizedBox(height: 24),

                    // Mood selector
                    _buildMoodSelector(theme),
                    const SizedBox(height: 24),

                    // Gratitude section
                    _buildGratitudeSection(theme),
                    const SizedBox(height: 24),

                    // Goals section
                    _buildGoalsSection(theme),
                    const SizedBox(height: 24),

                    // Reflection section
                    _buildReflectionSection(theme),
                    const SizedBox(height: 100), // Space for FAB
                  ]),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: widget.isReadOnly
            ? null
            : FloatingActionButton.extended(
                onPressed: _saveDailyEntry,
                icon: const Icon(Icons.save),
                label: Text(isEditing ? 'Mettre à jour' : 'Sauvegarder'),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, ThemeData theme) {
    final formState = ref.watch(dailyEntryFormProvider);
    final selectedDate = formState.entryDate ?? DateTime.now();

    return Card(
      child: ListTile(
        leading: Icon(Icons.calendar_today, color: theme.colorScheme.primary),
        title: const Text('Date de l\'entrée'),
        subtitle: Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        trailing: widget.isReadOnly ? null : const Icon(Icons.chevron_right),
        enabled: !widget.isReadOnly,
        onTap: widget.isReadOnly ? null : () => _selectDate(context),
      ),
    );
  }

  Widget _buildMainContentSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.edit_note, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Comment vous sentez-vous aujourd\'hui ?', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 16),
            if (!widget.isReadOnly) _buildPromptButtons(),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(hintText: 'Écrivez vos pensées, sentiments et expériences...', border: OutlineInputBorder(), alignLabelWithHint: true),
              maxLines: 6,
              readOnly: widget.isReadOnly,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez saisir du contenu pour votre entrée';
                }
                return null;
              },
              onChanged: widget.isReadOnly
                  ? null
                  : (value) {
                      ref.read(dailyEntryFormProvider.notifier).updateContent(value);
                    },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptButtons() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: DailyJournalPrompts.reflectionPrompts.take(3).map((prompt) {
        return ActionChip(
          label: Text(prompt),
          onPressed: () {
            final currentText = _contentController.text;
            final newText = currentText.isEmpty ? prompt : '$currentText\n\n$prompt';
            _contentController.text = newText;
            ref.read(dailyEntryFormProvider.notifier).updateContent(newText);
          },
        );
      }).toList(),
    );
  }

  Widget _buildMoodSelector(ThemeData theme) {
    final formState = ref.watch(dailyEntryFormProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.mood, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Humeur du matin', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: DailyMood.allMoods.map((mood) {
                final isSelected = formState.mood == mood.name;
                return ChoiceChip(
                  label: Row(mainAxisSize: MainAxisSize.min, children: [Text(mood.emoji), const SizedBox(width: 4), Text(mood.label)]),
                  selected: isSelected,
                  onSelected: widget.isReadOnly
                      ? null
                      : (selected) {
                          ref.read(dailyEntryFormProvider.notifier).updateMood(selected ? mood.name : null);
                        },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGratitudeSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.favorite, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Gratitude', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Pour quoi êtes-vous reconnaissant aujourd\'hui ?', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 16),
            TextFormField(
              controller: _gratitudeController,
              decoration: const InputDecoration(
                hintText: 'Une chose par ligne...\nMa famille\nMa santé\nCette belle journée',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              readOnly: widget.isReadOnly,
              onChanged: widget.isReadOnly
                  ? null
                  : (value) {
                      final items = value.split('\n').where((item) => item.trim().isNotEmpty).toList();
                      ref.read(dailyEntryFormProvider.notifier).updateGratitudeList(items);
                    },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.track_changes, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Objectifs du jour', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Que voulez-vous accomplir aujourd\'hui ?', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 16),
            TextFormField(
              controller: _goalsController,
              decoration: const InputDecoration(
                hintText: 'Un objectif par ligne...\nFinir ce projet\nFaire du sport\nAppeler un ami',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 3,
              readOnly: widget.isReadOnly,
              onChanged: widget.isReadOnly
                  ? null
                  : (value) {
                      final items = value.split('\n').where((item) => item.trim().isNotEmpty).toList();
                      ref.read(dailyEntryFormProvider.notifier).updateGoalsForToday(items);
                    },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReflectionSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.psychology, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Réflexion personnelle', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Réflexions supplémentaires, leçons apprises...', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 16),
            TextFormField(
              controller: _reflectionController,
              decoration: const InputDecoration(hintText: 'Mes pensées supplémentaires...', border: OutlineInputBorder(), alignLabelWithHint: true),
              maxLines: 4,
              readOnly: widget.isReadOnly,
              onChanged: widget.isReadOnly
                  ? null
                  : (value) {
                      ref.read(dailyEntryFormProvider.notifier).updateReflection(value);
                    },
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final formState = ref.read(dailyEntryFormProvider);
    final currentDate = formState.entryDate ?? DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );

    if (picked != null) {
      ref.read(dailyEntryFormProvider.notifier).updateEntryDate(picked);
    }
  }

  void _saveDailyEntry() async {
    if (!_formKey.currentState!.validate()) return;

    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    try {
      final success = await ref.read(dailyEntryFormProvider.notifier).saveDailyEntry();

      if (success) {
        navigator.pop();
        messenger.showSnackBar(SnackBar(content: Text(widget.entry != null ? 'Entrée mise à jour avec succès !' : 'Entrée sauvegardée avec succès !')));
      } else {
        messenger.showSnackBar(const SnackBar(content: Text('Erreur lors de la sauvegarde'), backgroundColor: Colors.red));
      }
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Erreur: $e'), backgroundColor: Colors.red));
    }
  }
}
