import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/screens/news_screen.dart';

class NewsCarousel extends StatelessWidget {
  const NewsCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      init: NewsController(),
      builder: ((controller) {
        return CarouselSlider(items: controller.carouselArticles!.map((e) {
          return controller.articleNotFound.value
              ? Center(
            child: Text("News not found", style: GoogleFonts.poppins(fontSize: 30),),
          ): controller.carouselArticles!.isEmpty
              ? const Center(child: CircularProgressIndicator(color: Colors.black,),)
              : Builder(builder: (BuildContext context){
                try{
                  return Banner(
                    location: BannerLocation.topStart,
                    color: Colors.orange,
                    message: 'Top Articles',
                    child: InkWell(
                      onTap: (){
                        Get.to(() =>
                            NewsDetails(newsUrl: e.url)
                        );
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              e.urlToImage ?? "",
                              fit: BoxFit.fill,
                              height: double.infinity,
                              width: double.infinity,
                              errorBuilder: (BuildContext context,
                                  Object exception,
                                  StackTrace? stackTrace){
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          10)),
                                  child: const SizedBox(
                                    height: 200,
                                    width: double.infinity,
                                    child: Icon(Icons
                                        .broken_image_outlined),
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black12.withOpacity(0),
                                  Colors.black
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                              child: Text(e.title.toString(), style: GoogleFonts.poppins(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ))

                        ],),
                    ),
                  );
                }catch(e){
                  print(e);
                  return Container();

                }
          });
        }).toList(),
            options: CarouselOptions(
                height: 200, autoPlay: true, enlargeCenterPage: true),
        );
      }),
    );
  }
}
