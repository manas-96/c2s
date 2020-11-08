import 'package:flutter/material.dart';

class UploadWorkerDetails extends StatefulWidget {
  @override
  _UploadWorkerDetailsState createState() => _UploadWorkerDetailsState();
}

class _UploadWorkerDetailsState extends State<UploadWorkerDetails> {
  String firstName="";
  String lastName="";
  String displayName="";
  String email="";
  String primaryNumber="";
  String shareableNumber="";
  String about="";
  String address="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Details"),
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(fontWeight: FontWeight.bold)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
