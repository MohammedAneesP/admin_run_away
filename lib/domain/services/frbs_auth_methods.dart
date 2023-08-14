
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:run_away_admin/core/color_constants.dart';
import 'package:run_away_admin/core/constants/constants.dart';
import 'package:run_away_admin/presentation/home_page/admin_home.dart';
import 'package:run_away_admin/presentation/login_sign_up_pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBaseAuthMethods {

  final FirebaseAuth fireAuth;
  FireBaseAuthMethods(this.fireAuth);
  storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('OnBoard', isViewed);
  }
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerification(context);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      anSnackBarFunc(context: context,aText:  e.message.toString(),anColor: kGrey);
    }
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!fireAuth.currentUser!.emailVerified) {
        await fireAuth.currentUser?.sendEmailVerification();
      }
      
      final createUser = FirebaseFirestore.instance.collection("users");
      createUser.doc(email);
      await storeOnBoardInfo();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AdminHome(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      anSnackBarFunc(context: context,aText:  e.message.toString(),anColor: kGrey);
    }
  }


  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      fireAuth.currentUser!.sendEmailVerification();
      anSnackBarFunc(context: context,aText:  "Email verification Sent",anColor: kBlue);
    } on FirebaseAuthException catch (e) {
      anSnackBarFunc(context: context,aText:  e.message.toString(),anColor: kGrey);
    }
  }

  Future<void> checkLogedIn(BuildContext context) async {
    User? user = fireAuth.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AdminHome(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await fireAuth.signOut();
    } on FirebaseAuthException catch (e) {
      anSnackBarFunc(context: context,aText:  e.message.toString(),anColor: kGrey);
    }
  }

  Future<void> forgotPassword(
      {required String anEmail, required BuildContext context}) async {
    try {
      await fireAuth.sendPasswordResetEmail(email: anEmail);
    } on FirebaseAuthException catch (e) {
      anSnackBarFunc(anColor: kGrey,context: context,aText:  e.message.toString());
    }
  }
}