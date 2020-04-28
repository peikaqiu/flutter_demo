//状态存储
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const sessionName = "CUCLUBSESSION_RELEASE";

class Session{
  static Future<void> setSession(value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(sessionName, value);
  }
  static Future<String> getSession() async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    return sp.getString(sessionName);
  } 
  static Future<void> removeSession() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(sessionName);
  }
  static Future<void> clearSession() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
  static Future getToken() async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    return json.decode(sp.getString(sessionName))['token'];
  }
}

//使用方式
//1.引包    import '../../base/Session.dart';

//2.设置值：onTap: () async{
//              await Session.setSession('{"token":"429d88b8b9474de3adcc52e0c7e95761"}');
//          },

//3.获取值  onTap: () async{
//              var searchList = await Session.getSession();
//              print('$searchList');
//          },

//4.清空单个数据 onTap: () async{
//                await Session.removeSession();
//              },

//5.清空所有值onTap: () async{
//              await Session.clearSession();
//            },

//获取token onTap: () async{
//              var session = await Session.getToken();
//              print(session);
//          }, 