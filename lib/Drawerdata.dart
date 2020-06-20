import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/foundation.dart';
import  'Readmore.dart';
import 'Post.dart';

class Pagelinks extends StatefulWidget {
  @override
  _PagelinksState createState() => _PagelinksState();
}

class _PagelinksState extends State<Pagelinks> {

  List data;


  Future<List<Post>> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://biswaroop.com/wp-json/wp/v2/pages"),
        headers: {
          "Accept": "application/json"
        }
    );

    data = json.decode(response.body);
    List<Post> posts=[];
    for(var post in data){
      Post p=new Post(post["id"],post["title"]["rendered"],post["content"]["rendered"],post["excerpt"]["rendered"],post['link']);
      posts.add(p);
    }


    //print(data);
    return posts;
  }



  @override
  void initState(){
    super.initState();
    this.getData();

  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.data == null){
            return Container(
              child: Center(
                child: Text('Loading'),
              ),
            );
          }else{
            return ListView.builder( scrollDirection: Axis.vertical,
                shrinkWrap: true, itemCount: snapshot.data.length == null ? 0 : snapshot.data.length,itemBuilder: (BuildContext context, int index){

              return
                GestureDetector(
                  child: Html(data:'${snapshot.data[index].title}',),
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => Readmore(snapshot.data[index]),
                      ),
                    );
                  },
                );
            }
            );
          }
        }
    );
  }
}

