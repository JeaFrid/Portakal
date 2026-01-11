import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class PortakalTools {
  static Future<void> copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  static Future<String?> paste() async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }

  static Future<void> openURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      throw Exception("PortakalTools: URL açılamadı -> $e");
    }
  }
}