//http封装
import 'package:dio/dio.dart';
import 'dart:async';
import 'Session.dart';

// const serviceUrl = 'http://47.111.190.231:9351'; //请求url头

class Http{
  static Http instance;
  static String token;
  // static const String API_PREFIX = serviceUrl;
  static const int CONNECT_TIMEOUT = 10000;//链接超时
  static const int RECEIVE_TIMEOUT = 3000;//接收超时
  static Dio _dio;


  Http(){
    // 全局属性：请求前缀、连接超时时间、响应超时时间
     var _options = BaseOptions(
        //  baseUrl: API_PREFIX,
         connectTimeout: CONNECT_TIMEOUT,
         receiveTimeout: RECEIVE_TIMEOUT,
     );

    _dio = new Dio(_options);

    //发送请求拦截处理，例如：添加token使用
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options){
            // 在发送请求之前做一些预处理
            //在发送前到SharedPreferences（本地存储）中取出token的值，然后添加到请求头中
            //dio.lock()是先锁定请求不发送出去，当整个取值添加到请求头后再dio.unlock()解锁发送出去
            _dio.lock();
            Future<dynamic> future = Future(()async{
              var token = '80fa640ac0c042a7b2e2927f054a2a30';
                // var token = await Session.getToken();//获取token
                return token;
            });
            return future.then((value) {
                // print(value);
                options.headers["AuthToken"] = value;
                return options;
            }).whenComplete(() => _dio.unlock()); // unlock the dio
        },
        onResponse:(Response response) {
            // 在返回响应数据之前做一些预处理
            return response; // continue
        },
        onError: (DioError e) {
            // 当请求失败时做一些预处理
            return e;//continue
        }
    ));
  }


  
  //POST封装
  Future post(url,{ options, data=null}) async {
    Response response;
    try{
      response = await _dio.post(
          url,
          data:data !=null ? data : {},
      );
      if(response.statusCode == 200){
        return response.data;
      }else{
        throw Exception('接口异常');
      }
    }on DioError catch(e){
        print('ERROR: =================> ${e}');
    }
  }
}

//使用方式：

//1.引入请求url文件 如：import '../../config/chat_requestUrl.dart';

//2.开始请求
// getListFunc() async {
//   //请求
//   Http().post(servicePath['people'],
//       data: {"pageSize": 10, "pageCur": 1, "emp_status": 32}).then((val) {
//         print(val['code']);
//         setState(() {
//           contnet = val['payload'].toString();
//         });
//   });
// }

