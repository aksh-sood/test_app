import 'package:flutter/material.dart';


class ProductTile extends StatelessWidget {
  final imageUrl, category;
  var back;
   ProductTile({@required this.imageUrl, @required this.category,@required this.back});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //TODO:clear this
        //   MaterialPageRoute(
        //       builder: (context) => CategoryNewz(
        //             category: category.toString().toLowerCase(),
        //           )),
        // );
      },
      child: Container(
        margin:const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 14),
                Container(
                  height:80,
                  width:120,
                  decoration:  BoxDecoration(
                    color: back,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                Center(
                   child:( category==null)?null: Text(
                     category,
                     style: const TextStyle(
                       fontWeight: FontWeight.w500,
                       fontSize: 21,
                       color: Colors.black,
                     ),
                   ),
                 )
              ],
            ),
           
          ],
        ),
      ),
    );
  }
}