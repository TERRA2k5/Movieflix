import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'DetailPage.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  List<dynamic> searchResult = [];  // Moved this outside of build method
  final searchController = TextEditingController();

  Future<void> searchApi(String query) async {
    if(query == ""){
      setState(() {
        searchResult = [];  // Update result with the API response
      });
      return;
    }
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        searchResult = data;  // Update result with the API response
      });
      print("response is " + data.toString());
    } else {
      setState(() {
        searchResult = [];  // In case of error, clear the list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                onChanged: (query) => searchApi(query),
                onSubmitted: (query) => searchApi(query),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: searchResult.isEmpty
                ? Column(children: [ SizedBox(height: 200,),Center(child: Center(child: Container(height: 200, width: 400, child: Image.asset('images/NoResult.png'),),),)],)
                : SizedBox(
              height: MediaQuery.of(context).size.height - 200, // Constrain height of GridView
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: searchResult.length,
                itemBuilder: (context, index) {
                  final movie = searchResult[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Detailpage(listItem: movie)));
                    },
                    child: _buildGridTile(index)
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridTile(int index){
    final show = searchResult[index]['show'];

    String? imageUrl = null;
    if(show['image'] != null && show['image']['original'] != null){
      imageUrl = show['image']['original'];
    }
    if(show['image'] != null && show['image']['medium'] != null){
      imageUrl = show['image']['medium'];
    }
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[900],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageUrl != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              height: 120,
              width: 100,
              fit: BoxFit.cover,
            ),
          )
              : const Icon(Icons.tv, size: 80),
          const SizedBox(height: 8),
          Text(
            show['name'] ?? 'Unknown',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
