import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/controllers/news_controller.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({Key? key}) : super(key: key);
  NewsController newsController = Get.put(NewsController());
  TextEditingController searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),

      height: 50,
      decoration: BoxDecoration(
        // border: Border.all(width: 1, color: Colors.black54),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child:  TextField(
        onChanged: (val){
          newsController.searchNews.value = val;
          newsController.update();
        },
        onSubmitted: (value) async {
          newsController.searchNews.value = value;
          newsController.getAllArticles(
              searchKey: newsController.searchNews.value);
          searchController.clear();
        },
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1,color: Colors.white)
          ),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1,color: Colors.white )
          ),

          fillColor: Color(0XFFFFFEFE),
          filled: true,
          hintText: 'Search by categories, country...',
          hintStyle:GoogleFonts.poppins( color: Color(0XFFd3d3d3).withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.w500),
          prefixIcon: InkWell(
            onTap: ()async{
              newsController.getAllArticles(
                searchKey: newsController.searchNews.value
              );
              searchController.clear();
            },
              child: const Icon(Icons.search, color: Colors.black54,)),

        ),

      ),

    );

  }
}
