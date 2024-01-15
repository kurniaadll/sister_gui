import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mahasiswa_sister/first_page.dart';

class EditMatakuliah extends StatefulWidget {
  EditMatakuliah(
      {Key? key,
        required this.id,
        required this.kode,
        required this.nama,
        required this.sks}) :
        super(key: key);
  final int id;
  final String kode;
  final String nama;
  final String sks;

  @override
  State<EditMatakuliah> createState() => _EditMatakuliahState();
}

late int id;
TextEditingController _kodeeditController = TextEditingController();
TextEditingController _nameeditController = TextEditingController();
TextEditingController _skseditController = TextEditingController();

class _EditMatakuliahState extends State<EditMatakuliah> {

  late int idmatkul;
  Future<void> updateMahasiswa() async {
    final String updateUrl ="http://10.127.253.3:9002/api/v1/matakuliah/${id}?kode=${_kodeeditController.text}&&nama=${_nameeditController.text}&&sks=${_skseditController.text}";

    try {
      var response = await http.put(
        Uri.parse(updateUrl),
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
    super.initState();
    id = widget.id;
    _kodeeditController.text = widget.kode;
    _nameeditController.text = widget.nama;
    _skseditController.text = widget.sks.toString();
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
                'Edit Data Matakuliah',
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
                        'Kode Matakuliah',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color.fromRGBO(78, 108, 80, 0.8),
                        ),
                      ),
                      TextField(
                        controller: _kodeeditController,
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
                        controller: _nameeditController,
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
                          hintText: 'Nama',
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
                        'Jumlah Sks',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color.fromRGBO(78, 108, 80, 0.8),
                        ),
                      ),
                      TextField(
                        controller: _skseditController,
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
