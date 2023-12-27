import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/userAuth_controller.dart';
import '../theme/color.dart';
import 'login_view.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();

  final TextEditingController _numController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final AuthController authController = Get.put(AuthController());

  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  FocusNode f3 = new FocusNode();
  FocusNode f4 = new FocusNode();
  FocusNode f5 = new FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f6fb),
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0, right: 15, left: 15),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 2.h,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                                onTap: () => Get.back(),
                                child: const Icon(Icons.arrow_back_ios))),
                        Image.asset(
                          'assets/images/main_logo.png',
                          scale: 8,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormField(
                          focusNode: f1,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: _displayName,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 10),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              // borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[350],
                            labelText: 'Name',
                            hintText: 'Name',
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
                            if (value!.isEmpty) return 'Enter the Name';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormField(
                          focusNode: f2,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 10),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              // borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[350],
                            labelText: 'Email',
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
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Email';
                            } else if (!isValidEmail(value!)) {
                              return 'Enter valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormField(
                          focusNode: f3,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          //keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              // borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[350],
                            labelText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.black26,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            f3.unfocus();
                            if (_passwordConfirmController.text.isEmpty) {
                              FocusScope.of(context).requestFocus(f4);
                            }
                          },
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFormField(
                          focusNode: f4,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          controller: _passwordConfirmController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              // borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[350],
                            labelText: 'Confirm Password',
                            hintStyle: TextStyle(
                              color: Colors.black26,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            f4.unfocus();
                          },
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Password';
                            } else if (value
                                    .compareTo(_passwordController.text) !=
                                0) {
                              return 'Password not Matching';
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                        ),
                        Obx(() {
                          if (authController.isLoading.value == true) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 25.0, right: 25.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SpinKitFadingCube(
                                  color: AppColors.primaryColor,
                                  size: 10.w,
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              padding:
                                  const EdgeInsets.only(top: 25.0, right: 25),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  height: 8.h,
                                  width: 8.h,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          await authController
                                              .signUpWithEmailAndPassword(
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
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            );
                          }
                        }),
                        Container(
                          padding:
                              EdgeInsets.only(top: 25, left: 10, right: 10),
                          width: MediaQuery.of(context).size.width,
                          child: Divider(
                            thickness: 1.5,
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent)),
                                  onPressed: () =>
                                      _pushPage(context, LoginScreen()),
                                  child: Text(
                                    'Sign in',
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }

  bool isValidEmail(String email) {
    // Simple email validation using regular expression
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegex.hasMatch(email);
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
