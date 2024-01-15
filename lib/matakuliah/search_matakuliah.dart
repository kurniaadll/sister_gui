import 'package:flutter/material.dart';

class MatakuliahSearchDelegate extends SearchDelegate {
  final List<dynamic> matakuliah;

  MatakuliahSearchDelegate(this.matakuliah);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
        color: Color.fromRGBO(57, 81, 68, 1.0),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
      color: Color.fromRGBO(57, 81, 68, 1.0),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<dynamic> searchResults = matakuliah
        .where((matkul) =>
        matkul['nama'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            searchResults[index]['nama'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
          subtitle: Text(
            searchResults[index]['kode'],
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins',
            ),
          ),
          trailing: Text(
            '${searchResults[index]['sks']} SKS',
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'Poppins',
            ),
          ),
          onTap: () {
            close(context, searchResults[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<dynamic> suggestionList = matakuliah
        .where((matkul) =>
        matkul['nama'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index]['nama'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
          subtitle: Text(
            suggestionList[index]['kode'],
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins',
            ),
          ),
          trailing: Text(
            '${suggestionList[index]['sks']} SKS',
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'Poppins',
            ),
          ),
          onTap: () {
            close(context, suggestionList[index]);
          },
        );
      },
    );
  }
}
