/*
 * TODO:
 * - Abstract into widgets --MOST IMPORTANT FOR MERGE
 * - New account flow --MOST IMPORTANT FOR MERGE
 * - Found account flow --CAN BE DONE IN SEPARATE TASK
 * - Not whitelisted number flow --CAN BE DONE IN SEPARATE TASK
 * - Invite friends flow --CAN BE DONE IN SEPARATE TASK
 */
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import './pages/enter_username.dart';
import './pages/verification_code.dart';
import './pages/verify_phone.dart';
import '../shared_widgets/custom_appbar.dart';
import '../themes/constants.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // All Pages
  final _pageController = PageController();
  double _currentPage = 0.0;
  late List<Widget> _pages;

  // Page One
  final GlobalKey<VerifyPhoneState> _verifyPhoneKey = GlobalKey();

  // Page Two

  @override
  void initState() {
    super.initState();
    // All pages
    _pages = [
      VerifyPhone(
        key: _verifyPhoneKey,
        onNext: _nextPage,
      ),
      EnterVerificationCode(
        reset: _reset,
      ),
      EnterUserName(onNext: (){

      })
    ];

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });

    // Page One

    // Page Two
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _currentPage == 0
          ? CustomAppBar(
              context,
              closable: true,
            )
          : AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: Column(
              children: [
                SizedBox(
                  height: 470.0,
                  child: PageView(
                    controller: _pageController,
                    // physics: const NeverScrollableScrollPhysics(),
                    children: _pages,
                  ),
                ),
                DotsIndicator(
                  position: _currentPage,
                  dotsCount: 3,
                  decorator: const DotsDecorator(
                    activeColor: kAccentColor,
                    color: Color(0xFFCCCCCC),
                    size: Size(12.0, 12.0),
                    activeSize: Size(12.0, 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Page Two
  void _reset() {
    _verifyPhoneKey.currentState?.reset();
    _pageController.animateTo(0.0,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void _nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
