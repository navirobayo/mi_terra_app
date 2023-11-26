import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/exceptions/email_registration_failure.dart';
import 'package:mi_terra_app/src/front_end/home_screen/home_screen.dart';
import 'package:mi_terra_app/src/front_end/welcome_screen/welcome_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => const HomeScreen());
  }

  Future<void> createUserWithEmailAndPassword(
      String terraEmail, String terraPassword) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: terraEmail, password: terraPassword);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = EmailRegistrationFailure.code(e.code);
      print("FIREBASE AUTH EXCEPTION - ${ex.message}");
      throw ex;
    } catch (_) {
      const ex = EmailRegistrationFailure();
      print("EXCEPTION - ${ex.message}");
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(
      String terraEmail, String terraPassword) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: terraEmail, password: terraPassword);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  Future<void> logout() async => await _auth.signOut();
}
