import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingAnimation extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return _LoadingAnimationContent(
      tone: tone,
      onComplete: onComplete,
    );
  }
}

class _LoadingAnimationContent extends StatefulWidget {
  final String tone;
  final VoidCallback onComplete;

  const _LoadingAnimationContent({
    required this.tone,
    required this.onComplete,
  });

  @override
  _LoadingAnimationContentState createState() => _LoadingAnimationContentState();
}

class _LoadingAnimationContentState extends State<_LoadingAnimationContent>
    with TickerProviderStateMixin {
  late final AnimationController _lottieController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final _random = Random();
  Timer? _sceneTimer;
  late List<Map<String, dynamic>> _scenes;
  final ValueNotifier<int> _currentSceneIndex = ValueNotifier(0);
  final ValueNotifier<String?> _currentPhrase = ValueNotifier(null);

  final _phrases = {
    'reflective': [
      'Searching the past...',
      'Recalling simpler times...',
      'Tracing echoes of yesterday...',
      'Unveiling timeless truths...',
    ],
    'funny': [
      'Hold on, Grandma\'s got this!',
      'Wow, you kids have it easy...',
      'Chasing pigeons for your answer...',
      'Typewriter\'s jammed again!',
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
      'Feeling the past\'s embrace...',
      'Whispers from long ago...',
    ],
  };

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
     /* {
        'lottie': 'assets/lottie/typewriter.json',
        'sound': 'sounds/typewriter_clunk.mp3',
        'phrase': phrases[_random.nextInt(phrases.length)],
        'duration': const Duration(seconds: 3),
      },*/
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

    _currentSceneIndex.value = index;
    _currentPhrase.value = _scenes[index]['phrase'];

    _lottieController.reset();
    _lottieController.duration = null;

    final soundAsset = _scenes[index]['sound'];
    if (soundAsset != null) {
      _audioPlayer.play(AssetSource(soundAsset));
    }

    _sceneTimer?.cancel();
    _sceneTimer = Timer(_scenes[index]['duration'], () {
      _playScene(index + 1);
    });
  }

  @override
  void dispose() {
    _lottieController.dispose();
    _audioPlayer.dispose();
    _sceneTimer?.cancel();
    _currentSceneIndex.dispose();
    _currentPhrase.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E8D3),
      body: Stack(
        children: [
          ValueListenableBuilder<int>(
            valueListenable: _currentSceneIndex,
            builder: (context, sceneIndex, _) {
              return Lottie.asset(
                _scenes[sceneIndex]['lottie'],
                controller: _lottieController,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                onLoaded: (composition) {
                  _lottieController
                    ..duration = composition.duration
                    ..repeat();
                },
              );
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: _currentSceneIndex,
                  builder: (context, sceneIndex, _) {
                    return Lottie.asset(
                      _scenes[sceneIndex]['lottie'],
                      width: 200,
                      height: 200,
                    );
                  },
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder<String?>(
                  valueListenable: _currentPhrase,
                  builder: (context, phrase, _) {
                    return Text(
                      phrase ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontFamily: 'Baskerville',
                        color: Color(0xFF4A3726),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}