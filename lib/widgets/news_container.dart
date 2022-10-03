import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsContainer extends StatelessWidget {
  final String? title;
  final String description;
  final String content;
  final String? postUrl;
  final String imageUrl;
  const NewsContainer({Key? key, required this.title, required this.description, required this.content, required this.imageUrl, required this.postUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration:  BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.12),
              offset: Offset(6, 4),
              blurRadius: 10,
              spreadRadius: 0,
            )
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 100,
        width: 70,
        child: Row(
          children: [
            ClipRRect(

              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10)
              ),
                child: Image.network(imageUrl, fit: BoxFit.cover, width: 150,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                  return Container(
                    height: 150,
                      width: 100,
                      decoration:  BoxDecoration(
                      boxShadow: const [
                      BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.12),
                    offset: Offset(6, 4),
                    blurRadius: 10,
                    spreadRadius: 0,
                    )
                    ],
                    borderRadius: BorderRadius.circular(10.0),

                  ),
                    child: Icon(Icons.broken_image_outlined),
                  );}
                )),
            SizedBox(width: 10,),
            Container(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(title!, overflow: TextOverflow.ellipsis, softWrap: false, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold),),
                  Text(description, overflow: TextOverflow.fade, softWrap: false, maxLines: 2, style: GoogleFonts.poppins(fontSize: 12, ),)


                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
