import 'package:flashchat/FlashChat/components/checkuser.dart';
import 'package:flashchat/FlashChat/components/navigation_menu.dart';
import 'package:flashchat/FlashChat/screens/home_page.dart';
import 'package:flashchat/FlashChat/screens/login_screen.dart';
import 'package:flashchat/FlashChat/screens/registration_screen.dart';
import 'package:flashchat/FlashChat/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlashChat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
          useMaterial3: true, // Ensure Material 3 is enabled
          navigationBarTheme: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return const TextStyle(fontWeight: FontWeight.bold, fontSize: 14); // Bold for selected item
                }
                return const TextStyle(fontWeight: FontWeight.normal, fontSize: 14); // Normal for unselected
              },
            ),
          ),
        ),
        // home:PriceScreen(),

        initialRoute: CheckUser.id,
        routes: {     //map due to {}
          CheckUser.id: (context)=> const CheckUser(),
          NavigationMenu.id: (context) => const NavigationMenu(),
          HomePage.id:(context)=>const HomePage(),
          WelcomeScreen.id: (context)=>const WelcomeScreen(),
          LoginScreen.id: (context)=>const LoginScreen(),
          RegistrationScreen.id:(context) =>const RegistrationScreen(),
        }


    );
  }
}

