class UserSettings {
  final bool weeklyReminders;
  final String ageGroup;
  final Set<String> interests;
  final String mood;

  const UserSettings({
    this.weeklyReminders = true,
    this.ageGroup = '26-35',
    this.interests = const {'Philosophy', 'Culture'},
    this.mood = 'Seeking humility',
  });

  UserSettings copyWith({
    bool? weeklyReminders,
    String? ageGroup,
    Set<String>? interests,
    String? mood,
  }) {
    return UserSettings(
      weeklyReminders: weeklyReminders ?? this.weeklyReminders,
      ageGroup: ageGroup ?? this.ageGroup,
      interests: interests ?? this.interests,
      mood: mood ?? this.mood,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weeklyReminders': weeklyReminders,
      'ageGroup': ageGroup,
      'interests': interests.toList(),
      'mood': mood,
    };
  }

  factory UserSettings.fromMap(Map<String, dynamic> map) {
    return UserSettings(
      weeklyReminders: map['weeklyReminders'] as bool? ?? true,
      ageGroup: map['ageGroup'] as String? ?? '26-35',
      interests: Set<String>.from(map['interests'] as List? ?? ['Philosophy', 'Culture']),
      mood: map['mood'] as String? ?? 'Seeking humility',
    );
  }

  // Generate a prompt for the AI agent
  String toAIPrompt() {
    return """
    User Profile:
    - Age Group: $ageGroup
    - Interests: ${interests.join(', ')}
    - Current Mood: $mood
    - Receives Weekly Reminders: ${weeklyReminders ? 'Yes' : 'No'}
    """;
  }
}
