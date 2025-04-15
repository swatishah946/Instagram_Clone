import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobilescreen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/webscreen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/color.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
if(kIsWeb){
await Firebase.initializeApp(
  options: const FirebaseOptions(
 apiKey: "AIzaSyCLfoecvCWQNks1H61GTk-5jBS-BWCHVsE",
  authDomain: "instagramclone-61850.firebaseapp.com",
  projectId: "instagramclone-61850",
  storageBucket: "instagramclone-61850.firebasestorage.app",
  messagingSenderId: "910079412324",
  appId: "1:910079412324:web:d8b657d2547e9d6ab8b771",
  measurementId: "G-NJ99QH922D"
  )
);
}
else{
  await Firebase.initializeApp();

}
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
scaffoldBackgroundColor: mobileBackgroundColor
      ),
    // home: const ResponsiveLayout(webScreenLayout: WebscreenLayout(), mobileScreenLayout: MobilescreenLayout())
    home: LoginScreen(),
    ) ;
  }
}

