import 'settings.dart';
import 'package:flutter/widgets.dart';

import 'language.dart';
import 'package:http/http.dart' as http;
import 'viewText.dart';
import 'app.dart';
import 'contectUs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Language lan=Language();
  await lan.initState();
  var l=lan.translate;
  String currentLang=await Language.getCurrentLanguage()??"en";
  runApp(test(lan: l,currentLang: currentLang,));
}
class test extends StatefulWidget{
  final lan;
  final currentLang;
  const test({Key?key,required this.lan,this.currentLang}):super(key:key);
  @override
  State<test> createState()=>_test(lan,currentLang);
}
class _test extends State<test>{
  var _;
  var currentLang;
  _test(this._,this.currentLang);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      locale: Locale(this.currentLang),
      title: App.name,
      themeMode: ThemeMode.system,
      home:Builder(builder:(context) 
    =>Scaffold(
      appBar:AppBar(
        title: const Text(App.name),), 
        drawer: Drawer(
          child:ListView(children: [
          DrawerHeader(child: Text(this._("navigation menu"))),
          ListTile(title:Text(this._("settings")) ,onTap:(){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>SettingsDialog(this._) ));
          } ,),
          ListTile(title: Text(this._("contect us")),onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ContectUsDialog(this._)));
          },),
          ListTile(title: Text(this._("donate")),onTap: (){
            launch("https://www.paypal.me/AMohammed231");
          },),
  ListTile(title: Text(this._("visite project on github")),onTap: (){
    launch("https://github.com/mesteranas/"+App.appName);
  },),
  ListTile(title: Text(this._("license")),onTap: ()async{
    String result;
    try{
    http.Response r=await http.get(Uri.parse("https://raw.githubusercontent.com/mesteranas/" + App.appName + "/main/LICENSE"));
    if ((r.statusCode==200)) {
      result=r.body;
    }else{
      result=this._("error");
    }
    }catch(error){
      result=this._("error");
    }
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewText(this._("license"), result)));
  },),
  ListTile(title: Text(this._("about")),onTap: (){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(title: Text(this._("about")+" "+App.name),content:Center(child:Column(children: [
        ListTile(title: Text(this._("version: ") + App.version.toString())),
        ListTile(title:Text(this._("developer:")+" mesteranas")),
        ListTile(title:Text(this._("description:") + App.description))
      ],) ,));
    });
  },)
        ],) ,),
        body:Container(alignment: Alignment.center
        ,child: Column(children: [
    ])),)));
  }
}
