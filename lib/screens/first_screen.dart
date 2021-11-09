import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:app_ninja_task/widgets/list.dart';
import 'package:app_ninja_task/widgets/product_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
    } else {
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

            ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 5),
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
                          "images/grosbookdiy-page.45c30de9815682aebdc37e1dc9f89d49.png")),
                ),
                SizedBox(height: 12),
                Container(
                    child: Column(children: [
                  Text("Product Name", style: TextStyle(color: Colors.blue))
                ]))
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 30,
              child: Column(
                children: [
                  Image(image: AssetImage("images/shape-1.png")),
                  Column(children: [
                    Text("Product Name", style: TextStyle(color: Colors.blue))
                  ]),
                 
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2 - 80,
                  color: Color(0xFFEDF4FB),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Product Name",
                          style: TextStyle(color: Colors.blue, fontSize: 30)),
                        SizedBox(height: 12),
                               Text("Some fancy words to sell the product",
                          style: TextStyle(color: Colors.blue, fontSize: 15)),  
                           SizedBox(height: 12),
                               Text(" info about the product",
                          style: TextStyle(color: Colors.blue, fontSize: 15)), 
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(children: [
                                Icon(Icons.wallet_membership,size: 50,color: Colors.blue),
                                 Text("from",
                          style: TextStyle(color: Colors.blue, fontSize: 13)),  
                           Text("₹129",
                          style: TextStyle(color: Colors.blue, fontSize: 18)),  


                              ],),
                              
                               Container(width: 1,height: 90,color:Colors.blue),
                                Column(children: [
                                    Image(
      
        image: AssetImage(
            "images/selfie.png")),
                                 Text("from",
                          style: TextStyle(color: Colors.blue, fontSize: 13)),  
                           Text("25 photos",
                          style: TextStyle(color: Colors.blue, fontSize: 18)),  


                              ],),
                          ],) ,
                          SizedBox(height: 20),
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: ElevatedButton(
                      //  color: Colors.blue,
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ))),
                      onPressed: () =>
                          Navigator.pushNamed(context, "/SecondScreen"),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text("Want? 🤑",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ),
                  ), ],
                    
                  ),
                ))
          ],
        ));
  }
}
