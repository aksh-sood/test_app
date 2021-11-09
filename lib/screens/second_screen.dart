import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:app_ninja_task/widgets/list.dart';
import 'package:app_ninja_task/widgets/product_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  String getRandString() {
    var random = Random.secure();
    var values = List<int>.generate(10, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  Future<dynamic> uploadImage() async {
    final _storage = FirebaseStorage.instance;
    // await  Permission.photos.request();
    //  var perStatus=await Permission.photos.status;
    final _picker = ImagePicker();
    PickedFile image;
    var token = getRandString();
    print(token);
// ignore: deprecated_member_use
    image = (await _picker.getImage(source: ImageSource.gallery))!;
    var file = File(image.path);
    if (image != null) {
      var snapshot = await _storage
          .ref()
          .child(
              "$token/${image.path.split(".").length - 1}/${image.path.split(".").last}")
          .putFile(file);
      var downloadedUrl = snapshot.ref.getDownloadURL();

      setState(() {
        var imageUrl = downloadedUrl;
      });
        Fluttertoast.showToast(
                          msg: "Pic has been uploaded succesfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Color(0xFF1D1D35),
                          textColor: Colors.white,
                          fontSize: 16.0);
    } else {
        Fluttertoast.showToast(
                          msg: "Please select a pic to upload",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Color(0xFF1D1D35),
                          textColor: Colors.white,
                          fontSize: 16.0);
      print("no path recived");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Container(color: Colors.green),
            Positioned(bottom:0,
    child:  Image(
      
        image: AssetImage(
            "images/shape-1.png")),
  ),
            ListView(
              children: [
                Container(
                  padding:EdgeInsets.only(left:5),
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 12),
                      Container(
                        height: 130,
                        color: Colors.white,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: product_list.length,
                          itemBuilder: (context, index) {
                            return ProductTile(
                                imageUrl: null,
                                category: product_list[index],
                                back: Colors.grey);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
           
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: const Image(
                    
                      image: AssetImage(
                          "images/new_index_background@2x-8136dccc9cb819b1b57244c06d6aa26ecfa513f5f889cf849e4096d69b4a953f.png")),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Text(
                          "Choose your design",
                          style:
                              TextStyle(color: Color(0xFF1E7AF2), fontSize: 18),
                        ),
                        Container(
                          height: 100,
                          color: Color(0xFF64b5f6).withOpacity(0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: product_list.length,
                            itemBuilder: (context, index) {
                              return ProductTile(
                                imageUrl: null,
                                category: null,
                                back: Colors.white,
                              );
                            },
                          ),
                        ),
                      ]),
                    ),
                    height: MediaQuery.of(context).size.height / 5 - 20,
                    decoration: BoxDecoration(
                      color: Color(0xFFEDF4FB),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Text(
                            "Choose your size",
                            style: TextStyle(
                                color: Color(0xFF1E7AF2), fontSize: 16),
                          ),
                        ]),
                      ),
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 2 - 16,
                      decoration: BoxDecoration(
                        color: Color(0xFFEDF4FB),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Text(
                            "Choose your size",
                            style: TextStyle(
                                color: Color(0xFF1E7AF2), fontSize: 16),
                          ),
                        ]),
                      ),
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 2 - 16,
                      decoration: BoxDecoration(
                        color: Color(0xFFEDF4FB),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 12),
                Positioned(bottom:0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90),
                    child: ElevatedButton(
                      //  color: Colors.blue,
                      style: ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    )
  )
),
                        onPressed: () => uploadImage(),
                        child:const Padding(
                          padding: EdgeInsets.symmetric(vertical:15),
                          child:  Text("Upload Image! 😍",style: TextStyle(color:Colors.white,fontSize:20)),
                        ),),
                  ),
                ),
              ],
            ),
  
          ],
        ));
  }
}
