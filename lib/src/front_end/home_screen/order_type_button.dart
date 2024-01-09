import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/radio_button_controller.dart';

class RadioButtonWidget extends StatelessWidget {
  final String value;
  final String title;

  const RadioButtonWidget({
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ButtonController>(
      builder: (buttonController) {
        return InkWell(
          onTap: () => buttonController.setOrderType(value),
          child: Row(
            children: [
              Radio(
                value: value,
                groupValue: buttonController.orderType,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (String? value) {
                  buttonController.setOrderType(value!);
                },
                activeColor: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
        );
      },
    );
  }
}
