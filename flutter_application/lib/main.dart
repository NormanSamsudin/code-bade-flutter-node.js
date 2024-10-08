import 'package:flutter/material.dart';
import 'package:flutter_application/glabal_variable.dart';
import 'package:flutter_application/secret.dart';
import 'package:flutter_application/views/screens/detail_secreen/about_screen.dart';
import 'package:flutter_application/views/screens/detail_secreen/activity_screen.dart';
import 'package:flutter_application/views/screens/detail_secreen/lost_screen.dart';
import 'package:flutter_application/views/screens/detail_secreen/qorban_screen.dart';
import 'package:flutter_application/views/screens/detail_secreen/qr_screen.dart';
import 'package:flutter_application/views/screens/detail_secreen/review_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application/provider/user_provider.dart';
import 'package:flutter_application/views/screens/authentication/login_screen.dart';
import 'package:flutter_application/views/screens/main_screen.dart';

void main() async{
  await _setup();
  // RUn the flutter ap
  //await p wrapped in a ProviderScope for managing state
  runApp(ProviderScope(child: const MyApp()));
}

Future<void> _setup() async {
WidgetsFlutterBinding.ensureInitialized();
Stripe.publishableKey= stripePublishableKey;
}

// ROOT widget of the application, a consumerwidget to consume state change
class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  // Method to check token and set user data if available
  Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
    //obtain an instance of sharedPreference for local data storage
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //Retrieve the authorization token and user data stored locally
    String? token = preferences.getString('auth_token');
    String? userJson = preferences.getString('user');

    //if both token and user data available, update the user state
    if (token != null && userJson != null) {
      ref.read(userProvider.notifier).setUser(userJson);
    } else {
      ref.read(userProvider.notifier).signOut();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _checkTokenAndSetUser(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final user = ref.watch(userProvider);
          return user != null
              ? MainScreen()
               //QorbanScreen()
              : LoginScreen();
        },
      ),
    );
  }
}
