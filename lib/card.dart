import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:review/likeButton.dart';
import 'package:review/shareButton.dart';

class MyCard extends StatelessWidget {
  final String url;
  final String name;
  final String description;
  final String imdb;
  MyCard(
      {@required this.url,
      @required this.name,
      @required this.description,
      @required this.imdb});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: <Widget>[
                  Image.network(
                    url,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        Emojis.star + imdb,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20).copyWith(bottom: 0),
            child: Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                child: AnimatedIconButton(
                  iconData: Icons.favorite,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: 40,
                height: 40,
                child: AnimatedIconButtonShare(
                  iconData: Icons.share_outlined,
                  link: url,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
