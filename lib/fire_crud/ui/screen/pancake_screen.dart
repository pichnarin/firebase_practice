import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/pancake.dart';
import '../provider/pancake_provider.dart';

class PancakeScreen extends StatelessWidget {
  const PancakeScreen({super.key});

  void _onAddPressed(BuildContext context) {
    final Pancakeprovider pancakeProvider = context.read<Pancakeprovider>();
    final random = Random();
    final colors = ["red", "green", "blue", "yellow", "purple"];
    final color = colors[random.nextInt(colors.length)];
    final price = double.parse(
      (random.nextDouble() * 10).toStringAsFixed(1),
    ); // Random price between 0 and 10, formatted to one decimal place
    pancakeProvider.addPancake(color, price);
  }

  void _onDeletePressed(BuildContext context, String id) {
    final Pancakeprovider pancakeProvider = context.read<Pancakeprovider>();
    pancakeProvider.deletePancake(id);
  }

  Color _getColorFromString(String color) {
    switch (color.toLowerCase()) {
      case "red":
        return Colors.red;
      case "green":
        return Colors.green;
      case "blue":
        return Colors.blue;
      case "yellow":
        return Colors.yellow;
      case "purple":
        return Colors.purple;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pancakeProvider = Provider.of<Pancakeprovider>(context);

    Widget content = const Text('');
    if (pancakeProvider.isLoading) {
      content = const CircularProgressIndicator();
    } else if (pancakeProvider.hasData) {
      List<Pancake> pancakes = pancakeProvider.pancakesState!.data!;

      if (pancakes.isEmpty) {
        content = const Text("No data yet");
      } else {
        content = ListView.builder(
          itemCount: pancakes.length,
          itemBuilder: (context, index) {
            final pancake = pancakes[index];
            final color = _getColorFromString(pancake.color);
            return ListTile(
              title: Text(
                pancake.color.toUpperCase(),
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "\$${pancake.price}",
                style: TextStyle(color: color),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _onDeletePressed(context, pancake.id),
              ),
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => _onAddPressed(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(child: content),
    );
  }
}
