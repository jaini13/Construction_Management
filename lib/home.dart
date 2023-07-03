

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? date;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                height: 100,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff315ccf)
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text('Current Balance',
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.white
                      ),),
                      SizedBox(height: 7,),
                      Text(' 3200.90 INR',
                          style: TextStyle(
                              color: Colors.white,
                            fontSize: 20
                          )),
                      SizedBox(height: 20,),


                    ],
                  ),
                ),

              ),
              SizedBox(height: 20,),

              Row(children: [
                Text('Recent Transaction ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),),
                Spacer(),

              ],),
              SizedBox(height: 10,),

              Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Project_Details').snapshots(),
                  builder: (context, snapshot)
                  {
                    if(snapshot.hasData)
                      {
                        return ListView.separated(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Timestamp t = snapshot.data?.docs[index]['timestamp'] as Timestamp;
                            DateTime date = t.toDate();

                            return  Container(
                              height: 50,
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap:()
                                      {
                                        showImageViewer(
                                            context,
                                            snapshot.data?.docs[index]['bill_image']==null?
                                            Image.asset('assets/no_image.jpg').image:
                                            Image.network(snapshot.data?.docs[index]['bill_image']).image,
                                            useSafeArea: true,
                                            backgroundColor: Colors.transparent,
                                            swipeDismissible: false);
                                      },
                                      child: Image.asset('assets/pencil.png',height: 35,)),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text(snapshot.data?.docs[index]['project_name'],style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          //// in 25 years
                                          Text(Jiffy.parse(date.toString()).toNow().toString(),style: TextStyle(
                                              color: Colors.grey
                                          ),),
                                          SizedBox(width: 4,),
                                          Container(
                                            height: 5,
                                            width: 5,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle
                                            ),
                                          ),
                                          SizedBox(width: 4,),

                                          Text(snapshot.data?.docs[index]['description'],style: TextStyle(
                                              color: Colors.grey
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Color(0xffe1ebf7),
                                        borderRadius: BorderRadius.circular(10)
                                    ),

                                    child: TextButton(onPressed: () {
                                    }, child: Text('-'+snapshot.data?.docs[index]['amount']+' INR',style: TextStyle(
                                      color: Colors.red,
                                    ),)),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                                height: 10,
                                child: Divider(height: 7,));
                          },
                        );
                      }
                    else
                      {
                        Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    return Center(
                      child: CircularProgressIndicator(
                        
                      ),
                    );
                        },),
              ),

            ]))));
    }}