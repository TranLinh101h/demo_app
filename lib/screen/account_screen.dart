import 'package:demo_app/constan.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide PhoneAuthProvider, EmailAuthProvider;
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountState();
}

class _AccountState extends State<AccountScreen> {
  String email = "hello";
  String photo = defaultImage;
  String name = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user != null) {
    //     setState(() {
    //       email = user.email.toString();
    //       photo =
    //           user.photoURL != null ? user.photoURL.toString() : defaultImage;
    //       name = user.displayName.toString();
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 50,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: ClipOval(
                    child: Image.network(
                      photo,
                      fit: BoxFit.cover,
                      width: 200.0,
                      height: 300.0,
                    ),
                  ),
                ),
                Text("Email:"),
                Text("Name: "),
                TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: Text("SIGN OUT")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
