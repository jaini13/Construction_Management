import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ClipPathClass.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  TextEditingController uname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact_no = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uname.text = FirebaseAuth.instance.currentUser!.displayName.toString();
    email.text = FirebaseAuth.instance.currentUser!.email.toString();
    contact_no.text = FirebaseAuth.instance.currentUser!.phoneNumber.toString();

  }

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
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))
                ),
                child: Center(child: Image.asset('assets/logo.png',height: 70,)),
              ),
            ),


            SizedBox(height: 50,),
            CircleAvatar(
              maxRadius: 55,
              backgroundImage: AssetImage('assets/profilePic.jpg'),
            ),
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

                decoration: InputDecoration(
                  hintText: 'Enter Password',

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
                controller: email,
                decoration: InputDecoration(
                  hintText: 'Enter Email',

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
                controller: contact_no,
                decoration: InputDecoration(
                  hintText: 'Enter Contact No.',

                  filled: true,
                  fillColor: Color(0xffeceff6),
                  border:  OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),

            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child:  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff315ccf),
                    ),
                    height: 45,
                    width: 150,
                    child: Center(child: Text('Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                      )
                      ,)),
                  ),
                ),
                InkWell(
                  onTap: () {

                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Login();
                      },));
                    });


                  },
                  child:  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    height: 45,
                    width: 150,
                    child: Center(child: Text('Logout',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                      )
                      ,)),
                  ),
                ),
              ],
            )


          ],
        ),
      ),
    );
  }
}

