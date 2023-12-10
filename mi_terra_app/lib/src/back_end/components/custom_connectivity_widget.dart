import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mi_terra_app/src/back_end/controllers/getx_network_controller.dart';

class ConnectivityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ConnectionManagerController _controller =
        Get.find<ConnectionManagerController>();

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            child: Text(
              _controller.connectionType.value == 1
                  ? 'Conectado'
                  : _controller.connectionType.value == 2
                      ? 'Conectado'
                      : 'Última conexión: ${_formatDateTime(_controller.lastSyncDateTime.value)}',
            ),
          ),
          Icon(
            Icons.wifi,
            color: _controller.connectionType.value == 1
                ? Theme.of(context).colorScheme.primary
                : Colors.redAccent,
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }
}
