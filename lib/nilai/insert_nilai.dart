import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mahasiswa_sister/nilai/list_nilai.dart';

class InsertNilai extends StatefulWidget {
  const InsertNilai({super.key});

  @override
  State<InsertNilai> createState() => _InsertNilaiState();
}

class _InsertNilaiState extends State<InsertNilai> {
  List<Map<String, dynamic>> namaMahasiswa = [];
  List<Map<String, dynamic>> namaMatakuliah = [];
  int? idmahasiswa;
  int? idmatakuliah;
  final nilai = TextEditingController();

  Future<void> insertNilai() async {
      String urlInsert = "http://192.168.100.137:9003/api/v1/nilai";
      final Map<String, dynamic> data = {
        "idmahasiswa": idmahasiswa,
        "idmatakuliah": idmatakuliah,
        "nilai": int.parse(nilai.text)
      };

      try {
        var response = await http.post(Uri.parse(urlInsert),
            body: jsonEncode(data),
            headers: {'Content-Type': 'application/json'});

        if (response.statusCode == 200) {
          Navigator.pop(context, "berhasil");
        } else {
          print("Gagal");
        }
      } catch (e) {
        print(e);
      }
  }

  @override
  void initState() {
    super.initState();
    getMahasiswa();
    getMatakuliah();
  }

  Future<void> getMahasiswa() async {
    String urlMahasiswa = "http://192.168.100.137:9001/api/v1/mahasiswa";
    try {
      var response = await http.get(Uri.parse(urlMahasiswa));
      final List<dynamic> dataMhs = jsonDecode(response.body);
      setState(() {
        namaMahasiswa = List.from(dataMhs);
      });
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> getMatakuliah() async {
    String urlMatakuliah = "http://192.168.100.137:9002/api/v1/matakuliah";
    try {
      var response = await http.get(Uri.parse(urlMatakuliah));
      final List<dynamic> dataMk = jsonDecode(response.body);
      setState(() {
        namaMatakuliah = List.from(dataMk);
      });
    } catch (exc) {
      print(exc);
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
                  'Insert Nilai',
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
                        DropdownButtonFormField(
                          value: null,
                          onChanged: (value) {
                            setState(() {
                              idmahasiswa = int.parse(value.toString());
                            });
                          },
                          items: namaMahasiswa.map((item) {
                            return DropdownMenuItem(
                                value: item["id"].toString(),
                                child: Text(item["nama"]
                                )
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Nama Mahasiswa",
                            prefixIcon: Icon(Icons.person_2_outlined),
                            prefixIconColor: Color.fromRGBO(78, 108, 80, 0.8),
                              border: InputBorder.none
                          ),
                        ),
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
                        DropdownButtonFormField(
                          value: null,
                          onChanged: (value) {
                            setState(() {
                              idmatakuliah = int.parse(value.toString());
                            });
                          },
                          items: namaMatakuliah.map((item) {
                            return DropdownMenuItem(
                                value: item["id"].toString(),
                                child: Text(item["nama"].toString()
                                )
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Nama Matakuliah",
                            prefixIcon: Icon(Icons.book_outlined),
                            prefixIconColor: Color.fromRGBO(78, 108, 80, 0.8),
                            border: InputBorder.none
                          ),
                          ),
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
                          'Nilai Mahasiswa',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Color.fromRGBO(78, 108, 80, 0.8),
                          ),
                        ),
                        TextField(
                          controller: nilai,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.checklist_rtl),
                            prefixIconColor: Color.fromRGBO(78, 108, 80, 0.8),
                            hintText: 'Nilai',
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
                        await insertNilai();
                        Navigator
                            .of(context)
                            .push(MaterialPageRoute(builder: (context) => ListNilai()));
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