import 'package:flutter/material.dart';
import 'package:mahasiswa_sister/matakuliah/list_matakuliah.dart';
import 'package:mahasiswa_sister/nilai/list_nilai.dart';
import 'mahasiswa/list_mahasiswa.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: const Color.fromRGBO(57, 81, 68, 1.0),
          body: TabBarView(
            children: [
              ListMahasiswa(),
              ListMatakuliah(),
              ListNilai()

            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.people_alt_outlined,
                ),
                text: 'Mahasiswa',
              ),
              Tab(
                icon: Icon(
                  Icons.collections_bookmark_rounded,
                ),
                text: 'Matakuliah',
              ),
              Tab(
                icon: Icon(
                  Icons.collections_bookmark_rounded,
                ),
                text: 'Nilai',
              ),
            ],





            labelColor: const Color.fromRGBO(240, 235, 206, 1),
            unselectedLabelStyle: TextStyle(color: const Color.fromRGBO(57, 81, 68, 1.0)),
            indicatorColor: const Color.fromRGBO(240, 235, 206, 1),
          ),
        ),
      ),
    );
  }
}
