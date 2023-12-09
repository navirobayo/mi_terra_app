import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/getx_network_controller.dart';

class ConnectivityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ConnectionManagerController _controller =
        Get.find<ConnectionManagerController>();

    return Obx(
      () => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _controller.connectionType.value == 0
              ? Colors.redAccent
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi,
              color: _controller.connectionType.value == 1
                  ? Colors.white
                  : Colors.black,
            ),
            SizedBox(width: 8),
            Text(
              _controller.connectionType.value == 1
                  ? "WiFi Connected"
                  : _controller.connectionType.value == 2
                      ? 'Mobile Data Connected'
                      : 'No Internet',
              style: TextStyle(
                fontSize: 16,
                color: _controller.connectionType.value == 0
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
