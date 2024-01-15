import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mahasiswa_sister/first_page.dart';
import 'package:mahasiswa_sister/matakuliah/list_matakuliah.dart';

class InsertMatakuliah extends StatefulWidget {
  const InsertMatakuliah({super.key});

  @override
  State<InsertMatakuliah> createState() => _InsertMatakuliahState();
}

TextEditingController _kodeController = TextEditingController();
TextEditingController _namaController = TextEditingController();
TextEditingController _sksController = TextEditingController();

class _InsertMatakuliahState extends State<InsertMatakuliah> {

  Future<void> insertMatakuliah() async {
    final String apiUrl = 'http://10.127.253.3:9002/api/v1/matakuliah';

    Map<String, dynamic> matkulData = {
      'kode': _kodeController.text,
      'nama': _namaController.text,
      'sks':  _sksController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(matkulData),
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
                    'Insert Matakuliah',
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
                            'Kode Matakuliah',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color.fromRGBO(78, 108, 80, 0.8),
                            ),
                          ),
                          TextField(
                            controller: _kodeController,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.code),
                                prefixIconColor: Color.fromRGBO(78, 108, 80, 0.8),
                                hintText: 'Kode'
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
                            'Nama Matakuliah',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color.fromRGBO(78, 108, 80, 0.8),
                            ),
                          ),
                          TextField(
                            controller: _namaController,
                            cursorColor: Colors.black,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.book_outlined),
                              prefixIconColor: Color.fromRGBO(78, 108, 80, 0.8),
                              hintText: 'Nama Matakuliah',
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
                            'Jumlah SKS',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color.fromRGBO(78, 108, 80, 0.8),
                            ),
                          ),
                          TextField(
                            controller: _sksController,
                            cursorColor: Colors.black,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.watch_later_outlined),
                              prefixIconColor: Color.fromRGBO(78, 108, 80, 0.8),
                              hintText: 'Sks',
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
                          await insertMatakuliah();
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

