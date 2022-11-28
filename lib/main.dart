import 'package:demo_app/screen/account_screen.dart';
import 'package:demo_app/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // runApp(MultiProvider(providers: [], child: MyApp()));
  runApp(MyApp());
}

final actionCodeSettings = ActionCodeSettings(
  url: 'https://flutterfire-e2e-tests.firebaseapp.com',
  handleCodeInApp: true,
  androidMinimumVersion: '1',
  androidPackageName: 'io.flutter.plugins.firebase_ui.firebase_ui_example',
  iOSBundleId: 'io.flutter.plugins.fireabaseUiExample',
);

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      initialRoute: '/homepage',
      debugShowCheckedModeBanner: false,
      locale: const Locale("vi"),
      title: "QR APP",
      routes: {
        '/homepage': (context) {
          return HomeScreen();
        },
        '/sign-in': (context) {
          FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user != null) {
              Navigator.pushReplacementNamed(context, '/profile');
            }
          });
          return Scaffold(
            appBar: AppBar(),
            body: SignInScreen(
              providers: [
                EmailAuthProvider(),
              ],
              actions: [
                ForgotPasswordAction((context, email) {
                  Navigator.pushNamed(
                    context,
                    '/forgot-password',
                    arguments: {'email': email},
                  );
                }),
                AuthStateChangeAction<UserCreated>((context, state) {
                  Navigator.pushReplacementNamed(context, '/profile');
                }),
                AuthStateChangeAction<SignedIn>((context, state) {
                  Navigator.pushReplacementNamed(context, '/profile');
                }),
              ],
              styles: const {
                EmailFormStyle(
                  signInButtonVariant: ButtonVariant.filled,
                ),
              },
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    action == AuthAction.signIn
                        ? 'Welcome to Firebase UI! Please sign in to continue.'
                        : 'Welcome to Firebase UI! Please create an account to continue',
                  ),
                );
              },
            ),
          );
        },
        '/profile': (context) {
          FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user == null) {
              Navigator.pushReplacementNamed(context, '/sign-in');
            }
          });
          return AccountScreen();
        },
        '/forgot-password': (context) {
          return ForgotPasswordScreen();
        },
      },
    );
  }
}
