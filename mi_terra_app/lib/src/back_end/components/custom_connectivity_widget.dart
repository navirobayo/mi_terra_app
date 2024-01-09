import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mi_terra_app/src/back_end/controllers/getx_network_controller.dart';

class ConnectivityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ConnectionManagerController connectionManagerController =
        Get.find<ConnectionManagerController>();

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            child: Text(
              connectionManagerController.connectionType.value == 1 ||
                      connectionManagerController.connectionType.value == 2
                  ? 'Conectado'
                  : 'Última conexión: ${_formatDateTime(connectionManagerController.lastSyncDateTime.value)}',
            ),
          ),
          Icon(
            Icons.wifi,
            color: (connectionManagerController.connectionType.value == 1 ||
                    connectionManagerController.connectionType.value == 2)
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
