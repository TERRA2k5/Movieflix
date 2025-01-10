import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:movieflix/main.dart';

import 'DetailPage.dart';

class Homepage extends StatefulWidget {
  final VoidCallback onSearchButtonPressed;

  const Homepage({super.key, required this.onSearchButtonPressed});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> allShow = [];
  List<dynamic> drama = [];
  List<dynamic> sport = [];
  List<dynamic> anime = [];
  List<dynamic> medical = [];
  List<dynamic> comedy = [];
  List<dynamic> legal = [];
  List<dynamic> childrens = [];
  List<dynamic> music = [];


  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  Future<void> fetchAll() async {
    const allUrl = 'https://api.tvmaze.com/search/shows?q=all';
    try {
      final response = await http.get(Uri.parse(allUrl));
      if (response.statusCode == 200) {
        setState(() {
          allShow = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }

    for(var item in allShow){
      for(var genre in item['show']['genres']){
        if(genre == 'Drama'){
          drama.add(item);
        }
        if(genre == 'Comedy'){
          comedy.add(item);
        }
        if(genre == 'Sports'){
          sport.add(item);
        }
        if(genre == 'Legal'){
          legal.add(item);
        }
        if(genre == 'Medical'){
          medical.add(item);
        }
        if(genre == 'Children'){
          childrens.add(item);
        }
        if(genre == 'Music'){
          music.add(item);
        }
        if(genre == 'Anime')
          anime.add(item);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.grey,))
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.black,
                  pinned: true,
                  expandedHeight: 300.0,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    title: SizedBox(width: 250, child: Padding(padding: EdgeInsets.all(8), child: Image.asset('images/MOVIEFLIX.png'),)),
                    centerTitle: true,
                    background: CarouselSlider.builder(
                      itemCount: allShow.length,
                      options: CarouselOptions(
                        autoPlay: true, // Enable autoplay
                        autoPlayInterval: Duration(seconds: 5), // Time interval between slides
                        autoPlayAnimationDuration: Duration(milliseconds: 800), // Animation duration
                        enlargeCenterPage: true, // Enlarging the current slide
                        aspectRatio: 2.0, // Aspect ratio of the images
                        viewportFraction: 0.8, // Fraction of the screen each item will take
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final show = allShow[index]['show'];
                        String? imageUrl = show['image'] != null ? show['image']['original'] : null;
                        if (imageUrl == null && show['image'] != null) {
                          imageUrl = show['image']['medium'];
                        }

                        return imageUrl != null
                            ? Image.network(
                          imageUrl,
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        )
                            : const Icon(Icons.tv, size: 80, color: Colors.white,);
                      },
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        widget.onSearchButtonPressed();
                      },
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildIconButton(Icons.access_time, 'Recent'),
                        _buildIconButton(Icons.play_arrow, 'Details'),
                        _buildIconButton(Icons.favorite, 'Favorite'),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.all(16),
                    child: Text('All Shows' , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white), ),),
                ),
                SliverToBoxAdapter(
                  child:_buildSilverList(allShow)
                ),
                const SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.all(16),
                    child: Text('Dramas' , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white), ),),
                ),

                SliverToBoxAdapter(
                    child:_buildSilverList(drama)
                ),

                const SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.all(16),
                    child: Text('Sports' , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white), ),),
                ),

                SliverToBoxAdapter(
                    child:_buildSilverList(sport)
                ),

                const SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.all(16),
                    child: Text('Music' , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white), ),),
                ),
                SliverToBoxAdapter(
                    child:_buildSilverList(music)
                ),

                const SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.all(16),
                    child: Text('Legal' , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white), ),),
                ),
                SliverToBoxAdapter(
                    child:_buildSilverList(legal)
                ),

                const SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.all(16),
                    child: Text('Anime' , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white), ),),
                ),
                SliverToBoxAdapter(
                    child:_buildSilverList(anime)
                ),

                const SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.all(16),
                    child: Text('Comedy' , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white), ),),
                ),
                SliverToBoxAdapter(
                    child:_buildSilverList(comedy)
                ),

                const SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.all(16),
                    child: Text('Medical' , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white), ),),
                ),
                SliverToBoxAdapter(
                    child:_buildSilverList(medical)
                ),

                const SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.all(16),
                    child: Text('Children' , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white), ),),
                ),

                SliverToBoxAdapter(
                    child:_buildSilverList(childrens)
                ),
              ],
            ),
    );
  }

  Widget _buildIconButton(IconData icon, String label) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$label clicked')),
            );
          },
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSilverList(List<dynamic> list){
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (_, index) {
          final movie = list[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Detailpage(listItem: movie)));
            },
            child: _buildGridTile(list, index));
        },
      ),
    );
  }

  Widget _buildGridTile(List<dynamic> list , int index){
    final show = list[index]['show'];

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
