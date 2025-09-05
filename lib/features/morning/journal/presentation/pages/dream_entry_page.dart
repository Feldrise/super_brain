import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:super_brain/features/morning/journal/domain/entities/dream_entry.dart';
import 'package:super_brain/features/morning/journal/presentation/providers/dream_journal_providers.dart';
import 'package:super_brain/features/morning/journal/presentation/widgets/dream_widgets.dart';

class DreamEntryPage extends ConsumerStatefulWidget {
  const DreamEntryPage({super.key, this.entry});

  final DreamEntry? entry;

  @override
  ConsumerState<DreamEntryPage> createState() => _DreamEntryPageState();
}

class _DreamEntryPageState extends ConsumerState<DreamEntryPage> {
  late final TextEditingController _contentController;
  late final TextEditingController _tagsController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.entry?.content ?? '');
    _tagsController = TextEditingController(text: widget.entry?.tags.join(', ') ?? '');

    // Initialize form state if editing
    if (widget.entry != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final notifier = ref.read(dreamEntryFormProvider.notifier);
        notifier.setEditingEntry(widget.entry!); // Set the entry being edited
        notifier.updateContent(widget.entry!.content);
        notifier.updateMood(widget.entry!.mood);
        notifier.updateCategory(widget.entry!.category);
        if (widget.entry!.isLucid) notifier.toggleLucid();
        if (widget.entry!.isRecurring) notifier.toggleRecurring();
        notifier.updateTags(widget.entry!.tags);
        notifier.updateDreamDate(widget.entry!.dreamDate);
      });
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    _tagsController.dispose();
    // Reset the form state when leaving the page
    ref.read(dreamEntryFormProvider.notifier).resetForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(dreamEntryFormProvider);
    final isEditing = widget.entry != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Modifier le rêve' : 'Nouveau rêve'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [if (isEditing) IconButton(onPressed: _showDeleteDialog, icon: const Icon(Icons.delete_outline))],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildContentField(),
              const SizedBox(height: 16),
              QuickDreamPrompts(
                onPromptSelected: (prompt) {
                  final currentText = _contentController.text;
                  final newText = currentText.isEmpty ? prompt : '$currentText $prompt';
                  _contentController.text = newText;
                  _contentController.selection = TextSelection.fromPosition(TextPosition(offset: newText.length));
                  ref.read(dreamEntryFormProvider.notifier).updateContent(newText);
                },
              ),
              const SizedBox(height: 24),
              _buildMoodSection(formState),
              const SizedBox(height: 24),
              _buildCategorySection(formState),
              const SizedBox(height: 24),
              _buildPropertiesSection(formState),
              const SizedBox(height: 24),
              _buildDateSection(formState),
              const SizedBox(height: 24),
              _buildTagsField(),
              const SizedBox(height: 32),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Décrivez votre rêve', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          controller: _contentController,
          maxLines: 8,
          decoration: InputDecoration(
            hintText: 'Je me souviens avoir rêvé de...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Veuillez décrire votre rêve';
            }
            return null;
          },
          onChanged: (value) {
            ref.read(dreamEntryFormProvider.notifier).updateContent(value);
          },
        ),
      ],
    );
  }

  Widget _buildMoodSection(DreamEntryFormState formState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Humeur du rêve', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        MoodSelector(
          selectedMood: formState.mood,
          onMoodSelected: (mood) {
            ref.read(dreamEntryFormProvider.notifier).updateMood(mood);
          },
        ),
      ],
    );
  }

  Widget _buildCategorySection(DreamEntryFormState formState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Type de rêve', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        CategorySelector(
          selectedCategory: formState.category,
          onCategorySelected: (category) {
            ref.read(dreamEntryFormProvider.notifier).updateCategory(category);
          },
        ),
      ],
    );
  }

  Widget _buildPropertiesSection(DreamEntryFormState formState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Propriétés', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CheckboxListTile(
                title: const Text('Rêve lucide'),
                subtitle: const Text('J\'étais conscient de rêver'),
                value: formState.isLucid,
                onChanged: (value) {
                  ref.read(dreamEntryFormProvider.notifier).toggleLucid();
                },
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                title: const Text('Récurrent'),
                subtitle: const Text('Déjà vécu ce rêve'),
                value: formState.isRecurring,
                onChanged: (value) {
                  ref.read(dreamEntryFormProvider.notifier).toggleRecurring();
                },
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateSection(DreamEntryFormState formState) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date du rêve', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        InkWell(
          onTap: _selectDate,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.onSurfaceVariant),
                const SizedBox(width: 12),
                Text(formState.dreamDate != null ? dateFormat.format(formState.dreamDate!) : 'Sélectionner une date', style: Theme.of(context).textTheme.bodyLarge),
                const Spacer(),
                Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Étiquettes (optionnel)', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          controller: _tagsController,
          decoration: const InputDecoration(hintText: 'famille, voyage, animaux...', helperText: 'Séparez les étiquettes par des virgules', border: OutlineInputBorder()),
          onChanged: (value) {
            final tags = value.split(',').map((tag) => tag.trim()).where((tag) => tag.isNotEmpty).toList();
            ref.read(dreamEntryFormProvider.notifier).updateTags(tags);
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _saveDream,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
      child: Text(widget.entry != null ? 'Modifier' : 'Enregistrer', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: ref.read(dreamEntryFormProvider).dreamDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      ref.read(dreamEntryFormProvider.notifier).updateDreamDate(selectedDate);
    }
  }

  Future<void> _saveDream() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final success = await ref.read(dreamEntryFormProvider.notifier).saveDreamEntry();

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rêve enregistré avec succès!')));
      Navigator.of(context).pop();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erreur lors de l\'enregistrement'), backgroundColor: Colors.red));
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le rêve'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce rêve? Cette action est irréversible.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Annuler')),
          TextButton(
            onPressed: _deleteDream,
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteDream() async {
    if (widget.entry == null) return;

    try {
      final deleteUseCase = ref.read(deleteDreamEntryUseCaseProvider);
      if (deleteUseCase == null) {
        throw Exception('User not authenticated');
      }

      await deleteUseCase.call(widget.entry!.id);

      // Refresh the dream entries list
      ref.invalidate(dreamEntriesProvider);
      ref.invalidate(filteredDreamEntriesProvider);

      if (mounted) {
        Navigator.of(context).pop(); // Close dialog
        Navigator.of(context).pop(); // Go back to list
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rêve supprimé')));
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Close dialog
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erreur lors de la suppression'), backgroundColor: Colors.red));
      }
    }
  }
}
