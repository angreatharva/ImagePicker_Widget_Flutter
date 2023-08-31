import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? file;
  ImagePicker _picker=ImagePicker();
  List<XFile>?files;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("ImagePicker")),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.grey.shade200,
                child: Center(child:file==null? Text("Image Not Picked")
                :Image.file(File(file!.path),fit: BoxFit.cover,)),
              ),
              ElevatedButton(onPressed: ()async{
                final XFile? photo=await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  file=photo;
                });
                print("Image Picked");
                print(photo!.path);
              }, child: Text("Pick Image")),

              ElevatedButton(onPressed: ()async{
                final List<XFile>? photos = await _picker.pickMultiImage();
                setState(() {
                  files=photos;
                });
                print("Images Picked");
                for(int i=0 ; i<files!.length;i++){
                  print(files![i].path);
                }
              }, child: Text("Pick Images"))
            ],
          ),
        ),
      ),
    );
  }
}
