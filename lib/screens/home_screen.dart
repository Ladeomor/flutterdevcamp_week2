
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/screens/news_screen.dart';
import 'package:news_app/widgets/news_carousel.dart';
import 'package:news_app/widgets/news_container.dart';
import 'package:news_app/widgets/news_filter.dart';
import 'package:news_app/widgets/search_textfield.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  NewsController newsController = Get.put(NewsController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Welcome',style: GoogleFonts.poppins(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: (){
              Get.to(() => NewsFilter(newsController: newsController,
                  ));
            },
              child: Icon(Icons.filter_list, color: Colors.black,)),
          actions:  <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.refresh, color: Colors.black,),
                onPressed: () {
                  newsController.country.value = '';
                  newsController.category.value = '';
                  newsController.searchNews.value = '';
                  newsController.channel.value = '';
                  newsController.cName.value = '';
                  newsController.getAllArticles(reload: true);
                  newsController.getCarouselArticles(reload: true);
                  newsController.update();
                },

                ),
            ),

          ]
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchTextField(),
              SizedBox(height: 20,),
              const NewsCarousel(),
              SizedBox(height: 20,),
              Text('Articles for you', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold),),
              GetBuilder<NewsController>(
                  init: NewsController(),
                  builder: (controller) {
                    return controller.articleNotFound.value
                        ? const Center(
                      child: Text('Nothing Found'),
                    )
                        : controller.allArticles!.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                        controller: controller.scrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.allArticles!.length,
                        itemBuilder: (context, index) {
                          index == controller.allArticles!.length - 1 &&
                              controller.isLoading.isTrue
                              ? const Center(
                            child: CircularProgressIndicator(),
                          )
                              : const SizedBox();
                          return InkWell(
                            onTap: () => Get.to(() => NewsDetails(
                                newsUrl: controller.allArticles![index].url)),
                            child: NewsContainer(
                                imageUrl: controller
                                    .allArticles![index].urlToImage ??
                                    '',
                                description: controller
                                    .allArticles![index].description ??
                                    '',
                                title: controller.allArticles![index].title,
                                content:
                                controller.allArticles![index].content ??
                                    '',
                                postUrl: controller.allArticles![index].url),
                          );
                        });
                  }),

            ],
          ),
        ),
      ),
    );
  }
}
