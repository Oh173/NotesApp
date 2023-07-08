import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotesRegisterScreen extends StatefulWidget {
  const NotesRegisterScreen({super.key});

  @override
  State<NotesRegisterScreen> createState() => _NotesRegisterScreenState();
}

class _NotesRegisterScreenState extends State<NotesRegisterScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page(),
    );
  }
  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(),
              const SizedBox(height: 50),
              _inputField("Email", emailController),
              const SizedBox(height: 20),
              _inputField("Password", passwordController, isPassword: true),
              const SizedBox(height: 25),
              _signupBtn(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          shape: BoxShape.circle),
      child: const Icon(Icons.person, color: Colors.white, size: 120),
    );
  }
  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.white));

    return TextField(
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }
  Widget _signupBtn() {
    return ElevatedButton(
      onPressed: () => register(),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Sign Up ",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void register(){
    String email = emailController.text;

    String password = passwordController.text;

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then(
       (value) async {
         Navigator.pop(context);
         showToast('Account created');
       });
  }

  void showToast(String errorMessage) {
    Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
        fontSize: 16.0);
  }


}
