import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:translator/translator.dart';

import '../models/meal_model.dart';
import '../providers/favorite_provider.dart';
import '../providers/translate_provider.dart';

class DetailScreen extends StatefulWidget {
  final Meal meal;
  const DetailScreen({super.key, required this.meal});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? _translatedInstructions; // Menyimpan hasil terjemahan instruksi
  bool _isTranslating = false;     // Status loading saat terjemahan berlangsung

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final translateEnabled = Provider.of<TranslateProvider>(context).isTranslate;

    // Jika translate aktif, lakukan terjemahan saat dependensi berubah
    if (translateEnabled) {
      _translateInstructions();
    }
  }

  Future<void> _translateInstructions() async {
    // Hindari terjemah ulang jika sudah diterjemahkan sebelumnya
    if (_translatedInstructions != null) return;
    setState(() => _isTranslating = true);

    final translator = GoogleTranslator();
    final translated = await translator.translate(widget.meal.instructions, to: 'id');

    setState(() {
      _translatedInstructions = translated.text;
      _isTranslating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(widget.meal);
    final user = FirebaseAuth.instance.currentUser;
    final translateEnabled = Provider.of<TranslateProvider>(context).isTranslate;

    // Gunakan instruksi asli atau hasil terjemahan tergantung preferensi pengguna
    final instructions = translateEnabled && _translatedInstructions != null
        ? _translatedInstructions!
        : widget.meal.instructions;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              // Cek apakah user login sebelum menambahkan favorit
              if (user == null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Login Diperlukan"),
                    content: const Text("Silakan login terlebih dahulu untuk menambahkan ke favorit."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Tutup"),
                      ),
                    ],
                  ),
                );
              } else {
                favoriteProvider.toggleFavorite(widget.meal);
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar makanan dengan animasi Hero
            Hero(
              tag: widget.meal.name,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.meal.image,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Instruksi Memasak:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            // Tampilkan loading jika sedang menerjemahkan, jika tidak tampilkan instruksi
            _isTranslating
                ? const Center(child: CircularProgressIndicator())
                : Text(
              instructions,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
