import 'package:automata_project/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../view/home_view.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var isLoadingLogin = false.obs;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? newUser) {
      user.value = newUser;
    });
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      isLoading.value = false;
      Get.offAll(LoginScreen());
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Error signing up',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoadingLogin.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoadingLogin.value = false;
      Get.offAll(HomeScreen(), transition: Transition.fade);
    } on FirebaseAuthException catch (e) {
      isLoadingLogin.value = false;
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.',
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Incorrect password. Please try again.',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Error signing in',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Stream<QuerySnapshot> getFirestoreData(
      String collectionPath, int limit, String? textSearch) {
    if (textSearch?.isNotEmpty == true) {
      return FirebaseFirestore.instance
          .collection(collectionPath)
          .limit(limit)
          .where('Sheroze', isEqualTo: textSearch)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(collectionPath)
          .limit(limit)
          .snapshots();
    }
  }

  Future<void> updateFirestoreData(
      String collectionPath, String path, Map<String, dynamic> updateData) {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(path)
        .update(updateData);
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      Get.snackbar('Success', 'Password reset email sent successfully',
          snackPosition: SnackPosition.BOTTOM);
      Get.back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Error sending password reset email',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error sending password reset email',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
