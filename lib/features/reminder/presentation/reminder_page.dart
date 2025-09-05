import 'package:flutter/material.dart';
import 'package:super_brain/features/reminder/presentation/widgets/words_section.dart';
import 'package:super_brain/features/reminder/presentation/widgets/summaries_section.dart';
import 'package:super_brain/features/words/presentation/pages/create_word_list_page.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rappels'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list_alt), text: 'Listes de mots'),
              Tab(icon: Icon(Icons.summarize), text: 'Résumés'),
            ],
          ),
        ),
        body: TabBarView(children: [WordsSection(), SummariesSection()]),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _showAddDialog(context);
          },
          icon: const Icon(Icons.add),
          label: const Text('Ajouter'),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Que voulez-vous ajouter ?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Nouvelle liste de mots'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateWordListPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.summarize),
              title: const Text('Nouveau résumé'),
              onTap: () {
                Navigator.of(context).pop();
                // TODO: Navigate to add summary
              },
            ),
          ],
        ),
      ),
    );
  }
}
