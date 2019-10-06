import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  final DocumentSnapshot room_snap;
  final DocumentReference room;
  Color backgroundColor;
  ChatPage(
      {@required this.room,
      @required this.room_snap,
      @required this.backgroundColor});

  final _messagecontroller = TextEditingController();

  void _senddata(BuildContext context) {
    String _message = _messagecontroller.text;
    String _sender_id = Provider.of<FirebaseUser>(context).uid;
    FieldValue _time = FieldValue.serverTimestamp();
    if (_message != "")
      room.collection('chats').add(
          {'message': _message, 'sender_id': _sender_id, 'created': _time});
  }

  String clean(String data) {
    List<String> stopwordrs = ['bad'];
    String fdata = "";
    for (var w in data.split(' ')) {
      if (stopwordrs.contains(w)) {
        for (var a in w.split('')) {
          fdata = fdata + '*';
        }
      } else {
        fdata = fdata + w;
      }
      fdata = fdata + " ";
    }
    return fdata;
  }

  @override
  void dispose() {
    _messagecontroller.dispose();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(room_snap.data['name']),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 45,
            top: 0,
            left: 0,
            right: 0,
            child: Hero(
              tag: room.documentID + "_background",
              child: Container(
                color: backgroundColor.withOpacity(0.8),
                child: StreamBuilder(
                  stream: room
                      .collection('chats')
                      .orderBy('created', descending: false)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> chats) {
                    if (!chats.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(
                        child: ListView.builder(
                          itemCount: chats.data.documents.length + 1,
                          itemBuilder: (_, index) {
                            if (index < chats.data.documents.length) {
                              // return ListTile(
                              //   title: Text(clean(
                              //        )),
                              // );
                              return Row(
                                mainAxisAlignment: chats.data.documents[index]
                                            .data['sender_id'] ==
                                        Provider.of<FirebaseUser>(context).uid
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    // alignment:  Alignment.bottomRight
                                    //     : Alignment.bottomLeft,
                                    margin: EdgeInsets.all(8),
                                    // width: 230,
                                    // height: 230,
                                    constraints: BoxConstraints(maxWidth: 230),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.5),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15),
                                            bottomLeft: chats
                                                        .data
                                                        .documents[index]
                                                        .data['sender_id'] ==
                                                    Provider.of<FirebaseUser>(
                                                            context)
                                                        .uid
                                                ? Radius.circular(15)
                                                : Radius.circular(0),
                                            bottomRight: chats
                                                        .data
                                                        .documents[index]
                                                        .data['sender_id'] ==
                                                    Provider.of<FirebaseUser>(
                                                            context)
                                                        .uid
                                                ? Radius.circular(0)
                                                : Radius.circular(15))),
                                    child: Text(
                                      chats.data.documents[index]
                                          .data['message'],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Row(
              children: <Widget>[
                Container(
                  width: 300.0,
                  child: TextField(
                    controller: _messagecontroller,
                    decoration: InputDecoration(
                      hintText: "Enter data to send",
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text("Send"),
                  onPressed: () => _senddata(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
