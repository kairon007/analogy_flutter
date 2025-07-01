import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingAnimation extends StatefulWidget {
  final String userInput;
  final String tone;
  final VoidCallback onComplete;

  const LoadingAnimation({
    super.key,
    required this.userInput,
    required this.tone,
    required this.onComplete,
  });

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  String? _phrase;
  final _random = Random();

  final _phrases = {
    'reflective': [
      'Searching the past...',
      'Recalling simpler times...',
      'Tracing echoes of yesterday...',
      'Unveiling timeless truths...',
    ],
    'funny': [
      'Hold on, Grandma’s got this!',
      'Wow, you kids have it easy...',
      'Chasing pigeons for your answer...',
      'Typewriter’s jammed again!',
    ],
    'nostalgic': [
      'Dusting off memories...',
      'Flipping through time...',
      'Revisiting the old ways...',
      'Opening the family album...',
    ],
    'sarcastic': [
      'Oh, this is fancy now?',
      'Back in my day...',
      'What, no carrier pigeons?',
      'Kids and their gadgets...',
    ],
    'emotional': [
      'Finding the heart of it...',
      'A memory unfolds...',
      'Feeling the past’s embrace...',
      'Whispers from long ago...',
    ],
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _phrase = _getRandomPhrase();
    Timer(const Duration(seconds: 5), () {
      widget.onComplete();
    });
  }

  String _getRandomPhrase() {
    final phraseList = _phrases[widget.tone] ?? _phrases['reflective']!;
    return phraseList[_random.nextInt(phraseList.length)];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E8D3),
      body: Stack(
        children: [
          Lottie.asset(
            'assets/lottie/wooden_table.json',
            controller: _controller,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..repeat();
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/memory_book.json',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  _phrase ?? '',
                  style: const TextStyle(
                    fontSize: 22,
                    fontFamily: 'Baskerville',
                    color: Color(0xFF4A3726),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
