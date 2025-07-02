import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:analogy_flutter/util/extensions.dart';
@RoutePage()
class YouScreen extends StatefulWidget {
  const YouScreen({super.key});

  @override
  _YouScreenState createState() => _YouScreenState();
}

class _YouScreenState extends State<YouScreen> {
  bool _weeklyReminders = true;
  String _selectedAge = '26-35';
  final Set<String> _selectedInterests = {'Philosophy', 'Culture'};
  String _selectedMood = 'Seeking humility';

  List<String> _getAgeGroups() => [
        context.loc.ageGroup1825,
        context.loc.ageGroup2635,
        context.loc.ageGroup3650,
        context.loc.ageGroup51Plus,
      ];

  List<String> _getInterests() => [
        context.loc.interestTechnology,
        context.loc.interestPhilosophy,
        context.loc.interestCulture,
        context.loc.interestSimplicity,
        context.loc.interestHumor,
        context.loc.interestHistory,
      ];

  List<String> _getMoods() => [
        context.loc.moodSeekingHumility,
        context.loc.moodLookingForInspiration,
        context.loc.moodWantALaugh,
        context.loc.moodFeelingNostalgic,
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
               Center(
                child: Text(
                  context.loc.youTitle,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3E50),
                    fontFamily: 'serif',
                  ),
                ),
              ),
              const SizedBox(height: 6),
               Center(
                child: Text(
                  context.loc.youSubtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8B7355),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildSection(
                title: context.loc.notifications,
                icon: FeatherIcons.bell,
                child: _buildNotificationSetting(),
              ),
              const SizedBox(height: 20),
              _buildSection(
                title: context.loc.aboutYou,
                icon: FeatherIcons.user,
                child: _buildAboutYouSection(),
              ),
              const SizedBox(height: 20),
              _buildSection(
                title: context.loc.interests,
                icon: FeatherIcons.tag,
                child: _buildInterestsSection(),
              ),
              const SizedBox(height: 20),
              _buildSection(
                title: context.loc.appInfo,
                icon: FeatherIcons.info,
                child: _buildAppInfoSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
      {required String title, required IconData icon, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8DCC0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B7355).withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF8B7355), size: 20),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildNotificationSetting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.weeklyReflection,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
              SizedBox(height: 4),
              Text(
                context.loc.weeklyReflectionDesc,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8B7355),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: _weeklyReminders,
          onChanged: (value) {
            setState(() {
              _weeklyReminders = value;
            });
          },
          activeTrackColor: const Color(0xFF8B7355),
          activeColor: const Color(0xFFFAF7F2),
        ),
      ],
    );
  }

  Widget _buildAboutYouSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          context.loc.ageGroup,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _getAgeGroups()
              .map((age) => _buildOptionChip(
                    label: age,
                    isSelected: _selectedAge == age,
                    onSelected: () {
                      setState(() {
                        _selectedAge = age;
                      });
                    },
                  ))
              .toList(),
        ),
        const SizedBox(height: 20),
         Text(
          context.loc.currentMood,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: _getMoods()
              .map((mood) => _buildMoodButton(
                    label: mood,
                    isSelected: _selectedMood == mood,
                    onSelected: () {
                      setState(() {
                        _selectedMood = mood;
                      });
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildInterestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          context.loc.chooseInterests,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF8B7355),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _getInterests()
              .map((interest) => _buildOptionChip(
                    label: interest,
                    isSelected: _selectedInterests.contains(interest),
                    onSelected: () {
                      setState(() {
                        if (_selectedInterests.contains(interest)) {
                          _selectedInterests.remove(interest);
                        } else {
                          _selectedInterests.add(interest);
                        }
                      });
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildAppInfoSection() {
    return Column(
      children: [
        _buildInfoButton(
          text: context.loc.aboutApp,
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        _buildInfoButton(
          text: context.loc.supportApp,
          icon: FeatherIcons.coffee,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildOptionChip(
      {required String label,
      required bool isSelected,
      required VoidCallback onSelected}) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8B7355) : const Color(0xFFFAF7F2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF8B7355) : const Color(0xFFE8DCC0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? const Color(0xFFFAF7F2) : const Color(0xFF8B7355),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodButton(
      {required String label,
      required bool isSelected,
      required VoidCallback onSelected}) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8B7355) : const Color(0xFFFAF7F2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF8B7355) : const Color(0xFFE8DCC0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isSelected ? const Color(0xFFFAF7F2) : const Color(0xFF8B7355),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoButton(
      {required String text, IconData? icon, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF7F2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE8DCC0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: const Color(0xFF8B7355),
                size: 16,
              ),
            if (icon != null) const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8B7355),
              ),
            ),
          ],
        ),
      ),
    );
  }
}