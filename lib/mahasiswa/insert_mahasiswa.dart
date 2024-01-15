import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mahasiswa_sister/first_page.dart';

class InsertMahasiswa extends StatefulWidget {
  const InsertMahasiswa({super.key});

  @override
  State<InsertMahasiswa> createState() => _InsertMahasiswaState();
}

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  String formatDate(DateTime date){
    return DateFormat('yyyy-MM-dd').format(date);
  }

class _InsertMahasiswaState extends State<InsertMahasiswa> {

  Future<void> insertMahasiswa() async {
    final String apiUrl = 'http://10.127.253.3:9001/api/v1/mahasiswa';

    Map<String, dynamic> mahasiswaData = {
      'email': _emailController.text,
      'nama': _nameController.text,
      'tgllahir':  formatDate(DateTime.parse(_dateController.text)),
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(mahasiswaData),
      );

      if (response.statusCode == 200) {
        print('Data Mahasiswa berhasil disisipkan');
      } else {
        print('Gagal menyisipkan data Mahasiswa. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      if (error is http.Response) {
        print('Response Body: ${error.body}');
      }
    }
  }

  @override
  void initState(){
    super.initState();
    _dateController = TextEditingController(
      text: "${DateTime.now().toLocal()}".split(' ')[0],
    );
  }


  Future<void> _selectedDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1998),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dateController.text){
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(57, 81, 68, 1.0),
        foregroundColor: Color.fromRGBO(240, 235, 206, 1.0),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Insert Mahasiswa',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      color: Color.fromRGBO(57, 81, 68, 1.0)
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
                          controller: _emailController,
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
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Color.fromRGBO(78, 108, 80, 0.8),
                          ),
                        ),
                        TextField(
                          controller: _nameController,
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
                          controller: _dateController,
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
                                _selectedDate(context);
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
                        await insertMahasiswa();
                        Navigator
                            .of(context)
                            .push(MaterialPageRoute(builder: (context) => LandingPage()));
                      },
                      child: Text(
                        'Add',
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
      )
    );
  }
}

