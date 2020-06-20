

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/foundation.dart';
import 'package:vishva/Drawerdata.dart';
import  'Readmore.dart';
import 'Post.dart';
import 'Drawerdata.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Dr. Vishwaroop Rai Chaudhary ',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Dr. Biswaroop Rai Chaudhary'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data;


  Future<List<Post>> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://biswaroop.com/wp-json/wp/v2/posts"),
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

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),

      ),
      body: Container(
        child:FutureBuilder(
            future: getData(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text('Loading'),
                  ),
                );
              }else{
                return ListView.builder( itemCount: snapshot.data.length == null ? 0 : snapshot.data.length,itemBuilder: (BuildContext context, int index){

                  return  Card(

                    child:
                    ListTile(
                      title: Html(data:"<h3>"+'${snapshot.data[index].title}'+"</h3>",),
                      trailing: Icon(Icons.more_vert),
                      subtitle: Html(data:"<p>"+'${snapshot.data[index].excerpt}'+"</p>",),
                      hoverColor: Colors.black38,
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => Readmore(snapshot.data[index]),
                          ),
                        );
                      },
                    ),

                  );
                }
                );
              }
            }
        ),

    ),




  drawer: Drawer(


        child:ListView(

          children: [
        DrawerHeader(padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white
            )
            ,
          child:
            Image(image: AssetImage('assets/limg.png'),
            ),


            //Padding(padding: EdgeInsets.all(20.0),child: Text('Dr. Biswaroop'),)
          ),
      new Pagelinks(),


      ],),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed:null,
        tooltip: 'Increment',
        child: Icon(Icons.message),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}





