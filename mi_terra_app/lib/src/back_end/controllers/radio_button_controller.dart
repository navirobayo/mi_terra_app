import 'package:get/get.dart';

class ButtonController extends GetxController {
  String _orderType = 'Gasto general';
  String get orderType => _orderType;

  void setOrderType(String type) {
    _orderType = type;
    print("The order type is $_orderType");
    update();
  }
}
