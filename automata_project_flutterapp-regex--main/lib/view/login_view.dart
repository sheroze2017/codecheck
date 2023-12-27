import 'package:automata_project/theme/color.dart';
import 'package:automata_project/view/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/userAuth_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  FocusNode f3 = new FocusNode();
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f6fb),
      key: _scaffoldKey,
      body: Builder(builder: (BuildContext context) {
        return SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: withEmailPassword(),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget withEmailPassword() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/main_logo.png',
              scale: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                height: 40.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Color(0xfff7f6fb),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Login',
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                        focusNode: f1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'example@gmail.com',
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(90.0),
                              ),
                              borderSide: BorderSide(
                                  color: AppColors.secondaryColor, width: 2)),
                          filled: true,
                          fillColor: Colors.grey[350],
                          //hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          f1.unfocus();
                          FocusScope.of(context).requestFocus(f2);
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter email';
                          }
                          RegExp emailRegex =
                              RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                        focusNode: f2,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        //keyboardType: T
                        //extInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          //border: OutlineInputBorder(),
                          labelText: 'Password',
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            // borderSide: BorderSide.none,
                          ),

                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          f2.unfocus();
                          FocusScope.of(context).requestFocus(f3);
                        },
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) return 'Please enter the Passord';
                          return null;
                        },
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            // width: 50.w,
                            // height: 6.h,
                            height: 8.h,
                            width: 8.h,
                            child: Obx(() {
                              if (authController.isLoadingLogin.value == true) {
                                return SpinKitFadingCube(
                                  color: AppColors.primaryColor,
                                  size: 10.w,
                                );
                              } else {
                                return ElevatedButton(
                                    focusNode: f3,
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        print(_emailController.text);
                                        print(_passwordController.text);
                                        await authController
                                            .signInWithEmailAndPassword(
                                                _emailController.text.trim(),
                                                _passwordController.text
                                                    .trim());
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: AppColors.primaryColor,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ));
                              }
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {
                  _showResetPasswordDialog(context);
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () => _pushPage(context, SignupScreen()),
                    child: Text(
                      'Signup here',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _pushPage(BuildContext context, Widget page) {
    Get.to(page, transition: Transition.upToDown);
  }

  Future<void> _showResetPasswordDialog(BuildContext context) async {
    final TextEditingController emailController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'Forgot Password',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  await authController
                      .resetPassword(emailController.text.trim());
                  // You can add additional logic here after the password reset attempt
                },
                child: Text('Send Reset Email'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
