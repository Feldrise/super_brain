import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/features/words/presentation/providers/word_list_providers.dart';

class CreateWordListPage extends ConsumerStatefulWidget {
  const CreateWordListPage({super.key});

  @override
  ConsumerState<CreateWordListPage> createState() => _CreateWordListPageState();
}

class _CreateWordListPageState extends ConsumerState<CreateWordListPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _wordsController = TextEditingController();
  String _selectedDifficulty = 'Moyen';
  String? _selectedCategory;
  bool _isLoading = false;

  final List<String> _difficulties = ['Facile', 'Moyen', 'Difficile'];
  final List<String> _categories = [
    'Animaux',
    'Objets quotidiens',
    'Nourriture',
    'Couleurs',
    'Émotions',
    'Actions',
    'Nature',
    'Transports',
    'Professions',
    'Sports',
    'Mots abstraits',
    'Autre',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _wordsController.dispose();
    super.dispose();
  }

  Future<void> _createWordList() async {
    if (!_formKey.currentState!.validate()) return;

    final user = ref.read(currentUserProvider);
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vous devez être connecté')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final words = _wordsController.text.split('\n').map((word) => word.trim()).where((word) => word.isNotEmpty).toList();

      if (words.length < 3) {
        throw Exception('Vous devez avoir au moins 3 mots');
      }

      final useCase = ref.read(createWordListUseCaseProvider);
      await useCase.createWordList(userId: user.uid, title: _titleController.text.trim(), words: words, difficulty: _selectedDifficulty, category: _selectedCategory);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Liste créée avec succès !')));
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle liste de mots'), backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Titre de la liste',
                  hintText: 'Ex: Animaux de la ferme',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Category dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Catégorie (optionnel)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(value: category, child: Text(category));
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedCategory = value);
                },
              ),
              const SizedBox(height: 16),

              // Difficulty dropdown
              DropdownButtonFormField<String>(
                value: _selectedDifficulty,
                decoration: InputDecoration(
                  labelText: 'Difficulté',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: _difficulties.map((difficulty) {
                  return DropdownMenuItem(value: difficulty, child: Text(difficulty));
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedDifficulty = value!);
                },
              ),
              const SizedBox(height: 16),

              // Words field
              TextFormField(
                controller: _wordsController,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: 'Mots (un par ligne)',
                  hintText: 'Cheval\nVache\nPoule\nMouton\n...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez entrer au moins 3 mots';
                  }

                  final words = value.split('\n').map((word) => word.trim()).where((word) => word.isNotEmpty).toList();

                  if (words.length < 3) {
                    return 'Vous devez avoir au moins 3 mots';
                  }

                  if (words.length > 50) {
                    return 'Maximum 50 mots par liste';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Help text
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: theme.colorScheme.primary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Conseils',
                          style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Écrivez un mot par ligne\n'
                      '• Entre 3 et 50 mots par liste\n'
                      '• Groupez les mots par thème pour une meilleure mémorisation\n'
                      '• Commencez par des listes courtes (5-10 mots)',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Create button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _createWordList,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Créer la liste', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
