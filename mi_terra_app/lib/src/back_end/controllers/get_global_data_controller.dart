import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';

class GetGlobalDataController extends GetxController {
  final UserRepository userRepository = UserRepository.instance;
  final RxString userName = "".obs;
  final RxBool loading = true.obs;

  Future<void> fetchUserName() async {
    try {
      loading(true);
      final Map<String, dynamic> userData =
          await userRepository.fetchUserDetails();
      final String fetchedUserName = userData['profile']['user_name'] as String;
      userName(fetchedUserName);
    } catch (error) {
      print('Error fetching user details: $error');
    } finally {
      loading(false);
    }
  }
}
