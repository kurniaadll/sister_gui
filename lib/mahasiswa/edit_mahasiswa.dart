import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mahasiswa_sister/first_page.dart';

class EditMahasiswa extends StatefulWidget {
  final int id;
  final String nama;
  final String email;
  final DateTime tgllahir;

  EditMahasiswa({Key? key,
    required this.id,
    required this.nama,
    required this.email,
    required this.tgllahir,
  }) : super(key: key);


  @override
  State<EditMahasiswa> createState() => _EditMahasiswaState();
}

late int id;
final TextEditingController _nameeditController = TextEditingController();
final TextEditingController _emaileditController = TextEditingController();
late DateTime tgllahir;

class _EditMahasiswaState extends State<EditMahasiswa> {

  Future<void> updateMahasiswa() async {
    String urlUpdate =
        "http://192.168.100.137:9001/api/v1/mahasiswa/${id}?nama=${_nameeditController.text}&&email=${_emaileditController.text}&&tgllahir=${"${tgllahir.toLocal()}".split(" ")[0]}";

    try {
      var response = await http.put(
        Uri.parse(urlUpdate),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  void initState(){
    id = widget.id;
    _nameeditController.text = widget.nama;
    _emaileditController.text = widget.email;
    tgllahir = widget.tgllahir;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? kalender = await showDatePicker(
      context: context,
      initialDate: tgllahir,
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );

    if (kalender != null && kalender != tgllahir) {
      setState(() {
        tgllahir = kalender;
      });
    }
  }

  String formatDate(DateTime date){
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(240, 235, 206, 1.0),
        foregroundColor: Color.fromRGBO(57, 81, 68, 1.0),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Edit Data Mahasiswa',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: Color.fromRGBO(57, 81, 68, 1.0),
                ),
              ),
              SizedBox(height: 100,),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(253, 247, 228, 1.0),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 4)
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Address',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color.fromRGBO(78, 108, 80, 0.8),
                        ),
                      ),
                      TextField(
                        controller: _emaileditController,
                        cursorColor: Colors.black,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.email_outlined),
                            prefixIconColor: Color.fromRGBO(78, 108, 80, 0.8),
                            hintText: 'Email'
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(253, 247, 228, 1.0),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 4),
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color.fromRGBO(78, 108, 80, 0.8),
                        ),
                      ),
                      TextField(
                        controller: _nameeditController,
                        cursorColor: Colors.black,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person_2_outlined),
                          prefixIconColor: Color.fromRGBO(78, 108, 80, 0.8),
                          hintText: 'Nama Mahasiswa',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(253, 247, 228, 1.0),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 4),
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Birth Date',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color.fromRGBO(78, 108, 80, 0.8),
                        ),
                      ),
                      TextField(
                        controller: TextEditingController(
                            text: "${tgllahir.toLocal()}".split(" ")[0]
                        ),
                        cursorColor: Colors.black,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.date_range),
                          prefixIconColor: Color.fromRGBO(78, 108, 80, 0.8),
                          hintText: 'DD/MM/YYYY',
                          suffixIcon: IconButton(
                            onPressed: (){
                              _selectDate(context);
                            },
                            icon: Icon(
                              Icons.edit_calendar,
                              color: Color.fromRGBO(57, 81, 68, 1.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () async{
                      await updateMahasiswa();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LandingPage()));
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(240, 235, 206, 1.0),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins'
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      backgroundColor: Color.fromRGBO(57, 81, 68, 1.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
