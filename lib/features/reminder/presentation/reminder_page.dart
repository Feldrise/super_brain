import 'package:flutter/material.dart';
import 'package:super_brain/features/reminder/presentation/widgets/words_section.dart';
import 'package:super_brain/features/reminder/presentation/widgets/summaries_section.dart';
import 'package:super_brain/features/words/presentation/pages/create_word_list_page.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rappels'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.list_alt), text: 'Listes de mots'),
            Tab(icon: Icon(Icons.summarize), text: 'Résumés'),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [WordsSection(), SummariesSection()]),
      // Only show floating action button on words tab (index 0)
      floatingActionButton: _currentTabIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                _showAddDialog(context);
              },
              icon: const Icon(Icons.add),
              label: const Text('Nouvelle liste'),
            )
          : null,
    );
  }

  void _showAddDialog(BuildContext context) {
    // Since summaries are creator-only content, users can only add word lists
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateWordListPage()));
  }
}
