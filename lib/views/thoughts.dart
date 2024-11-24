import 'package:flutter/material.dart';

class ThoughtsView extends StatelessWidget {
  const ThoughtsView({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thoughts')),
      body: const Center(child: Text('Welcome to Thoughts Screen!')),
    );
  }
}
