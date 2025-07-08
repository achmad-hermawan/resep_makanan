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
    // Controller untuk animasi fade-in saat menampilkan hasil pencarian
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

  // Fungsi untuk mencari resep berdasarkan input teks atau kategori preset
  void _searchMeal([String? preset]) async {
    final query = preset ?? _controller.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _firstVisit = false; // Menandakan bahwa ini bukan kunjungan pertama
    });

    try {
      final meals = await ApiService.fetchMeals(query);
      setState(() {
        _meals = meals;
        _animController.forward(from: 0); // Mulai animasi dari awal
      });
    } catch (_) {
      setState(() {
        _meals = [];
      });

      // Tampilkan pesan kesalahan jika gagal mengambil data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal memuat data")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Widget untuk menampilkan kolom pencarian
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
              onSubmitted: (_) => _searchMeal(), // pencarian saat ditekan Enter
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.green),
            onPressed: _searchMeal, // pencarian saat tekan tombol kirim
          ),
        ],
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2.3), // Sesuaikan dengan preferensi
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 16),
          Expanded(child: _buildResultGrid()),
        ],
      ),
    );
  }
}
