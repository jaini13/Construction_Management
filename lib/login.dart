import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_today/home.dart';
import 'ClipPathClass.dart';
import 'bottomNavBar.dart';

class Login extends StatefulWidget {


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController uname = TextEditingController();

  TextEditingController pass = TextEditingController();

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            ClipPath(
              clipper: ClipPathClass(),
              child: Container(
                height: 150,
                width: 450,
                decoration: BoxDecoration(
                    color: Color(0xff315ccf),
              ),
              child: Center(child: Image.asset('assets/logo.png',height: 70,)),
                    ),
            ),
            SizedBox(height: 90,),
            Text('User Login',style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20
            ),),
            SizedBox(height: 25,),
            SizedBox(
              height: 50,
              width: 320,

              child: TextField(
                controller: uname,
                decoration: InputDecoration(
                  hintText: 'Enter Username',
                    filled: true,
                    fillColor: Color(0xffeceff6),
                  border:  OutlineInputBorder(
                     borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              ),
            ),
            SizedBox(height: 15,),

            SizedBox(
              height: 50,
              width: 320,
              child: TextField(
                controller: pass,
                obscureText:  !_passwordVisible,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xff315ccf),
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),

                  filled: true,
                    fillColor: Color(0xffeceff6),
                  border:  OutlineInputBorder(
                     borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              ),
            ),
            TextButton(onPressed: () {

            }, child: Text('Forgot password?',style: TextStyle(
              color: Colors.grey
            ),)),
            SizedBox(height: 25,),
            InkWell(
              onTap: ()async {

                if(uname.text.isEmpty || pass.text.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 5),
                          content: Text('Please provide email and password !!'),
                        )
                    );
                  }
                else
                  {
                    try {
                      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: uname.text.trim(),
                          password: pass.text.trim());
                      if(credential != null)
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return BottomNavigationBarExampleApp();
                        },));
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 5),
                              content: Text('No user found for that email.'),
                            )
                        );
                      } else if (e.code == 'wrong-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 5),
                              content: Text('Wrong password provided for that user.'),
                            )
                        );
                      }
                  }
           }
              },
              child:  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff315ccf),
                ),
                height: 45,
                width: 325,
                child: Center(child: Text('Login Now',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17
                  )
                  ,)),
              ),
            )


          ],
        ),
      ),
    );


  }
}




