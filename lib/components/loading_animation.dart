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
  late final AnimationController _orbitController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final _random = Random();
  Timer? _sceneTimer;
  late List<Map<String, dynamic>> _scenes;
  final ValueNotifier<int> _currentSceneIndex = ValueNotifier(0);
  final ValueNotifier<String?> _currentPhrase = ValueNotifier(null);
  final List<GlobalKey> _sceneKeys = [];
  final ValueNotifier<List<double>> _sceneAngles = ValueNotifier<List<double>>([]);
  final ValueNotifier<List<double>> _sceneRadii = ValueNotifier<List<double>>([]);
  final ValueNotifier<List<double>> _sceneScales = ValueNotifier<List<double>>([]);
  final ValueNotifier<List<bool>> _sceneVisibility = ValueNotifier<List<bool>>([]);
  
  // Orbital animation values
  static const double _orbitRadius = 100.0;
  static const double _orbitSpeed = 0.5; // rotations per second

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
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20), // Slow orbit speed
    )..repeat();
    
    _scenes = _buildScenes();
    
    // Initialize scene states
    _sceneAngles.value = List.generate(_scenes.length, 
      (index) => index * (2 * pi / _scenes.length) // Evenly distribute in a circle
    );
    _sceneRadii.value = List.filled(_scenes.length, 0.0);
    _sceneScales.value = List.filled(_scenes.length, 1.0);
    _sceneVisibility.value = List.filled(_scenes.length, false);
    
    // Create keys for each scene
    _sceneKeys.addAll(List.generate(_scenes.length, (index) => GlobalKey()));
    
    // Start the animation after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _playScene(0);
      }
    });
  }

  List<Map<String, dynamic>> _buildScenes() {
    final phrases = _phrases[widget.tone] ?? _phrases['reflective']!;

    return [
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

  void _playScene(int index) async {
    if (!mounted || index >= _scenes.length) {
      if (mounted) {
        widget.onComplete();
      }
      return;
    }

    // Show current scene first
    final newVisibility = List<bool>.from(_sceneVisibility.value);
    newVisibility[index] = true;
    _sceneVisibility.value = newVisibility;
    _currentSceneIndex.value = index;
    _currentPhrase.value = _scenes[index]['phrase'];

    // Start the animation
    _lottieController.reset();
    _lottieController.duration = null;

    // Play sound if available
    final soundAsset = _scenes[index]['sound'];
    if (soundAsset != null) {
      _audioPlayer.play(AssetSource(soundAsset));
    }

    // Move previous scene to orbit after a short delay
    if (index > 0) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        _moveSceneToOrbit(index - 1);
      }
    }

    // Schedule next scene
    _sceneTimer?.cancel();
    if (mounted) {
      _sceneTimer = Timer(_scenes[index]['duration'], () {
        if (mounted) {
          _playScene(index + 1);
        }
      });
    }
  }

  void _moveSceneToOrbit(int index) {
    final radii = List<double>.from(_sceneRadii.value);
    final scales = List<double>.from(_sceneScales.value);
    
    // Gradually increase the orbit radius for a smooth transition
    radii[index] = _orbitRadius;
    // Slightly randomize the scale for a more organic feel
    scales[index] = 0.4 + _random.nextDouble() * 0.2;
    
    _sceneRadii.value = radii;
    _sceneScales.value = scales;
  }

  @override
  void dispose() {
    _lottieController.dispose();
    _orbitController.dispose();
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
          // Background
          Container(
            color: const Color(0xFFF5E8D3),
            width: double.infinity,
            height: double.infinity,
          ),
          
          // Orbital Animation Builder
          AnimatedBuilder(
            animation: _orbitController,
            builder: (context, _) {
              final orbitValue = _orbitController.value * 2 * pi * _orbitSpeed;
              
              return ValueListenableBuilder<List<bool>>(
                valueListenable: _sceneVisibility,
                builder: (context, visibility, _) {
                  return SizedBox.expand(
                    child: Stack(
                      children: List.generate(_scenes.length, (index) {
                        if (index >= visibility.length || !visibility[index]) {
                          return const SizedBox.shrink();
                        }
                        
                        return ValueListenableBuilder<List<double>>(
                          valueListenable: _sceneAngles,
                          builder: (context, angles, _) {
                            return ValueListenableBuilder<List<double>>(
                              valueListenable: _sceneRadii,
                              builder: (context, radii, _) {
                                return ValueListenableBuilder<List<double>>(
                                  valueListenable: _sceneScales,
                                  builder: (context, scales, _) {
                                    if (index >= angles.length || index >= radii.length || index >= scales.length) {
                                      return const SizedBox.shrink();
                                    }
                                    
                                    // Calculate position based on angle and radius
                                    final angle = angles[index] + orbitValue;
                                    final radius = radii[index];
                                    final centerX = MediaQuery.of(context).size.width / 2 - 100;
                                    final centerY = MediaQuery.of(context).size.height / 2 - 100;
                                    
                                    final x = centerX + radius * cos(angle);
                                    final y = centerY + radius * sin(angle);
                                    
                                    // Add slight 3D tilt based on position
                                    final tiltX = sin(angle) * 0.1;
                                    final tiltY = cos(angle) * 0.1;
                                    
                                    return AnimatedPositioned(
                                      duration: const Duration(milliseconds: 50),
                                      curve: Curves.linear,
                                      left: x,
                                      top: y,
                                      child: Transform(
                                        transform: Matrix4.identity()
                                          ..setEntry(3, 2, 0.001) // Perspective
                                          ..rotateX(tiltX)
                                          ..rotateY(tiltY),
                                        alignment: FractionalOffset.center,
                                        child: AnimatedScale(
                                          duration: const Duration(milliseconds: 800),
                                          curve: Curves.easeOutBack,
                                          scale: scales[index],
                                          child: Container(
                                            key: _sceneKeys[index],
                                            width: 200,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.2),
                                                  blurRadius: 15,
                                                  spreadRadius: 5,
                                                )
                                              ],
                                            ),
                                            child: Lottie.asset(
                                              _scenes[index]['lottie'],
                                              controller: index == _currentSceneIndex.value ? _lottieController : null,
                                              fit: BoxFit.contain,
                                              onLoaded: index == _currentSceneIndex.value ? (composition) {
                                                _lottieController
                                                  ..duration = composition.duration
                                                  ..repeat();
                                              } : null,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      }),
                    ),
                  );
                },
              );
            },
          ),
          
          // Current Phrase
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<String?>(
              valueListenable: _currentPhrase,
              builder: (context, phrase, _) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    phrase ?? '',
                    key: ValueKey<String>(phrase ?? ''),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'Baskerville',
                      color: Color(0xFF4A3726),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.white,
                          blurRadius: 10,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}