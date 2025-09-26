import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_or.dart';
import 'app_localizations_pa.dart';

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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('or'),
    Locale('pa')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'KRISHINOOR'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @loginMessage.
  ///
  /// In en, this message translates to:
  /// **'Please login to continue'**
  String get loginMessage;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email ID'**
  String get email;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Preferred Language'**
  String get language;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **' Please fill all fields'**
  String get fillAllFields;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Farmers of India'**
  String get homeTitle;

  /// No description provided for @supplements.
  ///
  /// In en, this message translates to:
  /// **'Supplements'**
  String get supplements;

  /// No description provided for @weather.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weather;

  /// No description provided for @aiBot.
  ///
  /// In en, this message translates to:
  /// **'AI Bot'**
  String get aiBot;

  /// No description provided for @noticeBoard.
  ///
  /// In en, this message translates to:
  /// **'Notice Board'**
  String get noticeBoard;

  /// No description provided for @iotFarming.
  ///
  /// In en, this message translates to:
  /// **'IoT Farming'**
  String get iotFarming;

  /// No description provided for @soilHealth.
  ///
  /// In en, this message translates to:
  /// **'Soil Health'**
  String get soilHealth;

  /// No description provided for @marketPrices.
  ///
  /// In en, this message translates to:
  /// **'Market Prices'**
  String get marketPrices;

  /// No description provided for @cropProblemDetector.
  ///
  /// In en, this message translates to:
  /// **'Crop Problem Detector'**
  String get cropProblemDetector;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @askAIBot.
  ///
  /// In en, this message translates to:
  /// **'Ask AI Bot'**
  String get askAIBot;

  /// No description provided for @soilHealthTitle.
  ///
  /// In en, this message translates to:
  /// **'Soil Fertility Analyzer'**
  String get soilHealthTitle;

  /// No description provided for @enterValues.
  ///
  /// In en, this message translates to:
  /// **'🌱 Enter Soil Test Values'**
  String get enterValues;

  /// No description provided for @phLabel.
  ///
  /// In en, this message translates to:
  /// **'Soil pH (e.g., 6.5)'**
  String get phLabel;

  /// No description provided for @nLabel.
  ///
  /// In en, this message translates to:
  /// **'Nitrogen (0-100)'**
  String get nLabel;

  /// No description provided for @pLabel.
  ///
  /// In en, this message translates to:
  /// **'Phosphorus (0-100)'**
  String get pLabel;

  /// No description provided for @kLabel.
  ///
  /// In en, this message translates to:
  /// **'Potassium (0-100)'**
  String get kLabel;

  /// No description provided for @analyzeButton.
  ///
  /// In en, this message translates to:
  /// **'Analyze Soil'**
  String get analyzeButton;

  /// No description provided for @bestPractices.
  ///
  /// In en, this message translates to:
  /// **'✅ Best Practices'**
  String get bestPractices;

  /// No description provided for @practice1.
  ///
  /// In en, this message translates to:
  /// **'Use organic manure to improve soil structure.'**
  String get practice1;

  /// No description provided for @practice2.
  ///
  /// In en, this message translates to:
  /// **'Rotate crops to maintain fertility.'**
  String get practice2;

  /// No description provided for @practice3.
  ///
  /// In en, this message translates to:
  /// **'Avoid excessive use of chemical fertilizers.'**
  String get practice3;

  /// No description provided for @practice4.
  ///
  /// In en, this message translates to:
  /// **'Test soil every 2-3 years for better planning.'**
  String get practice4;

  /// No description provided for @invalidValues.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid numeric values.'**
  String get invalidValues;

  /// No description provided for @acidicSoil.
  ///
  /// In en, this message translates to:
  /// **'Soil is acidic.\nAdd lime.\nCrops: Potato, Pineapple, Rice.'**
  String get acidicSoil;

  /// No description provided for @alkalineSoil.
  ///
  /// In en, this message translates to:
  /// **'Soil is alkaline.\nAdd gypsum/organic matter.\nCrops: Cotton, Sugar beet, Barley.'**
  String get alkalineSoil;

  /// No description provided for @goodSoil.
  ///
  /// In en, this message translates to:
  /// **'Soil pH is good for most crops.'**
  String get goodSoil;

  /// No description provided for @addN.
  ///
  /// In en, this message translates to:
  /// **'Add Urea (Nitrogen).'**
  String get addN;

  /// No description provided for @addP.
  ///
  /// In en, this message translates to:
  /// **'Add DAP (Phosphorus).'**
  String get addP;

  /// No description provided for @addK.
  ///
  /// In en, this message translates to:
  /// **'Add MOP (Potassium).'**
  String get addK;

  /// No description provided for @balancedNPK.
  ///
  /// In en, this message translates to:
  /// **'NPK levels are balanced. Maintain with compost.'**
  String get balancedNPK;

  /// No description provided for @marketTitle.
  ///
  /// In en, this message translates to:
  /// **'🌾 Market Prices'**
  String get marketTitle;

  /// No description provided for @tabFertilizers.
  ///
  /// In en, this message translates to:
  /// **'Fertilizers'**
  String get tabFertilizers;

  /// No description provided for @tabSeeds.
  ///
  /// In en, this message translates to:
  /// **'Seeds'**
  String get tabSeeds;

  /// No description provided for @tabSprays.
  ///
  /// In en, this message translates to:
  /// **'Sprays'**
  String get tabSprays;

  /// No description provided for @tabNutrients.
  ///
  /// In en, this message translates to:
  /// **'Nutrients'**
  String get tabNutrients;

  /// No description provided for @bestLabel.
  ///
  /// In en, this message translates to:
  /// **'Best'**
  String get bestLabel;

  /// No description provided for @amazon.
  ///
  /// In en, this message translates to:
  /// **'Amazon'**
  String get amazon;

  /// No description provided for @flipkart.
  ///
  /// In en, this message translates to:
  /// **'Flipkart'**
  String get flipkart;

  /// No description provided for @mandi.
  ///
  /// In en, this message translates to:
  /// **'Mandi'**
  String get mandi;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day {value}'**
  String day(Object value);

  /// No description provided for @iotTitle.
  ///
  /// In en, this message translates to:
  /// **'IoT-based Farming'**
  String get iotTitle;

  /// No description provided for @iotDescription.
  ///
  /// In en, this message translates to:
  /// **'Soil suitability analysis using IoT devices.'**
  String get iotDescription;

  /// No description provided for @feedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'💬 Feedback'**
  String get feedbackTitle;

  /// No description provided for @feedbackHeader.
  ///
  /// In en, this message translates to:
  /// **'We value your feedback 💚'**
  String get feedbackHeader;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get yourName;

  /// No description provided for @yourFeedback.
  ///
  /// In en, this message translates to:
  /// **'Your Feedback'**
  String get yourFeedback;

  /// No description provided for @noImage.
  ///
  /// In en, this message translates to:
  /// **'📷 No image selected'**
  String get noImage;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get uploadPhoto;

  /// No description provided for @submitFeedback.
  ///
  /// In en, this message translates to:
  /// **'Submit Feedback'**
  String get submitFeedback;

  /// No description provided for @thankYou.
  ///
  /// In en, this message translates to:
  /// **'🎉 Thank You!'**
  String get thankYou;

  /// No description provided for @thankYouMessage.
  ///
  /// In en, this message translates to:
  /// **'Your feedback has been submitted successfully.\nWe appreciate your time 💚'**
  String get thankYouMessage;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @pleaseEnter.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Please enter name and feedback'**
  String get pleaseEnter;

  /// No description provided for @problemDetectorTitle.
  ///
  /// In en, this message translates to:
  /// **'Problem Detector'**
  String get problemDetectorTitle;

  /// No description provided for @problemDescription.
  ///
  /// In en, this message translates to:
  /// **'Problem Description'**
  String get problemDescription;

  /// No description provided for @noImageSelected.
  ///
  /// In en, this message translates to:
  /// **'No image selected'**
  String get noImageSelected;

  /// No description provided for @takeChooseImage.
  ///
  /// In en, this message translates to:
  /// **'Take/Choose Image'**
  String get takeChooseImage;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'UPLOAD'**
  String get upload;

  /// No description provided for @addDescriptionAndImage.
  ///
  /// In en, this message translates to:
  /// **'Please add description and image ❌'**
  String get addDescriptionAndImage;

  /// No description provided for @problemReportedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Problem reported successfully ✅'**
  String get problemReportedSuccess;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error ❌ '**
  String get error;

  /// No description provided for @weatherTitle.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weatherTitle;

  /// No description provided for @farmingTip_rain.
  ///
  /// In en, this message translates to:
  /// **'🌧 Good for paddy and rice crops. Avoid pesticide spraying today.'**
  String get farmingTip_rain;

  /// No description provided for @farmingTip_hot.
  ///
  /// In en, this message translates to:
  /// **'☀️ Too hot! Irrigation is required to protect young plants.'**
  String get farmingTip_hot;

  /// No description provided for @farmingTip_sunny.
  ///
  /// In en, this message translates to:
  /// **'☀️ Sunny day, good for harvesting and drying crops.'**
  String get farmingTip_sunny;

  /// No description provided for @farmingTip_cloudy.
  ///
  /// In en, this message translates to:
  /// **'🌥 Cloudy skies – good day for sowing seeds, soil moisture will remain.'**
  String get farmingTip_cloudy;

  /// No description provided for @farmingTip_humidity.
  ///
  /// In en, this message translates to:
  /// **'💧 High humidity – watch out for fungal diseases in crops.'**
  String get farmingTip_humidity;

  /// No description provided for @farmingTip_normal.
  ///
  /// In en, this message translates to:
  /// **'🌱 Normal conditions – good for regular farming activities.'**
  String get farmingTip_normal;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'or', 'pa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'or':
      return AppLocalizationsOr();
    case 'pa':
      return AppLocalizationsPa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
