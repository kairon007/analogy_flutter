import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Analogy'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'What was this like… back in the day?'**
  String get appSubtitle;

  /// No description provided for @inputPrompt.
  ///
  /// In en, this message translates to:
  /// **'What modern thing are you curious about?'**
  String get inputPrompt;

  /// No description provided for @inputHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., food delivery, Instagram likes...'**
  String get inputHint;

  /// No description provided for @toneSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your lens'**
  String get toneSelectionTitle;

  /// No description provided for @toneReflective.
  ///
  /// In en, this message translates to:
  /// **'Reflective'**
  String get toneReflective;

  /// No description provided for @toneHumble.
  ///
  /// In en, this message translates to:
  /// **'Humble'**
  String get toneHumble;

  /// No description provided for @toneFunny.
  ///
  /// In en, this message translates to:
  /// **'Funny'**
  String get toneFunny;

  /// No description provided for @toneNostalgic.
  ///
  /// In en, this message translates to:
  /// **'Nostalgic'**
  String get toneNostalgic;

  /// No description provided for @toneEmotional.
  ///
  /// In en, this message translates to:
  /// **'Emotional'**
  String get toneEmotional;

  /// No description provided for @errorEmptyInput.
  ///
  /// In en, this message translates to:
  /// **'Please enter something to get an analogy.'**
  String get errorEmptyInput;

  /// No description provided for @buttonGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate Analogy'**
  String get buttonGenerate;

  /// No description provided for @shareButton.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareButton;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @savedButton.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get savedButton;

  /// No description provided for @newAnalogyButton.
  ///
  /// In en, this message translates to:
  /// **'New Analogy'**
  String get newAnalogyButton;

  /// No description provided for @exploreTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore Analogies'**
  String get exploreTitle;

  /// No description provided for @exploreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Curated wisdom from past and present'**
  String get exploreSubtitle;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryLove.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get categoryLove;

  /// No description provided for @categoryWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get categoryWork;

  /// No description provided for @categoryTechnology.
  ///
  /// In en, this message translates to:
  /// **'Technology'**
  String get categoryTechnology;

  /// No description provided for @categoryLeisure.
  ///
  /// In en, this message translates to:
  /// **'Leisure'**
  String get categoryLeisure;

  /// No description provided for @savedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Collection'**
  String get savedTitle;

  /// No description provided for @savedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} saved analogies for reflection'**
  String savedSubtitle(Object count);

  /// No description provided for @savedEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No saved analogies yet'**
  String get savedEmptyTitle;

  /// No description provided for @savedEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart icon on any analogy to save it here for later reflection.'**
  String get savedEmptyMessage;

  /// No description provided for @savedDatePrefix.
  ///
  /// In en, this message translates to:
  /// **'Saved {date}'**
  String savedDatePrefix(Object date);

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @youTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Preferences'**
  String get youTitle;

  /// No description provided for @youSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Personalize your analogy experience'**
  String get youSubtitle;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @weeklyReflection.
  ///
  /// In en, this message translates to:
  /// **'Weekly Reflection'**
  String get weeklyReflection;

  /// No description provided for @weeklyReflectionDesc.
  ///
  /// In en, this message translates to:
  /// **'Get a thoughtful analogy every Sunday to reflect on the week'**
  String get weeklyReflectionDesc;

  /// No description provided for @aboutYou.
  ///
  /// In en, this message translates to:
  /// **'About You'**
  String get aboutYou;

  /// No description provided for @ageGroup.
  ///
  /// In en, this message translates to:
  /// **'Age Group'**
  String get ageGroup;

  /// No description provided for @currentMood.
  ///
  /// In en, this message translates to:
  /// **'Current Mood'**
  String get currentMood;

  /// No description provided for @interests.
  ///
  /// In en, this message translates to:
  /// **'Interests'**
  String get interests;

  /// No description provided for @chooseInterests.
  ///
  /// In en, this message translates to:
  /// **'Choose topics that resonate with you (select multiple)'**
  String get chooseInterests;

  /// No description provided for @appInfo.
  ///
  /// In en, this message translates to:
  /// **'App Info'**
  String get appInfo;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About Analogy'**
  String get aboutApp;

  /// No description provided for @supportApp.
  ///
  /// In en, this message translates to:
  /// **'Support the App'**
  String get supportApp;

  /// No description provided for @moodSeekingHumility.
  ///
  /// In en, this message translates to:
  /// **'Seeking humility'**
  String get moodSeekingHumility;

  /// No description provided for @moodLookingForInspiration.
  ///
  /// In en, this message translates to:
  /// **'Looking for inspiration'**
  String get moodLookingForInspiration;

  /// No description provided for @moodWantALaugh.
  ///
  /// In en, this message translates to:
  /// **'Want a laugh'**
  String get moodWantALaugh;

  /// No description provided for @moodFeelingNostalgic.
  ///
  /// In en, this message translates to:
  /// **'Feeling nostalgic'**
  String get moodFeelingNostalgic;

  /// No description provided for @interestTechnology.
  ///
  /// In en, this message translates to:
  /// **'Technology'**
  String get interestTechnology;

  /// No description provided for @interestPhilosophy.
  ///
  /// In en, this message translates to:
  /// **'Philosophy'**
  String get interestPhilosophy;

  /// No description provided for @interestCulture.
  ///
  /// In en, this message translates to:
  /// **'Culture'**
  String get interestCulture;

  /// No description provided for @interestSimplicity.
  ///
  /// In en, this message translates to:
  /// **'Simplicity'**
  String get interestSimplicity;

  /// No description provided for @interestHumor.
  ///
  /// In en, this message translates to:
  /// **'Humor'**
  String get interestHumor;

  /// No description provided for @interestHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get interestHistory;

  /// No description provided for @ageGroup1825.
  ///
  /// In en, this message translates to:
  /// **'18-25'**
  String get ageGroup1825;

  /// No description provided for @ageGroup2635.
  ///
  /// In en, this message translates to:
  /// **'26-35'**
  String get ageGroup2635;

  /// No description provided for @ageGroup3650.
  ///
  /// In en, this message translates to:
  /// **'36-50'**
  String get ageGroup3650;

  /// No description provided for @ageGroup51Plus.
  ///
  /// In en, this message translates to:
  /// **'51+'**
  String get ageGroup51Plus;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
