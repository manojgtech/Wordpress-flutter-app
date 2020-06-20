import 'package:flutter/material.dart';
import 'Post.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share/share.dart';
class Readmore extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Post data;

  // In the constructor, require a Todo.
  Readmore(this.data);

  @override
  Widget build(BuildContext context) {

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Html(data:'${data.title}'),
        actions: [
          GestureDetector(child: Icon(Icons.share),onTap: (){
            final RenderBox box = context.findRenderObject();
            Share.share('${data.url}',
                subject:'${data.title}' ,
                sharePositionOrigin:
                box.localToGlobal(Offset.zero) &
                box.size);
          },)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(child: Html(data: "<div style='font-size:20px;'>"+'${data.content}'+"</div>" ,),)
      ),
    );
  }
}
