// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'KRISHINOOR';

  @override
  String get welcome => 'Welcome';

  @override
  String get loginMessage => 'Please login to continue';

  @override
  String get continueButton => 'Continue';

  @override
  String get email => 'Email ID';

  @override
  String get name => 'Name';

  @override
  String get phone => 'Phone Number';

  @override
  String get language => 'Preferred Language';

  @override
  String get fillAllFields => ' Please fill all fields';

  @override
  String get homeTitle => 'Farmers of India';

  @override
  String get supplements => 'Supplements';

  @override
  String get weather => 'Weather';

  @override
  String get aiBot => 'AI Bot';

  @override
  String get noticeBoard => 'Notice Board';

  @override
  String get iotFarming => 'IoT Farming';

  @override
  String get soilHealth => 'Soil Health';

  @override
  String get marketPrices => 'Market Prices';

  @override
  String get cropProblemDetector => 'Crop Problem Detector';

  @override
  String get feedback => 'Feedback';

  @override
  String get askAIBot => 'Ask AI Bot';

  @override
  String get soilHealthTitle => 'Soil Fertility Analyzer';

  @override
  String get enterValues => '🌱 Enter Soil Test Values';

  @override
  String get phLabel => 'Soil pH (e.g., 6.5)';

  @override
  String get nLabel => 'Nitrogen (0-100)';

  @override
  String get pLabel => 'Phosphorus (0-100)';

  @override
  String get kLabel => 'Potassium (0-100)';

  @override
  String get analyzeButton => 'Analyze Soil';

  @override
  String get bestPractices => '✅ Best Practices';

  @override
  String get practice1 => 'Use organic manure to improve soil structure.';

  @override
  String get practice2 => 'Rotate crops to maintain fertility.';

  @override
  String get practice3 => 'Avoid excessive use of chemical fertilizers.';

  @override
  String get practice4 => 'Test soil every 2-3 years for better planning.';

  @override
  String get invalidValues => 'Please enter valid numeric values.';

  @override
  String get acidicSoil =>
      'Soil is acidic.\nAdd lime.\nCrops: Potato, Pineapple, Rice.';

  @override
  String get alkalineSoil =>
      'Soil is alkaline.\nAdd gypsum/organic matter.\nCrops: Cotton, Sugar beet, Barley.';

  @override
  String get goodSoil => 'Soil pH is good for most crops.';

  @override
  String get addN => 'Add Urea (Nitrogen).';

  @override
  String get addP => 'Add DAP (Phosphorus).';

  @override
  String get addK => 'Add MOP (Potassium).';

  @override
  String get balancedNPK => 'NPK levels are balanced. Maintain with compost.';

  @override
  String get marketTitle => '🌾 Market Prices';

  @override
  String get tabFertilizers => 'Fertilizers';

  @override
  String get tabSeeds => 'Seeds';

  @override
  String get tabSprays => 'Sprays';

  @override
  String get tabNutrients => 'Nutrients';

  @override
  String get bestLabel => 'Best';

  @override
  String get amazon => 'Amazon';

  @override
  String get flipkart => 'Flipkart';

  @override
  String get mandi => 'Mandi';

  @override
  String day(Object value) {
    return 'Day $value';
  }

  @override
  String get iotTitle => 'IoT-based Farming';

  @override
  String get iotDescription => 'Soil suitability analysis using IoT devices.';

  @override
  String get feedbackTitle => '💬 Feedback';

  @override
  String get feedbackHeader => 'We value your feedback 💚';

  @override
  String get yourName => 'Your Name';

  @override
  String get yourFeedback => 'Your Feedback';

  @override
  String get noImage => '📷 No image selected';

  @override
  String get uploadPhoto => 'Upload Photo';

  @override
  String get submitFeedback => 'Submit Feedback';

  @override
  String get thankYou => '🎉 Thank You!';

  @override
  String get thankYouMessage =>
      'Your feedback has been submitted successfully.\nWe appreciate your time 💚';

  @override
  String get ok => 'OK';

  @override
  String get pleaseEnter => '⚠️ Please enter name and feedback';

  @override
  String get problemDetectorTitle => 'Problem Detector';

  @override
  String get problemDescription => 'Problem Description';

  @override
  String get noImageSelected => 'No image selected';

  @override
  String get takeChooseImage => 'Take/Choose Image';

  @override
  String get upload => 'UPLOAD';

  @override
  String get addDescriptionAndImage => 'Please add description and image ❌';

  @override
  String get problemReportedSuccess => 'Problem reported successfully ✅';

  @override
  String get error => 'Error ❌ ';

  @override
  String get weatherTitle => 'Weather';

  @override
  String get farmingTip_rain =>
      '🌧 Good for paddy and rice crops. Avoid pesticide spraying today.';

  @override
  String get farmingTip_hot =>
      '☀️ Too hot! Irrigation is required to protect young plants.';

  @override
  String get farmingTip_sunny =>
      '☀️ Sunny day, good for harvesting and drying crops.';

  @override
  String get farmingTip_cloudy =>
      '🌥 Cloudy skies – good day for sowing seeds, soil moisture will remain.';

  @override
  String get farmingTip_humidity =>
      '💧 High humidity – watch out for fungal diseases in crops.';

  @override
  String get farmingTip_normal =>
      '🌱 Normal conditions – good for regular farming activities.';
}
