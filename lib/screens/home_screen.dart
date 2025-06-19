import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../services/api_service.dart';
import '../widgets/meal_item.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  List<Meal> _meals = [];
  bool _isLoading = false;
  bool _firstVisit = true;
  late AnimationController _animController;

  final List<String> _categories = ['Ayam', 'Sambal', 'Sapi', 'Sayur', 'Sup', 'Kue'];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _searchMeal([String? preset]) async {
    final query = preset ?? _controller.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _firstVisit = false;
    });

    try {
      final meals = await ApiService.fetchMeals(query);
      setState(() {
        _meals = meals;
        _animController.forward(from: 0); // animasi ulang
      });
    } catch (_) {
      setState(() {
        _meals = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal memuat data")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Cari resep makanan...",
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _searchMeal(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.green),
            onPressed: _searchMeal,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return ActionChip(
            label: Text(cat),
            backgroundColor: Colors.green.shade50,
            onPressed: () => _searchMeal(cat),
          );
        },
      ),
    );
  }

  Widget _buildResultGrid() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_meals.isEmpty) {
      return _firstVisit
          ? const Center(child: Text("Cari resep favoritmu!"))
          : const Center(child: Text("Tidak ditemukan. Coba kata lain."));
    } else {
      return GridView.builder(
        itemCount: _meals.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final meal = _meals[index];
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: _animController,
              curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
            ),
            child: MealItem(meal: meal),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Resep Makanan"),
          actions: [
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    themeProvider.toggleTheme(!themeProvider.isDarkMode);
                  },
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 16),
              Expanded(child: _buildResultGrid()),
            ],
          ),
        ),
      ),
    );
  }
}
