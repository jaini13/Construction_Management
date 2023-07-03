import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_today/home.dart';
import 'package:task_today/profile.dart';


class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
    BottomNavigationBarExample();

  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  String? imageUrl;

  final ScrollController _homeController = ScrollController();
  TextEditingController desc = TextEditingController();
  TextEditingController amt = TextEditingController();
  TextEditingController project = TextEditingController();


  String? dropdownValue;

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Home(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar:


      BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(label: '',
              icon: CircleAvatar(child: Icon(Icons.add, color: Colors.white,),
                backgroundColor: Color(0xff315ccf),)),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xff315ccf),
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          switch (index) {
            case 0:
            // only scroll to top when current index is selected.
              Home();
              break;
            case 1:
              showModal(context);
              break;
            case 2:
              Profile();
              break;
          }
          setState(
                () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }

  void showModal(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            icon: Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close, color: Colors.white, size: 23),

                ),
              ),
            ),
            iconPadding: EdgeInsets.all(7),
            content: SingleChildScrollView(
              child: Container(
                  height: 300,
                  width: 320,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 320,
                        child: TextField(
                          controller: desc,
                          decoration: InputDecoration(
                            hintText: 'Description',
                            hintStyle: TextStyle(
                                color: Colors.grey
                            ),
                            filled: true,
                            fillColor: Color(0xffeceff6),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),

                      SizedBox(
                        height: 50,
                        width: 320,

                        child: TextField(
                          controller: amt,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Amount',
                            hintStyle: TextStyle(
                                color: Colors.grey
                            ),
                            filled: true,
                            fillColor: Color(0xffeceff6),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 50,
                        width: 320,
                        decoration: BoxDecoration(
                            color: Color(0xffeceff6),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('User')
                              .snapshots(),
                          builder: (context, snapshot) {
                            List<DropdownMenuItem> projectList = [];

                            if (!snapshot.hasData) {
                              CircularProgressIndicator();
                            }
                            else {
                              for (int i = 0; i < snapshot.data!.docs
                                  .length; i++) {
                                DocumentSnapshot snaps = snapshot.data!.docs[i];
                                projectList.add(DropdownMenuItem(
                                  child: Text(
                                      snaps['projects'][i].toString()
                                  ), value: '${snaps['projects'][i]}',));
                              }
                            }
                            return DropdownButtonFormField(


                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),

                                  border: InputBorder.none
                              ),

                              items: projectList, onChanged: (value) {
                              setState(() {
                                dropdownValue = value;
                              });
                            },);
                          },),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 50,
                        width: 320,
                        decoration: BoxDecoration(
                          color: Color(0xffeceff6),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: InkWell(
                          onTap: () {
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                content: Container(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 400,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(
                                                  0xff315ccf),
                                            ),
                                            onPressed: () {
                                              pickImage();
                                            }, child: Row(
                                          children: [
                                            Icon(Icons.photo),
                                            SizedBox(width: 10,),
                                            Text('Choose from galary'),
                                          ],
                                        )),
                                      ),

                                      SizedBox(
                                        width: 400,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(
                                                  0xff315ccf),
                                            ),
                                            onPressed: () {
                                              pickImageCamera();
                                            }, child: Row(
                                          children: [
                                            Icon(Icons.camera_alt_rounded),
                                            SizedBox(width: 10,),
                                            Text('Take Picture'),
                                          ],
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              Icon(
                                Icons.attach_file, color: Colors.grey,
                              ),
                              SizedBox(width: 5,),

                              Text('Attach Files ', style: TextStyle(
                                  color: Colors.grey),)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          if(desc.text.isEmpty || amt.text.isEmpty || dropdownValue!.isEmpty)
                            {
                              Fluttertoast.showToast(
                                  msg: "Please Enter Mandatotary Details!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          else
                            {
                              addData();

                            }

                        },
                        child: Container(
                          height: 45,
                          width: 320,
                          decoration: BoxDecoration(
                              color: Color(0xff315ccf),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Text('Submit', style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),)),
                        ),
                      )
                    ],
                  )
              ),
            ),
          ),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = XFile(image.path);
      final path = 'files/${image.name}';
      final file = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = XFile(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }


  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    var file = File(image!.path);

    if (image != null) {
      //Upload to Firebase
      var snapshot = await _firebaseStorage
          .ref()
          .child('images/imageName')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } else {
      print('No Image Path Received');
    }
  }




  addData() async
  {
    uploadImage();
    final user = FirebaseAuth.instance.currentUser!.uid;
    print(user);
    print(dropdownValue.toString());
    CollectionReference reference = FirebaseFirestore.instance.collection(
        'Project_Details');
    DocumentReference documentReference = reference.doc();
    await documentReference.set({
      'id' : user,
      'description': desc.text,
      'amount': amt.text,
      'project_name': dropdownValue.toString(),
      'bill_image': imageUrl.toString(),
      'timestamp' : DateTime.now()
    }).whenComplete(() => () {
      print('Addedd successfully !!');
    });
  }

}
