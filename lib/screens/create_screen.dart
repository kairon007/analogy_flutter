import 'package:analogy_flutter/util/extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:before_after/before_after.dart';
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
  double _sliderValue = 0.5;
  String _beforeImage = 'assets/images/before.jpg';
  String _afterImage = 'assets/images/after.jpg';
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

  void _showExpandedView() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          color: Colors.white,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Full Before-After in bottom sheet
                  GestureDetector(
                    onTap: () {
                      // Optional: Tap to expand image even in bottom sheet

                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BeforeAfter(
                        before: Image.asset(_beforeImage, fit: BoxFit.cover),
                        after: Image.asset(_afterImage, fit: BoxFit.cover),
                        value: _sliderValue,
                        onValueChanged: (value) => setState(() => _sliderValue = value),
                        thumbColor: const Color(0xFF8B7355),
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Full text
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
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActionButton(
                        icon: _isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorited ? const Color(0xFFD2691E) : const Color(0xFF8B7355),
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
          ),
        ),
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
                    Center(
                      child: Text(
                        context.loc.appTitle,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3E50),
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        context.loc.appSubtitle,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF8B7355),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      context.loc.inputPrompt,
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
                              decoration: InputDecoration(
                                hintText: context.loc.inputHint,
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
                    Text(
                      context.loc.toneSelectionTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildToneButton(
                            'reflective',
                            context.loc.toneReflective,
                            '🧘',
                          ),
                          _buildToneButton(
                            'humble',
                            context.loc.toneHumble,
                            '🙏',
                          ),
                          _buildToneButton(
                            'funny',
                            context.loc.toneFunny,
                            '😂',
                          ),
                          _buildToneButton(
                            'nostalgic',
                            context.loc.toneNostalgic,
                            '🕰️',
                          ),
                          _buildToneButton(
                            'emotional',
                            context.loc.toneEmotional,
                            '❤️',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (_analogy.isNotEmpty)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Container(
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
                          clipBehavior: Clip.hardEdge, // Prevent overflow clipping if needed
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final availableHeight = constraints.maxHeight;
                              const spacing = 20.0;
                              const estimatedButtonHeight = 48.0; // Approximate height of the Row (adjust based on your button size)
                              const estimatedExpandButtonHeight = 32.0; // Height for the expand button
                              final textLineHeight = 17 * 1.5; // Font size * line height for two lines
                              final textHeight = textLineHeight * 2;

                              return Column(
                                children: [
                                  // Before-After comparison section with adjusted height
                                  SizedBox(
                                    height: availableHeight - textHeight - (spacing * 3) - estimatedButtonHeight - estimatedExpandButtonHeight,
                                    child: Stack(
                                      children: [
                                        // Clickable image area
                                        Positioned.fill(
                                          child: GestureDetector(
                                            onTap: _showExpandedView,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(12),
                                              child: BeforeAfter(
                                                before: Image.asset(_beforeImage, fit: BoxFit.cover),
                                                after: Image.asset(_afterImage, fit: BoxFit.cover),
                                                value: _sliderValue,
                                                onValueChanged: (value) => setState(() => _sliderValue = value),
                                                thumbColor: const Color(0xFF8B7355),
                                                overlayColor: MaterialStateProperty.all(Colors.transparent),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: spacing),
                                  // Text section: Show only two lines with ellipsis
                                  GestureDetector(child: Text(
                                    _analogy,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      height: 1.5,
                                      color: Color(0xFF2C3E50),
                                      fontFamily: 'serif',
                                    ),
                                  ),onTap:(){_showExpandedView();}),
                                  // Expand button for full card content in bottom sheet

                                  const SizedBox(height: spacing),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildActionButton(
                                        icon: _isFavorited ? Icons.favorite : Icons.favorite_border,
                                        color: _isFavorited ? const Color(0xFFD2691E) : const Color(0xFF8B7355),
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
                              );
                            },
                          ),
                        ),
                      )

                  ],
                ),
              ),
      ),
    );
  }

  double _calculateMaxButtonWidth() {
    // Find the longest label text
    final labels = [
      context.loc.toneReflective,
      context.loc.toneHumble,
      context.loc.toneFunny,
      context.loc.toneNostalgic,
      context.loc.toneEmotional,
    ];

    double maxWidth = 0;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (final label in labels) {
      textPainter.text = TextSpan(
        text: label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      );
      textPainter.layout();
      maxWidth = textPainter.width > maxWidth ? textPainter.width : maxWidth;
    }

    // Add padding (16 on each side) and some extra space
    return maxWidth + 48;
  }

  Widget _buildToneButton(String tone, String label, String emoji) {
    final bool isActive = _selectedTone == tone;
    final double buttonWidth = _calculateMaxButtonWidth();

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTone = tone;
        });
      },
      child: Container(
        width: buttonWidth,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF8B7355) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? const Color(0xFF8B7355) : const Color(0xFFE8DCC0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
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
