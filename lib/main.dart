import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:instagram_clone/responsive/mobilescreen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/webscreen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/color.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: "assets/.env");

  // Firebase initialization
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.env['API_KEY']!,
        authDomain: dotenv.env['AUTH_DOMAIN']!,
        projectId: dotenv.env['PROJECT_ID']!,
        storageBucket: dotenv.env['STORAGE_BUCKET']!,
        messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
        appId: dotenv.env['APP_ID']!,
        measurementId: dotenv.env['MEASUREMENT_ID'],
      ),
    );
  } else {
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
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context,snapshot){
  if(snapshot.connectionState==ConnectionState.active){
    if(snapshot.hasData){
return   const ResponsiveLayout(webScreenLayout: WebscreenLayout(), mobileScreenLayout: MobilescreenLayout());

    }
    else if(snapshot.hasError){
      return Center(
        child: Text("Error: ${snapshot.error}"),
      );
    }
  }
   if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(color: primaryColor,),);
  }
  
  return LoginScreen();
  }),
    );
  }
}
