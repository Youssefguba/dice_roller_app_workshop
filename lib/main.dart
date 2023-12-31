import 'dart:math';
import 'package:flutter/material.dart';

const diceImages = [
  "https://drive.google.com/uc?export=download&id=1mnMp_OPHC6bK4RB4L5UHOJl6xvb91Xwx",
  "https://drive.google.com/uc?export=download&id=1G1ntuxZ_04fuosdIkkeMYkCwvIzLidlb",
  "https://drive.google.com/uc?export=download&id=1O24Leu_tSlZrnQmS5xJ_8eJxAnqsBDR_",
  "https://drive.google.com/uc?export=download&id=1w3znClcfBc4QcVHVc2QV0pECOZgrNeCQ",
  "https://drive.google.com/uc?export=download&id=1fNWZ_LS5-uq68z81_nlwFjrTQDTQ7TLn",
  "https://drive.google.com/uc?export=download&id=1elMThIWtE_UEuar32KLwN3MsAboJBPny",
];

void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dice Roll'),
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage>
    with SingleTickerProviderStateMixin {
  int diceNumber = 1;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _rotationAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
  }

  void changeDiceFace() {
    _controller.reset();
    _controller.forward();
    setState(() {
      diceNumber = Random().nextInt(6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: RotationTransition(
              turns: _rotationAnimation,
              child: Image.network(
                diceImages[diceNumber],
                height: 150,
                width: 150,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: changeDiceFace,
            child: const Text('Roll Dice'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
