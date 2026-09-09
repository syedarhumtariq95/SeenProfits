import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  @override
  State<FavoritesScreen> createState() => _Favorites();
}

class _Favorites extends State<FavoritesScreen> {
  final names = ['ABC General Store', 'XYZ Restaurant'];
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: names.isEmpty
          ? const Center(child: Text('No saved businesses yet'))
          : ListView(
              children: names
                  .map((name) => ListTile(
                      title: Text(name),
                      subtitle: const Text('Verified · Lahore'),
                      trailing: IconButton(
                          onPressed: () => setState(() => names.remove(name)),
                          icon:
                              const Icon(Icons.favorite, color: Colors.pink))))
                  .toList()));
}
