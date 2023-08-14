import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:run_away_admin/core/constants/constants.dart';
import 'package:run_away_admin/domain/services/frbs_auth_methods.dart';
import 'package:run_away_admin/main.dart';
import 'package:run_away_admin/presentation/login_sign_up_pages/login_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goto();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/landing_pic_2.png',
              ),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Text(
            "RUNAWAY",
            style: splashTitle,
          ),
        ),
      ),
    );
  }

  Future<void> goto() async {
    await Future.delayed(const Duration(seconds: 5));
    isViewed != 0
        ?  toOnBoarding()
        :  FireBaseAuthMethods(FirebaseAuth.instance)
            .checkLogedIn(context);
  }

  void toOnBoarding() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) =>  LoginPage(),
    ));
  }
}
