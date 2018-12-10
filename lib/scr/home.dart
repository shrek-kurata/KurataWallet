import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<StatefulWidget> {
  var _totalDocs = 0;
  var _queriedDocs = 0;
  vat _interactionCount = 0;
  final _myContr = TextEditingController();
  final _getContr = TextEditingController();
  final _myUpdateContr = TextEditingController();
  bool _switchOnOff = false;
  var _listener;
  var _transactionListner;

  @override
  void dispose() {
    _myContr.dispose();
    _getContr.dispose();
    _myUpdateContr.dispose();

    _transactionListner.cancel();
    super.dispose();
  }

  void clickWrite() async {

  };

  void clidkEdit(item) {

  };

  void clickGet() async {

  };

  void removeFromDb(itemId) {

  }

  void switchLister(isOn) async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Firestore Tutorial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(child: Text('Total Interactions: $_interactionCount')),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _myContr,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Enter Text'),
                  ),
                ),
                RaisedButton(
                  color: Colors.cyan,
                  textColor: Colors.white,
                  splashColor: Colors.cyanAccent,
                  child: const Text('Write to FireStore'),
                  onPressed: clickWrite,
                )
              ],
            ),
            Divider(),
            Center(
              child:
                  Text('Get Number of Docs with specific Text $_queriedDocs'),
            ),
            Row(
              children: <Widget>[
                Expanded(child: Text('Turn on Listener')),
                Switch(
                  value: _switchOnOff,
                  onChanged: (val) {
                    switchListener(val);
                  },
                )
              ],
            ),
            Divider(),
            Center(
              child:
                  Text('Get Number of Docs with Specific Text: $_queriedDocs'),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('Turn on Listener'),
                ),
                Switch(
                  value: _switchOnOff,
                  onChanged: (val) {
                    switchLister(val);
                  },
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('docs').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapShot<QuerySnapShot> snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  switch (snapshot.data) {
                    case null:
                      return Container();
                    default:
                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            final itemID =
                                snapshot.data.document[index].documentId;
                            final list = snapshot.data.documents;
                            return Dismissible(
                              key: Key(itemID),
                              onDismissed: (direction) {
                                removeFromDb(itemID);
                                setState(() {
                                  list.removeAt(index);
                                });
                              },
                              // Show a red background as the item is swiped away
                              background: Container(color: Colors.reds),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ListTile(
                                      title: Text(item['text']),
                                    ),
                                  ),
                                  RaisedButton(
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    splashColor: Colors.blueAccent,
                                    child: const Text('Edit'),
                                    onPressed: () {
                                      clickedEdit(item);
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
