import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordSubmit extends StatefulWidget {
  const PasswordSubmit({super.key});

  @override
  State<PasswordSubmit> createState() => _PasswordSubmitState();
}

class _PasswordSubmitState extends State<PasswordSubmit> {
  final TextEditingController _pin1 = TextEditingController();
  final TextEditingController _pin2 = TextEditingController();
  final TextEditingController _pin3 = TextEditingController();
  final TextEditingController _pin4 = TextEditingController();

  final TextEditingController _signUpDoorPassword = TextEditingController();

  final formKeySignup = GlobalKey<FormState>();
  String currentUserId = '0';
  late DatabaseReference databaseReference;
  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser!.uid;
    databaseReference = FirebaseDatabase.instance.ref('App');
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth=MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Home'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                clickLogout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Form(
        key: formKeySignup,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Password Verification & Change",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: () async {
                    String result;
                    final ref = FirebaseDatabase.instance.ref('App');
                    final snapshot =
                        await ref.child('$currentUserId/doorPassword').get();
                    if (snapshot.exists) {
                      result = snapshot.value.toString();
                      debugPrint(
                          '....................$result...........................');
                      alreadySet();
                    } else {
                      fireRegistration();
                    }
                  },
                  child: const Text(
                      'If you not set password set password by clicking here')),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
                child: Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'The field canot be empty';
                              
                            }
                            return null;

                          },
                          controller: _pin1,
                          decoration: InputDecoration(
                              fillColor: Colors.blue[200],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onChanged: (value) {
                            if (value.length == 1) {
                              LengthLimitingTextInputFormatter(1);
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: Theme.of(context).textTheme.titleLarge,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'The field canot be empty';
                              
                            }
                            return null;

                          },
                          controller: _pin2,
                          decoration: InputDecoration(
                              fillColor: Colors.blue[200],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: Theme.of(context).textTheme.titleLarge,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      SizedBox(

                        height: 50,
                        width: 50,
                        child: TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'The field canot be empty';
                              
                            }
                            return null;

                          },
                          controller: _pin3,
                          decoration: InputDecoration(
                              fillColor: Colors.blue[200],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: Theme.of(context).textTheme.titleLarge,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'The field canot be empty';
                              
                            }
                            return null;

                          },
                          controller: _pin4,
                          decoration: InputDecoration(
                              fillColor: Colors.blue[200],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: Theme.of(context).textTheme.titleLarge,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              TextButton(onPressed: () {}, child: const Text("Forgot Password?")),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                 // final form=formKeySignup.currentState;
                 // if(form!.validate()){
                      final String password =
                      _pin1.text + _pin2.text + _pin3.text + _pin4.text;
                      verifyPassword(password);
                    
                 // }
                  
                },
                child: const Text(
                  'Verify',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // final String password=_pin1.text+_pin2.text+_pin3.text+_pin4.text;
                },
                child: const Text(
                  'Change Password',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clickLogout() {
    debugPrint(".........................................");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Are you sure want to logout'),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Yes'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]);
        });
  }

  void inSertDat() {
    Map<String, String> users = {
      'doorPassword': _signUpDoorPassword.text,
      'checkvalue': 'false',
    };
    databaseReference.child(currentUserId).set(users);
  }

  void fireRegistration() {
    bool obsecureDoor = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Set password for your lock'),
              content: TextFormField(
                onChanged: (value) {
                  final form = formKeySignup.currentState!;
                  form.validate();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The field can not be empty';
                  }
                  if (value.length != 4) {
                    return "field must be a 4 digit number";
                  }

                  return null;
                },
                keyboardType: TextInputType.number,
                obscureText: obsecureDoor,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_person_sharp),
                    hintText: "Enter 4 digit paasword for door",
                    filled: true,
                    fillColor: Colors.blue[100],
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                controller: _signUpDoorPassword,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Submit'),
                  onPressed: () {
                    inSertDat();
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }

  void alreadySet() {
    debugPrint(".........................................");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('You alrady set the password'),
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

  Future verifyPassword(String password) async {
    String result;
    final ref = FirebaseDatabase.instance.ref('App');
    final snapshot = await ref.child('$currentUserId/doorPassword').get();
    result = snapshot.value.toString();
    if(result==password){
      await ref.update({
        '$currentUserId/checkvalue':true,
      });
    }
  }
}
