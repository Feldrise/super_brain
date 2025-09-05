import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/tip_providers.dart';
import '../widgets/tip_card.dart';
import 'tip_detail_page.dart';

class TipsListPage extends ConsumerStatefulWidget {
  const TipsListPage({super.key});

  @override
  ConsumerState<TipsListPage> createState() => _TipsListPageState();
}

class _TipsListPageState extends ConsumerState<TipsListPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conseils & Astuces'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tous', icon: Icon(Icons.lightbulb_outline)),
            Tab(text: 'Favoris', icon: Icon(Icons.bookmark_outline)),
            Tab(text: 'Historique', icon: Icon(Icons.history)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher des conseils...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Content
          Expanded(
            child: _searchQuery.isNotEmpty ? _buildSearchResults() : TabBarView(controller: _tabController, children: [_buildAllTips(), _buildFavoriteTips(), _buildTipsHistory()]),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    final searchResultsAsync = ref.watch(searchTipsProvider(_searchQuery));

    return searchResultsAsync.when(
      data: (tips) => tips.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('Aucun conseil trouvé', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  Text('Essayez avec d\'autres mots-clés', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[500])),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: tips.length,
              itemBuilder: (context, index) {
                final tip = tips[index];
                return TipCard(tip: tip, onTap: () => _navigateToTipDetail(tip));
              },
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Erreur: $error')),
    );
  }

  Widget _buildAllTips() {
    final allTipsAsync = ref.watch(allTipsProvider);

    return allTipsAsync.when(
      data: (tips) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final tip = tips[index];
          return TipCard(tip: tip, onTap: () => _navigateToTipDetail(tip));
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Erreur: $error')),
    );
  }

  Widget _buildFavoriteTips() {
    // For now, we'll show a placeholder since we haven't implemented favorites
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('Fonctionnalité à venir', style: TextStyle(fontSize: 18, color: Colors.grey)),
          SizedBox(height: 8),
          Text(
            'Vous pourrez bientôt marquer vos conseils favoris',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsHistory() {
    final historyAsync = ref.watch(tipsHistoryProvider);

    return historyAsync.when(
      data: (tips) => tips.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Aucun conseil lu', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  SizedBox(height: 8),
                  Text(
                    'Consultez des conseils pour les voir apparaître ici',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: tips.length,
              itemBuilder: (context, index) {
                final tip = tips[index];
                return TipCard(tip: tip, onTap: () => _navigateToTipDetail(tip), showReadBadge: true);
              },
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Erreur: $error')),
    );
  }

  void _navigateToTipDetail(tip) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TipDetailPage(tip: tip)));
  }
}
