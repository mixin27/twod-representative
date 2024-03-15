import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

// https://m.me/$FaceBook_Name?text=$Message_to_be_sent
// viber://chat/?number=$Country_Code$Mobile_Number&draft=$Message_to_be_sen
// https://t.me/+$Country_Code$Mobile_Number&draft=$Message_to_be_sen

/// A utility method to open SMS Messenger on different devices
/// Optionality you can add [text] message
Future<void> openSMS({
  required String phone,
  String? text,
  LaunchMode mode = LaunchMode.externalApplication,
}) async {
  final String effectivePhone = Platform.isAndroid
      ? phone.replaceAll('-', ' ')
      : phone.replaceFirst('+', '');

  final String effectiveText =
      Platform.isAndroid ? '?body=$text' : '&body=$text';

  final String url = 'sms:$effectivePhone';

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse('$url$effectiveText'), mode: mode);
  } else {
    throw Exception('openSMS could not launching url: $url');
  }
}

/// A utility method to open WhatsApp on different devices
/// Optionality you can add [text] message
Future<void> openWhatsApp({
  required String phone,
  String? text,
  LaunchMode mode = LaunchMode.externalApplication,
}) async {
  final String textIOS = text != null ? Uri.encodeFull('?text=$text') : '';
  final String textAndroid = text != null ? Uri.encodeFull('&text=$text') : '';

  final String urlIOS = 'https://wa.me/$phone$textIOS';
  final String urlAndroid = 'whatsapp://send/?phone=$phone$textAndroid';

  final String effectiveURL = Platform.isIOS ? urlIOS : urlAndroid;

  if (await canLaunchUrl(Uri.parse(effectiveURL))) {
    await launchUrl(Uri.parse(effectiveURL), mode: mode);
  } else {
    throw Exception('openWhatsApp could not launching url: $effectiveURL');
  }
}

/// A utility method to open WhatsApp on different devices
/// Optionality you can add [text] message
Future<void> openTelegram({
  required String phone,
  String? text,
  LaunchMode mode = LaunchMode.externalApplication,
}) async {
  //  https://t.me/+$Country_Code$Mobile_Number&draft=$Message_to_be_sen
  // const String url = 'https://t.me';

  // Phone no link(tg syntax): tg://resolve?phone=<phone_number>
  const String url = 'tg://resolve?phone=';
  final String? effectiveText =
      text != null && text.isNotEmpty ? '&text=${Uri.encodeFull(text)}' : null;

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
      // Uri.parse('$url/$phone$effectiveText'),
      Uri.parse('$url+$phone$effectiveText'),
      mode: mode,
    );
  } else {
    throw Exception(
        'openTelegram could not launching url: $url?to=+$phone$effectiveText');
  }
}

/// A utility method to open WhatsApp on different devices
/// Optionality you can add [text] message
Future<void> openViber({
  required String phone,
  String? text,
  LaunchMode mode = LaunchMode.externalApplication,
}) async {
  // Direct 1on1 Chat: viber://pa?chatURI=<URI>&context=<Your Context>&text=<Your Text>
  // Info Screen: viber://pa/info?uri=<URI>
  // final String url = 'viber://pa/info?uri=$phone';
  final String url = 'viber://pa?chatURI=$phone';
  final String effectiveURL = text != null && text.isNotEmpty
      ? '$url&context=Beads Math&text=${Uri.encodeFull(text)}'
      : url;

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
      Uri.parse(effectiveURL),
      mode: mode,
    );
  } else {
    throw Exception('openViber could not launching url: $effectiveURL');
  }
}
