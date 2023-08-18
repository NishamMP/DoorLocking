
import 'package:flutter/material.dart';
import 'package:jagl/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jagl/signup.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey=GlobalKey<FormState>();
  final TextEditingController _recieveEmaile = TextEditingController();
  final TextEditingController _recievePassword = TextEditingController();
   bool _obsecure=true;
  Myapp myApp=const Myapp();
  
  @override
  void dispose(){
    _recieveEmaile.dispose();
    _recievePassword.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
        backgroundColor: Colors.green[200],
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text("Digital Door" ,style:TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset("Image/assets/digital_door.png")),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                    controller: _recieveEmaile,
                    onChanged:(value){
                            final form=formKey.currentState!;
                            form.validate();

                          },
                    keyboardType: TextInputType.emailAddress,
                    decoration:  InputDecoration(
                      
                      prefixIcon:const Icon(Icons.email),
                      hintText: "Email",
                      filled: true,
                        fillColor: Colors.blue[100],
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    
                      suffixIcon: IconButton(onPressed: ( )=>_recieveEmaile.clear(), icon:const Icon(Icons.close))
                    ),
                    autofillHints:const [AutofillHints.email],
                    
                    validator:(email)=>email!=null && !EmailValidator.validate(email)? 'Enter a valid email':null 
                    
                  ),
                const SizedBox(
                  height: 30,
                ),
               TextFormField(
                  onChanged:(value){
                            final form=formKey.currentState!;
                            form.validate();


                          }, 
                  validator:(value) {
                            if (value!.isEmpty) {
                              return 'The field can not be empty';
                            }
                            return null;
                          } ,
                    controller: _recievePassword,
                    decoration:  InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(onPressed: (){

                          setState(() {
                             _obsecure=!_obsecure;
                          });
                         
                        }, icon: Icon(_obsecure ?Icons.visibility:Icons.visibility_off)) ,
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.blue[100],
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                        ),
                    obscureText: _obsecure,
           
                ),
                const SizedBox(
                  height: 50,
                ),
                
                ElevatedButton(
                  onPressed: (){
                    final form=formKey.currentState!;
                    if(form.validate()){
                        signIntoAccount();
                    }
                    
                   },
                  
                  style:ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    minimumSize:const Size(400, 50)
                  ),
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20),
                  ),
                ),
                Row(children:[
                  
                  TextButton(
                    
                    onPressed:(){
                      Navigator.push(context,MaterialPageRoute(builder:(context)=>const SignupScreen()));
                
                    },
                     child:const Text("Create new account",style: TextStyle(color: Colors.black),)),
                  const Spacer( flex: 2,),
                  TextButton(
                    
                    onPressed:(){
                
                    },
                     child:const Text("Forget password?",style: TextStyle(color: Colors.black))),]
                  
                ),
                
              ],
            ),
          ),
        ));
      
  }
  Future signIntoAccount()async{
    bool test=true;
      showDialog(
        context: context,
         builder: (context)=>const Center(child: CircularProgressIndicator(),));
    try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _recieveEmaile.text.trim(),
          password: _recievePassword.text.trim());
      }on FirebaseAuthException catch(e){
        Navigator.of(context).pop();
        errorHandling( e.message);
        test=false;
        
      }
    
    if(test==true){
      // ignore: use_build_context_synchronously
        Navigator.of(context).pop();  
    }
    
    
  }
  void errorHandling( message){
    print(".........................................");
    showDialog(
       context: context,
        builder:(BuildContext context){
          return AlertDialog(title: const Text('Warning'),
          content: const Text('Incorrect Email Or Password\nPlease check it and try again'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),]);
        });

  }
  

}

