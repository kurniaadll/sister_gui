import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mahasiswa_sister/first_page.dart';
import 'package:mahasiswa_sister/mahasiswa/edit_mahasiswa.dart';
import 'package:mahasiswa_sister/nilai/nilai_mahasiswa.dart';

class DataMahasiswa extends StatefulWidget {
  const DataMahasiswa({Key? key, required this.id, required this.nm, required this.ml, required this.tgl}) : super(key: key);
  final int id;
  final String nm;
  final String ml;
  final String tgl;

  @override
  State<DataMahasiswa> createState() => _DataMahasiswaState();
}

class _DataMahasiswaState extends State<DataMahasiswa> with SingleTickerProviderStateMixin {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(240, 235, 206, 1.0),
        foregroundColor: Color.fromRGBO(57, 81, 68, 1.0),
        automaticallyImplyLeading: true,
        elevation: 0,
        title: const Text(
          'Detail Mahasiswa',
          style: TextStyle(
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 300,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(57, 81, 68, 1.0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
              )
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(240, 235, 206, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.nm,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(240, 235, 206, 1.0),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => EditMahasiswa(
                                id: widget.id,
                                nama: widget.nm,
                                email: widget.ml,
                                tgllahir: DateTime.parse(
                                    widget.tgl),
                              )
                              )
                          );
                        },
                        icon: Icon(Icons.edit,size: 17, color: Color.fromRGBO(240, 235, 206, 1.0)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.ml,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(240, 235, 206, 0.8),
                            ),
                          ),
                          Text(
                            ' | ',
                            style: TextStyle(
                              fontSize: 18,
                                color: Color.fromRGBO(240, 235, 206, 0.6),
                              fontWeight: FontWeight.w300
                            ),
                          ),
                          Text(
                            widget.tgl,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(240, 235, 206, 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: SizedBox(
              width: 280,
              height: 50,
              child: ElevatedButton(
                onPressed: () async{
                  Navigator
                      .of(context)
                      .push(MaterialPageRoute(builder: (context) => NilaiList(widget.id)));
                },
                child: Text(
                  'Lihat Nilai',
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
    );
  }
}
