import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            title: Text(
              'LIO - Let It Out',
              style: TextStyle(
                  fontFamily: 'Francois One',
                  fontSize: 27,
                  color: Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage("assets/girl/2.png"))),
              )
            ],
          ),
          SliverStaggeredGrid(
            delegate: SliverChildBuilderDelegate((BuildContext context, int a) {
              return Container(
                height: 120,
                // width: 120,
                color: Colors.redAccent,
              );
            }),
            gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                staggeredTileBuilder: (int a) => StaggeredTile.fit(2),
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                staggeredTileCount: 5),
          )
        ],
      ),
    );
  }
}
