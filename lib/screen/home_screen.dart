import 'package:demo_app/constan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLogin = false;
  String imageURL = defaultImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          isLogin = true;
          imageURL =
              user.photoURL != null ? user.photoURL.toString() : defaultImage;
        });
      } else {
        isLogin = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (isLogin) {
                      Navigator.pushNamed(context, "/profile");
                    } else {
                      Navigator.pushNamed(context, "/sign-in");
                    }
                  },
                  child: isLogin
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(imageURL),
                          ),
                        )
                      : Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.02,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text(
          "Wellcome to home page!",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//   static const String routeName = '/basics/animation_controller';

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   static const Duration _duration = Duration(seconds: 1);
//   late final AnimationController controller;

//   @override
//   void initState() {
//     super.initState();

//     controller = AnimationController(vsync: this, duration: _duration)
//       // The Widget's build needs to be called every time the animation's
//       // value changes. So add a listener here that will call setState()
//       // and trigger the build() method to be called by the framework.
//       // If your Widget's build is relatively simple, this is a good option.
//       // However, if your build method returns a tree of child Widgets and
//       // most of them are not animated you should consider using
//       // AnimatedBuilder instead.
//       ..addListener(() {
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     // AnimationController is a stateful resource that needs to be disposed when
//     // this State gets disposed.
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // When building the widget you can read the AnimationController's value property
//     // when building child widgets. You can also check the status to see if the animation
//     // has completed.
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Animation Controller'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 200),
//               child: Text(
//                 controller.value.toStringAsFixed(2),
//                 style: Theme.of(context).textTheme.headline3,
//                 textScaleFactor: 1 + controller.value,
//               ),
//             ),
//             ElevatedButton(
//               child: const Text('animate'),
//               onPressed: () {
//                 if (controller.status == AnimationStatus.completed) {
//                   controller.reverse();
//                 } else {
//                   controller.forward();
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
