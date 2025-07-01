import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';

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
  late final AnimationController _lottieController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentPhrase;
  int _currentSceneIndex = 0;
  Timer? _sceneTimer;

  final _random = Random();

  late final List<Map<String, dynamic>> _scenes;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);

    _scenes = _buildScenes();
    _playScene(0);
  }

  List<Map<String, dynamic>> _buildScenes() {
    final phrases = _phrases[widget.tone] ?? _phrases['reflective']!;

    return [
      {
        'lottie': 'assets/lottie/typewriter.json',
        'sound': 'sounds/typewriter_clunk.mp3',
        'phrase': phrases[_random.nextInt(phrases.length)],
        'duration': const Duration(seconds: 3),
      },
      {
        'lottie': 'assets/lottie/memory_book.json',
        'sound': 'sounds/page_flip.mp3',
        'phrase': phrases[_random.nextInt(phrases.length)],
        'duration': const Duration(seconds: 3),
      },
      {
        'lottie': 'assets/lottie/radio.json',
        'sound': 'sounds/piano_loop.mp3',
        'phrase': phrases[_random.nextInt(phrases.length)],
        'duration': const Duration(seconds: 3),
      },
      {
        'lottie': 'assets/lottie/pigeon.json',
        'sound': 'sounds/pigeon_coo.mp3',
        'phrase': phrases[_random.nextInt(phrases.length)],
        'duration': const Duration(seconds: 3),
      },
      {
        'lottie': 'assets/lottie/wooden_table.json',
        'sound': null,
        'phrase': 'Almost there...',
        'duration': const Duration(seconds: 2),
      },
    ];
  }

  void _playScene(int index) {
    if (index >= _scenes.length) {
      widget.onComplete();
      return;
    }

    setState(() {
      _currentSceneIndex = index;
      _currentPhrase = _scenes[index]['phrase'];
    });

    _lottieController.reset();
    _lottieController.duration = null; // Reset duration to allow Lottie to set it

    final soundAsset = _scenes[index]['sound'];
    if (soundAsset != null) {
      _audioPlayer.play(AssetSource(soundAsset));
    }

    _sceneTimer = Timer(_scenes[index]['duration'], () {
      _playScene(index + 1);
    });
  }

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
  void dispose() {
    _lottieController.dispose();
    _audioPlayer.dispose();
    _sceneTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E8D3),
      body: Stack(
        children: [
          Lottie.asset(
            _scenes[_currentSceneIndex]['lottie'],
            controller: _lottieController,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            onLoaded: (composition) {
              _lottieController
                ..duration = composition.duration
                ..repeat();
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  _scenes[_currentSceneIndex]['lottie'],
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  _currentPhrase ?? '',
                  textAlign: TextAlign.center,
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