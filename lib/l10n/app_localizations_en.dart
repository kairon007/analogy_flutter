// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Analogy';

  @override
  String get appSubtitle => 'What was this like… back in the day?';

  @override
  String get inputPrompt => 'What modern thing are you curious about?';

  @override
  String get inputHint => 'e.g., food delivery, Instagram likes...';

  @override
  String get toneSelectionTitle => 'Choose your lens';

  @override
  String get toneReflective => 'Reflective';

  @override
  String get toneHumble => 'Humble';

  @override
  String get toneFunny => 'Funny';

  @override
  String get toneNostalgic => 'Nostalgic';

  @override
  String get toneEmotional => 'Emotional';

  @override
  String get errorEmptyInput => 'Please enter something to get an analogy.';

  @override
  String get buttonGenerate => 'Generate Analogy';

  @override
  String get shareButton => 'Share';

  @override
  String get saveButton => 'Save';

  @override
  String get savedButton => 'Saved';

  @override
  String get newAnalogyButton => 'New Analogy';

  @override
  String get exploreTitle => 'Explore Analogies';

  @override
  String get exploreSubtitle => 'Curated wisdom from past and present';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryLove => 'Love';

  @override
  String get categoryWork => 'Work';

  @override
  String get categoryTechnology => 'Technology';

  @override
  String get categoryLeisure => 'Leisure';

  @override
  String get savedTitle => 'Your Collection';

  @override
  String savedSubtitle(Object count) {
    return '$count saved analogies for reflection';
  }

  @override
  String get savedEmptyTitle => 'No saved analogies yet';

  @override
  String get savedEmptyMessage => 'Tap the heart icon on any analogy to save it here for later reflection.';

  @override
  String savedDatePrefix(Object date) {
    return 'Saved $date';
  }

  @override
  String get deleteButton => 'Delete';

  @override
  String get youTitle => 'Your Preferences';

  @override
  String get youSubtitle => 'Personalize your analogy experience';

  @override
  String get notifications => 'Notifications';

  @override
  String get weeklyReflection => 'Weekly Reflection';

  @override
  String get weeklyReflectionDesc => 'Get a thoughtful analogy every Sunday to reflect on the week';

  @override
  String get aboutYou => 'About You';

  @override
  String get ageGroup => 'Age Group';

  @override
  String get currentMood => 'Current Mood';

  @override
  String get interests => 'Interests';

  @override
  String get chooseInterests => 'Choose topics that resonate with you (select multiple)';

  @override
  String get appInfo => 'App Info';

  @override
  String get aboutApp => 'About Analogy';

  @override
  String get supportApp => 'Support the App';

  @override
  String get moodSeekingHumility => 'Seeking humility';

  @override
  String get moodLookingForInspiration => 'Looking for inspiration';

  @override
  String get moodWantALaugh => 'Want a laugh';

  @override
  String get moodFeelingNostalgic => 'Feeling nostalgic';

  @override
  String get interestTechnology => 'Technology';

  @override
  String get interestPhilosophy => 'Philosophy';

  @override
  String get interestCulture => 'Culture';

  @override
  String get interestSimplicity => 'Simplicity';

  @override
  String get interestHumor => 'Humor';

  @override
  String get interestHistory => 'History';

  @override
  String get ageGroup1825 => '18-25';

  @override
  String get ageGroup2635 => '26-35';

  @override
  String get ageGroup3650 => '36-50';

  @override
  String get ageGroup51Plus => '51+';
}
