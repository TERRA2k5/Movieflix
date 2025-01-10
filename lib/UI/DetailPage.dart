import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detailpage extends StatelessWidget {
  final dynamic listItem;
  const Detailpage({super.key, required this.listItem});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
