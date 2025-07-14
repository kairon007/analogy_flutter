import 'package:analogy_flutter/components/loading_animation.dart';
import 'package:analogy_flutter/screens/create/widgets/action_buttons.dart';
import 'package:analogy_flutter/screens/create/widgets/analogy_card.dart';
import 'package:analogy_flutter/screens/create/widgets/expanded_analogy_view.dart';
import 'package:analogy_flutter/screens/create/widgets/header.dart';
import 'package:analogy_flutter/screens/create/widgets/input_field.dart';
import 'package:analogy_flutter/screens/create/widgets/tone_selection.dart';
import 'package:analogy_flutter/util/extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String _selectedTone = 'reflective';
  String _analogy = '';
  bool _isGenerating = false;
  bool _isFavorited = false;
  double _sliderValue = 0.5;
  final String _beforeImage = 'assets/images/before.jpg';
  final String _afterImage = 'assets/images/after.jpg';
  final Map<String, Map<String, String>> _mockAnalogies = {
    'food delivery': {
      'reflective':
          'Food delivery today is what handwritten recipe cards and a bicycle trip to the local grocer were for our grandparents — a dance between memory, effort, and the anticipation that made every meal feel earned.',
      'humble':
          'What we call \'food delivery\' was once a grandmother\'s patient hands kneading dough at dawn, knowing that nourishment came not from speed, but from the love baked into every loaf.',
      'funny':
          'Food delivery apps are like having a very efficient but socially awkward friend who knows every restaurant owner in town and doesn\'t mind biking through rain for your burrito cravings.',
      'nostalgic':
          'Before we tapped screens for dinner, families gathered around handwritten recipe boxes, sharing stories while stirring pots that had simmered all afternoon — meals weren\'t delivered, they were crafted.',
      'emotional':
          'Each food delivery ping was once the sound of a mother\'s footsteps in the kitchen before sunrise, preparing lunch with hands that knew exactly how much salt would make you smile.',
    },
    'instagram likes': {
      'reflective':
          'Instagram likes are what heartfelt letters and village gossip used to be — ways of saying \'I see you, I acknowledge your moment\' but compressed into a single, fleeting gesture.',
      'humble':
          'What we call \'likes\' were once neighbors pausing their day to genuinely compliment your garden, or friends walking miles just to share in your good news face-to-face.',
      'funny':
          'Instagram likes are basically the digital equivalent of your grandmother\'s friends nodding approvingly at your school photo while saying \'What a handsome young person!\'',
      'nostalgic':
          'Before double-taps, validation came from family photo albums passed around parlor rooms, where each image sparked stories and every face was remembered with love.',
      'emotional':
          'Every heart emoji was once someone taking time to write \'Thinking of you\' on paper, fold it carefully, and trust the postal service to carry their affection across miles.',
    },
  };

  void _generateAnalogy() {
    if (_textEditingController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.loc.errorEmptyInput)));
      return;
    }
    setState(() {
      _isGenerating = true;
    });
  }

  void _onAnalogyComplete() {
    final inputLower = _textEditingController.text.toLowerCase();
    String result;
    if (_mockAnalogies.containsKey(inputLower) &&
        _mockAnalogies[inputLower]!.containsKey(_selectedTone)) {
      result = _mockAnalogies[inputLower]![_selectedTone]!;
    } else {
      result =
          '"${_textEditingController.text}" today is what patient craftsmanship and community bonds were to our ancestors — a reflection of how human needs persist, even as the methods evolve with tender ingenuity.';
    }
    setState(() {
      _analogy = result;
      _isGenerating = false;
      _isFavorited = false;
    });
  }

  void _showExpandedView() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ExpandedAnalogyView(
        analogy: _analogy,
        beforeImage: _beforeImage,
        afterImage: _afterImage,
        sliderValue: _sliderValue,
        onSliderChanged: (value) => setState(() => _sliderValue = value),
        isFavorited: _isFavorited,
        onFavorite: () => setState(() => _isFavorited = !_isFavorited),
        onShare: () {},
        onRegenerate: _generateAnalogy,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      body: SafeArea(
        child: _isGenerating
            ? LoadingAnimation(
                userInput: _textEditingController.text,
                tone: _selectedTone,
                onComplete: _onAnalogyComplete,
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Header(),
                    const SizedBox(height: 30),
                    InputField(
                      controller: _textEditingController,
                      onGenerate: _generateAnalogy,
                    ),
                    const SizedBox(height: 30),
                    ToneSelection(
                      selectedTone: _selectedTone,
                      onToneSelected: (tone) =>
                          setState(() => _selectedTone = tone),
                    ),
                    const SizedBox(height: 30),
                    if (_analogy.isNotEmpty)
                      AnalogyCard(
                        analogy: _analogy,
                        beforeImage: _beforeImage,
                        afterImage: _afterImage,
                        sliderValue: _sliderValue,
                        onSliderChanged: (value) =>
                            setState(() => _sliderValue = value),
                        isFavorited: _isFavorited,
                        onFavorite: () =>
                            setState(() => _isFavorited = !_isFavorited),
                        onShare: () {},
                        onRegenerate: _generateAnalogy,
                        onExpand: _showExpandedView,
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
