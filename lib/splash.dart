
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jagl/open.dart';
import 'package:jagl/signin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
 void initState(){
  super.initState();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  
  Future.delayed(const Duration(seconds: 3),(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> MyWidget()));
  });
  
 }
 @override
  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.cyan,
        alignment: Alignment.center,
        child:const Text(
          'Door Opening',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
        ) ,),
    );
  }
  
}

class MyWidget extends StatelessWidget {
   MyWidget({super.key});
  final auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context)=>Scaffold(
    body:StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return const Center(child: Text('Something went wrong!'));
          }else if(snapshot.hasData && auth.currentUser!=null){
            return const PasswordSubmit() ;
          }
          else{
            return const SignInScreen();
          }
        },
      ),
  );
}


