import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class ContactController extends GetxController {
  static ContactController get instance => Get.find();

  TextEditingController contactName = TextEditingController();
  TextEditingController contactPhone = TextEditingController();
  TextEditingController contactNote = TextEditingController();
  TextEditingController contactSocialMedia = TextEditingController();
  TextEditingController contactLocation = TextEditingController();

  //! To do: Add snackbar confirming the creation of the new product.

  Future<void> createContact() async {
    final contactId = const Uuid().v4();
    final Map<String, dynamic> contactData = {
      'contact_name': contactName.text,
      'contact_id': contactId,
      'contact_note': contactNote.text,
      'contact_phone': contactPhone.text,
      'contact_social_media': contactSocialMedia.text,
      'contact_location': contactLocation.text,
    };
    try {
      await UserRepository.instance.saveContact(contactData);
    } catch (error) {
      print("error: $error");
    }
  }
}
