import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/fire_crud/ui/screen/pancake_screen.dart';
import 'package:provider/provider.dart';
import 'fire_crud/data/repository/pancake_repo.dart';
import 'fire_crud/firebase_repo/fire_pancake_repo.dart';
import 'fire_crud/ui/provider/pancake_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final PancakeRepository pancakeRepository = FirebasePancakeRepository();

  runApp(
    ChangeNotifierProvider(
      create: (context) => Pancakeprovider(pancakeRepository),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: const PancakeScreen()),
    ),
  );
}