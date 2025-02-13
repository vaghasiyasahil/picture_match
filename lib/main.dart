import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picture_match/Home_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  Preferences.setMemory();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    )
  );
}

class Preferences
{
  static SharedPreferences ?prefs;
  static Future<void> setMemory() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void setNoTimeLimitLevel(int levelNum)
  {
    prefs?.setInt("NoTimeLimit", levelNum);
  }
  static int getNoTimeLimitLevel()
  {
    return prefs?.getInt("NoTimeLimit")??1;
  }

  static void setNormalLevel(int levelNum)
  {
    prefs?.setInt("Normal", levelNum);
  }
  static void setNormalList(List<String> level){
    prefs?.setStringList("NormalList", level);
  }
  static List<String>getNormalList(){
    return prefs?.getStringList("NormalList")??List.filled(60, "");
  }
  static int getNormalLevel()
  {
    return prefs?.getInt("Normal")??1;
  }

  static void setHardLevel(int levelNum)
  {
    prefs?.setInt("Hard", levelNum);
  }
  static void setHardList(List<String> level){
    prefs?.setStringList("HardList", level);
  }
  static List<String>getHardList(){
    return prefs?.getStringList("HardList")??List.filled(60, "");
  }
  static int getHardLevel()
  {
    return prefs?.getInt("Hard")??1;
  }
}