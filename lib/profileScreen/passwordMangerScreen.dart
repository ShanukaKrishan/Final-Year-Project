import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/loginScreen/loginScreen.dart';
import 'package:watch_store/widgets/customButtons.dart';

import '../constants.dart';

class PasswordScreen extends StatelessWidget {
  static String routeName = '/PasswordScreen';
  PasswordScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _currentPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _newPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _changePassword(String currentPassword, String newPassword) async {
      print("called");
      final user = await FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user!.email.toString(), password: currentPassword);

      await user.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((_) async {
          await FirebaseAuth.instance.signOut();
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password Changed Successfully"),
            backgroundColor: Colors.green,
          ));
        }).catchError((error) {
          //Error, show something
          print(error);
        });
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Incorrect current password"),
          backgroundColor: Colors.red,
        ));
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverAppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Manage Password",
                style: kTextAppBarTitle,
              ),
            )
          ];
        },
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/sheild.png',
                width: ScreenUtil().setWidth(100), height: 100.h),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _currentPassword,
                      decoration:
                          _buildInputDecoration('Enter current password'),
                    ),
                    TextFormField(
                      controller: _newPassword,
                      decoration: _buildInputDecoration('Enter new password'),
                    ),
                    TextFormField(
                      controller: _confirmPassword,
                      validator: (value) {
                        if (_newPassword.text != _confirmPassword.text) {
                          return "Confirm password doesn't match ";
                        }
                        return null;
                      },
                      decoration: _buildInputDecoration('Confirm password'),
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                        buttonText: "Change Password",
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            _changePassword(
                                _currentPassword.text, _confirmPassword.text);
                          }
                        }),
                    const SizedBox(height: 20),
                    const Text(
                      'Note: Changing password will log you out',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String text) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black45),
        ),
        fillColor: Colors.black12,
        hintText: text,
        hintStyle: const TextStyle(color: Colors.grey));
  }
}
