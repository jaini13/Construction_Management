import 'package:flutter/material.dart';
import 'package:task_today/profile.dart';
import 'home.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  String dropdownValue = 'Project1';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

     backgroundColor:Color(0xffEEEEEE),
      body: Center(
        child: Card(
          elevation: 5,
          child: Container(
            height: 350,
            width: 340,
            decoration: BoxDecoration(
              color: Color(0xffF8F6F4),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 320,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Title',
                      filled: true,
                      fillColor: Color(0xffeceff6),
                      border:  OutlineInputBorder(
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
                    decoration: InputDecoration(
                      hintText: 'Description',
                      filled: true,
                      fillColor: Color(0xffeceff6),
                      border:  OutlineInputBorder(
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
                    decoration: InputDecoration(
                      hintText: 'Amount',
                      filled: true,
                      fillColor: Color(0xffeceff6),
                      border:  OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                Padding(
                  padding: EdgeInsets.only(right: 17,left: 17),
                  child: DropdownButtonFormField(

                      decoration: InputDecoration(
                        filled: true,
                        fillColor:  Color(0xffeceff6),
                      ),
                      dropdownColor:  Color(0xffeceff6),
                      iconEnabledColor: Colors.white,


                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Project1', 'Project2', 'Project3'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 15,color: Colors.black87),
                          ),
                        );
                      }).toList()),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 45,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Color(0xff315ccf),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text('Submit',style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),)),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
