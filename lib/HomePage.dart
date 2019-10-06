import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lio/ChatPage.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             backgroundColor: Colors.white,
//             title: Text(
//               'LIO - Let It Out',
//               style: TextStyle(
//                   fontFamily: 'Francois One',
//                   fontSize: 27,
//                   color: Colors.black),
//             ),
//             actions: <Widget>[
//               IconButton(
//                 padding: EdgeInsets.all(0),
//                 icon: Icon(
//                   Icons.more_vert,
//                   color: Colors.black,
//                 ),
//                 onPressed: () {},
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 8.0),
//                 child: Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                     ),
//                     child: CircleAvatar(
//                         radius: 22,
//                         backgroundColor: Colors.transparent,
//                         backgroundImage: AssetImage("assets/girl/2.png"))),
//               )
//             ],
//           ),
//           // SliverGrid(
//           //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           //     crossAxisCount: 2
//           //   ),
//           //   delegate: SliverChildBuilderDelegate((BuildContext context,int a ) {
//           //     return Container(
//           //       margin: EdgeInsets.all(8),
//           //       height: 200,
//           //       color: Colors.black,
//           //     );
//           //   }),
//           // )
//           SliverStaggeredGrid.countBuilder(
//             crossAxisCount: 4,
//             itemCount: 8,
//             itemBuilder: (BuildContext context, int index) => new Container(
//                 color: Colors.green,
//                 child: new Center(
//                   child: new CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child: new Text('$index'),
//                   ),
//                 )),
//             staggeredTileBuilder: (int index) =>
//                 StaggeredTile.count(2, index.isEven ? 2 : 1),
//             mainAxisSpacing: 4.0,
//             crossAxisSpacing: 4.0,
//           )
//         ],
//       ),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  void _navigateToDayExpenses(BuildContext context, DocumentReference room) {
    // print(object)
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            ChatPage(
              room: room,
            ),
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(0.0, 1.0),
              ).animate(secondaryAnimation),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 1000)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('LIO - Let It Out',
            style: TextStyle(
                fontFamily: 'Francois One', fontSize: 27, color: Colors.black)),
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
      body: StreamBuilder(
          stream: Firestore.instance.collection('rooms').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(
              itemCount: snapshot.data.documents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 9 / 16, crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => _navigateToDayExpenses(
                      context, snapshot.data.documents[index].reference),
                  child: Container(
                    height: 200,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Hero(
                          tag: index.toString() + "_background",
                          child: Container(
                            color: Color.fromRGBO(255, 183, 183, 0.8),
                            // child: Text(snapshot.data.documents[index].data['name']),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data.documents[index].data['name'],
                            style: TextStyle(
                                fontSize: 38, fontStyle: FontStyle.italic),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
