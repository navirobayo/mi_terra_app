import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/getx_network_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}
