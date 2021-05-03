import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:review/card.dart';
import 'package:review/SideDrawer.dart';
import 'package:rating_dialog/rating_dialog.dart';

List<Map<dynamic, dynamic>> lists = [];
final databaseReference = FirebaseDatabase.instance.reference();
final dbRef = FirebaseDatabase.instance.reference().child("Movies");

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final _auth = FirebaseAuth.instance;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getData();
  }

  void getData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      print('hii');
      print('Data : ${snapshot.value}');
    });
  }

  void getUser() async {
    final User user = _auth.currentUser;
    try {
      if (user != null) print(user.email);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: SideDrawer(),
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          MaterialButton(
              child: Text(
                'rate',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                _showRatingAppDialog();
              })
        ],
        title: Text(
          '  WATCH GUIDE   ',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FutureBuilder(
                  future: dbRef.once(),
                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      lists.clear();
                      Map<dynamic, dynamic> values = snapshot.data.value;
                      int cnt = 0;
                      values.forEach((key, values) {
                        print(key);
                        print(values);
                        print(cnt);
                        lists.insert(cnt, values);

                        cnt++;
                      });
                      return Scrollbar(
                        isAlwaysShown: true,
                        controller: _scrollController,
                        child: new ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: lists.length,
                            itemBuilder: (BuildContext context, int index) {
                              return MyCard(
                                  url: lists[index]['poster'].toString(),
                                  name: lists[index]['name'].toString(),
                                  imdb: lists[index]['imdb'].toString(),
                                  description:
                                      lists[index]['description'].toString());
                            }),
                      );
                    }
                    return CircularProgressIndicator();
                  })
            ],
          ),
        ),
      ),
    );
  }

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: 'Rating Dialog In Flutter',
      message: 'Rating this app and tell others what you think.'
          ' Add more description here if you want.',
      image: Image.asset(
        "assets/images/devs.jpg",
        height: 100,
      ),
      submitButton: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, '
            'comment: ${response.comment}');

        if (response.rating < 3.0) {
          print('response.rating: ${response.rating}');
        } else {
          Container();
        }
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }
}
