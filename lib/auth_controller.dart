import 'package:firebase_app/login_page.dart';
import 'package:firebase_app/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  //Because of this line we would be able to access the AuthController fro every where in the app
  static AuthController instance = Get.find();
  //Declare the variable of the firebase user
  //this user is from firebase that will include user's details such as email, password and so on
  late Rx<User?> _user;
  //Instantiating a variable for firebase auth model
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser); //manual casting instead of using 'as'
    //to keep track of the users auth activities we use bind streams and it will notify the users
    _user.bindStream(auth.userChanges());
    //we need to process the user details after User has been notified so we can alert the app.. the ever function listens to the changes
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    //we are using the ? because there might be a user and there might not
    if (user == null) {
      debugPrint('Login page');
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(
        () => WelcomePage(email: user.email!),
      );
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Get.snackbar(
        'Error',
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        // 'User message',
        // backgroundColor: Colors.redAccent,
        // snackPosition: SnackPosition.BOTTOM,
        // titleText: const Text(
        //   'Account creation failed',
        //   style: TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
        // messageText: Text(
        //   e.toString(),
        //   style: const TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Get.snackbar(
        'Error',
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        // 'User message',
        // backgroundColor: Colors.redAccent,
        // snackPosition: SnackPosition.BOTTOM,
        // titleText: const Text(
        //   'Account creation failed',
        //   style: TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
        // messageText: Text(
        //   e.toString(),
        //   style: const TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
      );
    } on PlatformException catch (e) {
      print(e.message);
      Get.snackbar(
        'Error',
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        // 'User message',
        // backgroundColor: Colors.redAccent,
        // snackPosition: SnackPosition.BOTTOM,
        // titleText: const Text(
        //   'Account creation failed',
        //   style: TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
        // messageText: Text(
        //   e.toString(),
        //   style: const TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void logOut() async {
    await auth.signOut();
  }
}
