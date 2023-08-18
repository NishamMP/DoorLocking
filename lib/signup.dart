import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jagl/signin.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _signUpEmaile = TextEditingController();
  final TextEditingController _signUpPassword = TextEditingController();
  final TextEditingController _signUpConfirmPassword = TextEditingController();
 // final TextEditingController _signUpName = TextEditingController();
//  final TextEditingController _signUpDoorPassword = TextEditingController();
//  bool _obsecureDoor = true;

  final formKeySignup = GlobalKey<FormState>();
  bool _obsecure = true;
 
  late DatabaseReference databaseReference;

  late bool successRegister = true;
  late String? userEmail;
  late bool succesInsertData = true;
  


  Future registerAccount()async {
    
    String es='0';
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: _signUpEmaile.text, password: _signUpPassword.text);
    }on FirebaseAuthException catch (e) {
      errorHandlingSignup(e.code.toString());
      es=e.code;
    }
    if(es=='0'){
      //inSertDat();
      printSucces();
      

    }
    
    
    
  }

  void errorHandlingSignup(String s) {
    debugPrint(".........................................");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Warning'),
              content:  Text(s),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.green[200],
      body: Form(
        key: formKeySignup,
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "User Registration",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  onChanged: (value) {
                    final form = formKeySignup.currentState!;
                    form.validate();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'The field can not be empty';
                    }
                    return null;
                  },
                  controller: _signUpEmaile,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    hintText: "E-mail",
                    filled: true,
                    fillColor: Colors.blue[100],
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  textInputAction: TextInputAction.done,
                ),
                // const SizedBox(
                //   height: 30,
                // ),
                // TextFormField(
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'The field can not be empty';
                //     }
                //     return null;
                //   },
                //   onChanged: (value) {
                //     final form = formKeySignup.currentState!;
                //     form.validate();
                //   },
                //   controller: _signUpName,
                //   decoration: InputDecoration(
                //       prefixIcon: const Icon(Icons.account_circle_outlined),
                //       hintText: "Family Or Company Name",
                //       filled: true,
                //       fillColor: Colors.blue[100],
                //       enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(15))),
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                // TextFormField(
                //   onChanged: (value) {
                //     final form = formKeySignup.currentState!;
                //     form.validate();
                //   },
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'The field can not be empty';
                //     }
                //     if (value.length != 4) {
                //       return "field must be a 4 digit number";
                //     }

                //     return null;
                //   },
                //   controller: _signUpDoorPassword,
                //   keyboardType: TextInputType.number,
                //   obscureText: _obsecureDoor,
                //   decoration: InputDecoration(
                //       suffixIcon: IconButton(
                //           onPressed: () {
                //             setState(() {
                //               _obsecureDoor = !_obsecureDoor;
                //             });
                //           },
                //           icon: Icon(_obsecureDoor
                //               ? Icons.visibility
                //               : Icons.visibility_off)),
                //       prefixIcon: const Icon(Icons.lock_person_sharp),
                //       hintText: "Enter 4 digit paasword for door",
                //       filled: true,
                //       fillColor: Colors.blue[100],
                //       enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(15))),
                //   inputFormatters: [
                //     LengthLimitingTextInputFormatter(4),
                //     FilteringTextInputFormatter.digitsOnly,
                //   ],
                // ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  onChanged: (value) {
                    final form = formKeySignup.currentState!;
                    form.validate();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'The field can not be empty';
                    }
                    return null;
                  },
                  controller: _signUpPassword,
                  obscureText: _obsecure,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.blue[100],
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  onChanged: (value) {
                    final form = formKeySignup.currentState!;
                    form.validate();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'The field can not be empty';
                    }
                    if (_signUpConfirmPassword.text.trim() !=
                        _signUpPassword.text.trim()) {
                      return 'Not Match';
                    }
                    return null;
                  },
                  obscureText: _obsecure,
                  controller: _signUpConfirmPassword,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obsecure = !_obsecure;
                            });
                          },
                          icon: Icon(_obsecure
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Confirm password",
                      filled: true,
                      fillColor: Colors.blue[100],
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                  onPressed: () {
                    final form = formKeySignup.currentState!;
                   // bool insert=true;
                   // bool register=false;
                    if (form.validate()) {

                      registerAccount();
                    
                     
                    }

                  // ignore: unrelated_type_equality_checks

                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(400, 50)),
                  child: const Text(
                    'SUBMIT',
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void printSucces() {
    FirebaseAuth.instance.signOut();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Success'),
              content:
                  const Text('Account succesfully created. You can login now'),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
                  },
                ),
              ]);
        });
  }
}
