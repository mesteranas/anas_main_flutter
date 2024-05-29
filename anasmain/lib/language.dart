import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
class Language {
  String languageCode;
  var content;

  Language(this.languageCode);

  Future<void> initState() async {
    await updateContent();
  }
  Future <void> updateContent() async{
        try {
      final data = await rootBundle.loadString('assets/i18n/$languageCode.json');
      content = jsonDecode(data);
    } catch (error) {
      print("Error loading language file: $error");
      content = {};
    }
  }
  String translate(String text){
    try{
      return content[text];
    } catch(error){
      return text;
    }
  }
}