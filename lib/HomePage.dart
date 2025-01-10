import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              backgroundColor: Colors.black,
            leading: Image.asset('images/netflix.png'),
            actions: [
              MaterialButton(onPressed: (){

              },
              child: Icon(Icons.search, color: Colors.white,),)
            ],
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
               Expanded(flex: 1,child:  MaterialButton(onPressed: (){} ,
                 child: const Column(
                   children: [
                     Icon(Icons.add , color: Colors.white,),
                     Text('Add' , style: TextStyle(color: Colors.white),)
                   ],
                 ),),),
                Expanded(flex: 1,child:  MaterialButton(onPressed: (){} ,
                  child: const Column(
                    children: [
                      Icon(Icons.add , color: Colors.white,),
                      Text('Add' , style: TextStyle(color: Colors.white),)
                    ],
                  ),),),
                Expanded(flex: 1,child:  MaterialButton(onPressed: (){} ,
                  child: const Column(
                    children: [
                      Icon(Icons.add , color: Colors.white,),
                      Text('Add' , style: TextStyle(color: Colors.white),)
                    ],
                  ),),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
