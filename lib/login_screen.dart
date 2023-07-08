import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesscreen/forget_Password_Screen.dart';
import 'package:notesscreen/main.dart';
import 'package:notesscreen/notes_register_screen.dart';
import 'constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              // const SizedBox(height: 4),
              _extraText(),
              const SizedBox(height: 5),
              _loginBtn(),
              const SizedBox(height: 5),
              _registerBtn(),
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
  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () {
        // debugPrint("Username : ${emailController.text}");
        // debugPrint("Password : ${passwordController.text}");
        signIn(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Sign in ",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  Widget _registerBtn() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Not a member?',
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 4),
        TextButton(
          onPressed:()=> navigateToRegisterScreen(),
          child: const Text(
            'Register now',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
  Widget _extraText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          child: const Text(
            "Forget Password ?",
            style: TextStyle(fontSize: 13, color: kWhiteColor),
          ),
          onPressed: () => navigateToForgetPasswordScreen(),
        ),
      ],
    );
  }

  void signIn(BuildContext context) async {


    String email = emailController.text;

    String password = passwordController.text;

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NotesScreen(),
        ),
      );
    }).catchError((e){
      //print(e);
      if (e.code == 'user-not-found') {
            // show error to user
            wrongEmailMessage();
          }else if (e.code == 'wrong-password') {
            // show error to user
            wrongPasswordMessage();
          }

    });

  }

  navigateToRegisterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotesRegisterScreen(),
      ),
    );
  }

  navigateToForgetPasswordScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgetPasswordScreen(),
      ),
    );
  }

  void wrongEmailMessage() {
    showDialog(context: context, builder: (context) {
      return const AlertDialog(
        backgroundColor: Colors.grey,
        title: Center(
          child: Text(
            'Incorrect Email',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    },);
  }

  void wrongPasswordMessage() {
    showDialog(context: context, builder: (context) {
      return const AlertDialog(
        backgroundColor: Colors.grey,
        title: Center(
          child: Text(
            'Incorrect Password',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    },);
  }
}
