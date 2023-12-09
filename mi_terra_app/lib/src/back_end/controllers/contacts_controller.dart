import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';

class ContactsController extends GetxController {
  final UserRepository userRepository = UserRepository.instance;
  final contacts = <Map<String, dynamic>>[].obs;

  Future<void> getUserContacts() async {
    try {
      contacts.assignAll(await userRepository.getUserContacts());
    } catch (error) {
      print('Error fetching user products: $error');
    }
  }
}
