import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:analogy_flutter/components/loading_animation.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter something to get an analogy.'),
        ),
      );
      return;
    }
    setState(() {
      _isGenerating = true;
    });
    // The actual analogy generation will happen in _onAnalogyComplete after the animation.
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
                    const Center(
                      child: Text(
                        'Analogy',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3E50),
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        'What was this like… back in the day?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF8B7355),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'What modern thing are you curious about?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE8DCC0),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8B7355).withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textEditingController,
                              decoration: const InputDecoration(
                                hintText:
                                    'e.g., food delivery, Instagram likes...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _generateAnalogy,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF8B7355),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                FeatherIcons.search,
                                color: Color(0xFFFAF7F2),
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Choose your lens',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildToneButton('reflective', 'Reflective', '🧘'),
                          _buildToneButton('humble', 'Humble', '🙏'),
                          _buildToneButton('funny', 'Funny', '😂'),
                          _buildToneButton('nostalgic', 'Nostalgic', '🕰️'),
                          _buildToneButton('emotional', 'Emotional', '❤️'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (_analogy.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE8DCC0)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8B7355).withOpacity(0.15),
                              spreadRadius: 4,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              _analogy,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 17,
                                height: 1.5,
                                color: Color(0xFF2C3E50),
                                fontFamily: 'serif',
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildActionButton(
                                  icon: _isFavorited
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _isFavorited
                                      ? const Color(0xFFD2691E)
                                      : const Color(0xFF8B7355),
                                  onPressed: () {
                                    setState(() {
                                      _isFavorited = !_isFavorited;
                                    });
                                  },
                                ),
                                const SizedBox(width: 20),
                                _buildActionButton(
                                  icon: FeatherIcons.share,
                                  color: const Color(0xFF8B7355),
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 20),
                                _buildActionButton(
                                  icon: FeatherIcons.rotateCcw,
                                  color: const Color(0xFF8B7355),
                                  onPressed: _generateAnalogy,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildToneButton(String tone, String label, String emoji) {
    final bool isActive = _selectedTone == tone;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTone = tone;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF8B7355) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? const Color(0xFF8B7355) : const Color(0xFFE8DCC0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive
                    ? const Color(0xFFFAF7F2)
                    : const Color(0xFF8B7355),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF7F2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE8DCC0)),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}