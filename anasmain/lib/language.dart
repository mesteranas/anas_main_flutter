import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
class Language {
  var languageCode;
  var content;
  var supportedLanguages={"english":"en","arabic":"ar"};


  Future<void> initState() async {
    await getCurrentLanguage();
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
  Future <String> getCurrentLanguage() async{
    final berfs=await SharedPreferences.getInstance();
    languageCode=berfs.getString("language")??"en";
    return languageCode;
  }

}