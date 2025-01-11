import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Detailpage extends StatelessWidget {
  final dynamic show;

  const Detailpage({super.key, required this.show});

  Future<void> showDetail(BuildContext context) async {
    String url = show['url'];
    Uri? uri = Uri.tryParse(url);
    if (uri == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unreachable Movie')),
      );
      return;
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.black,
                iconTheme: const IconThemeData(color: Colors.white),
                expandedHeight: 600.0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: _buildAppbarBack(),
                ),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: MaterialButton(
                    color: Colors.white70,
                    onPressed: () async {
                      showDetail(context);
                    },
                    child: (const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Icon(Icons.play_arrow), Text('View Details')],
                    ))),
              ),
              SliverToBoxAdapter(
                child: _buildString(show['summary']),
              ),
              const SliverToBoxAdapter(
                  child: SizedBox(
                height: 20,
              )),
              SliverToBoxAdapter(
                  child: Row(
                children: [
                  const Text(
                    'Genres: ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  _buildGenre()
                ],
              ))
            ],
          ),
        ));
  }

  Widget _buildAppbarBack() {
    String? imageUrl = null;
    if (show['image'] != null && show['image']['original'] != null) {
      imageUrl = show['image']['original'];
    }
    if (show['image'] != null && show['image']['medium'] != null) {
      imageUrl = show['image']['medium'];
    }

    if (imageUrl == null) {
      return Container(
        child: Icon(Icons.tv, color: Colors.white, size: 150,),
      );
    }

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken))),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: SizedBox(
                width: 200,
                height: 400,
                child: Image.network(imageUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTile(show['language'], 'Language:'),
                  _buildTile(show['premiered'], 'Premiered On:'),
                  _buildTile(show['rating']['average'], 'Rating:'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildString(String text) {
    text = text.replaceAll("<b>", "");
    text = text.replaceAll("</b>", "");
    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 15),
    );
  }

  Widget _buildGenre() {
    List<String> genres = [];

    for (var item in show['genres']) {
      genres.add(item);
    }

    return Center(
      child: Text(
        genres.join(', '),
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }

  Widget _buildTile(dynamic text, String head){
    text ??= 'Unknown';

    if(head == 'Rating:'){
      text = text.toString()+' ⭐';
    }
    return Expanded(
        flex: 1,
        child: Center(
            child: Column(
              children: [
                Text(
                  head,
                  style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                ),
                Text(
                  text.toString(),
                  style: TextStyle(color: Colors.white),
                )
              ],
            )));
  }
}
