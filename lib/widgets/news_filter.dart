

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/data.dart';
import 'package:news_app/widgets/news_dropdown.dart';


class NewsFilter extends StatelessWidget {
  NewsController newsController;
  NewsFilter({Key? key, required this.newsController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          GetBuilder<NewsController>(
            builder: (controller) {
              return Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    )),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.cName.isNotEmpty
                        ? Text(
                      "Country: ${controller.cName.value.toUpperCase()}",
                      style: GoogleFonts.poppins(fontSize: 30),
                    )
                        : const SizedBox.shrink(),
                    controller.category.isNotEmpty
                        ? Text(
                      "Category: ${controller.category.value.capitalizeFirst}",
                      style: GoogleFonts.poppins(fontSize: 30),

                    )
                        : const SizedBox.shrink(),
                    controller.channel.isNotEmpty
                        ? Text(
                      "Category: ${controller.channel.value.capitalizeFirst}",
                      style: GoogleFonts.poppins(fontSize: 30),

                    )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
            init: NewsController(),
          ),

          ExpansionTile(
            collapsedTextColor: Colors.black,
            collapsedIconColor:  Colors.black,
            iconColor:  Colors.black,
            textColor:  Colors.black,
            title: const Text("Select Country"),
            children: <Widget>[
              for (int i = 0; i < listOfCountry.length; i++)
                dropDown(
                  onTapped: () {
                    newsController.country.value = listOfCountry[i]['code']!;
                    newsController.cName.value =
                        listOfCountry[i]['name']!.toUpperCase();
                    newsController.getAllArticles();
                    newsController.getCarouselArticles();
                  },
                  name: listOfCountry[i]['name']!.toUpperCase(),
                ),
            ],
          ),

          /// For Selecting the Category
          ExpansionTile(
            collapsedTextColor: Colors.black,
            collapsedIconColor:  Colors.black,
            iconColor:  Colors.black,
            textColor:  Colors.black,
            title: const Text("Select Category"),
            children: [
              for (int i = 0; i < listOfCategory.length; i++)
                dropDown(
                    onTapped: () {
                      newsController.category.value = listOfCategory[i]['code']!;
                      newsController.getAllArticles();
                    },
                    name: listOfCategory[i]['name']!.toUpperCase())
            ],
          ),

          /// For Selecting the Channel
          ExpansionTile(
            collapsedTextColor: Colors.black,
            collapsedIconColor:  Colors.black,
            iconColor:  Colors.black,
            textColor:  Colors.black,
            title: const Text("Select Channel"),
            children: [
              for (int i = 0; i < listOfNewsChannel.length; i++)
                dropDown(
                  onTapped: () {
                    newsController.channel.value = listOfNewsChannel[i]['code']!;
                    newsController.getAllArticles(
                        channel: listOfNewsChannel[i]['code']);
                    newsController.cName.value = '';
                    newsController.category.value = '';
                    newsController.update();
                  },
                  name: listOfNewsChannel[i]['name']!.toUpperCase(),
                ),
            ],
          ),
          const Divider(),
          ListTile(
              trailing: const Icon(
                Icons.done_sharp,
                size: 15,
                color: Colors.black,
              ),
              title: Text(
                "Done",
                style: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
              ),
              onTap: () => Get.back()),
        ],
      ),
    );
  }
}

