//通知广播
import 'package:event_bus/event_bus.dart';

//Bus 初始化
EventBus eventBus = EventBus();

//修改姓名广播
class editMyMsgEvent{
  String str;
  editMyMsgEvent(String str){
    this.str = str;
  }
}

//树广播
class treeEvent{
  String value;
  treeEvent(String str){
    this.value = str;
  }
}

/* 新建安排 */
class newarranEvent{
  bool value;
  newarranEvent(bool boolvalue){
    this.value = boolvalue;
  }
}

