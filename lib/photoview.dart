import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class Photoviewpage extends StatefulWidget {
  String url;
   Photoviewpage(this.url);

  @override
  State<Photoviewpage> createState() => _PhotoviewpageState();
}

class _PhotoviewpageState extends State<Photoviewpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
          imageProvider: NetworkImage(widget.url
      )),
      floatingActionButton: InkWell(
        onTap: () async {
          try {
            final http.Response r = await http.get(
              Uri.parse(widget.url),
            );
            final data = r.bodyBytes;
            final base64data = base64Encode(data);
            final a = html.AnchorElement(href: 'data:image/jpeg;base64,$base64data');
            a.download = 'image.jpg';
            a.click();
            a.remove();
          } catch (e) {
            print(e);
          }
        },
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(18),
          child: Container(
          width: 150,
            height: 50,

            decoration: BoxDecoration(
                color: Color(0xff00A0E3),
              borderRadius: BorderRadius.circular(18)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.download,color: Colors.white,),
                Text("Download",style:GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),)
              ],
          ),
          ),
        ),
      ),
    );
  }
}
