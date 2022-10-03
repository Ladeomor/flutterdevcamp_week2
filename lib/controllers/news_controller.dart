import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/news_model.dart';


import 'package:news_app/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';

class NewsController extends GetxController{
    List<Articles>? allArticles = <Articles>[];
    List<Articles>? carouselArticles = <Articles>[];
    ScrollController scrollController = ScrollController();
    RxBool articleNotFound = false.obs;
    RxBool isLoading = false.obs;
    RxString cName = ''.obs;
    RxString country = ''.obs;
    RxString category = ''.obs;
    RxString channel = ''.obs;
    RxString searchNews = ''.obs;
    RxInt pageNum = 1.obs;
    RxInt pageSize = 10.obs;
    String baseUrl = "https://newsapi.org/v2/top-headlines?";

    @override

    void onInit(){
      scrollController = ScrollController()..addListener(scrollListener);
      getAllArticles();
      getCarouselArticles();
      super.onInit();
    }

    scrollListener() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoading.value = true;
        getAllArticles();
      }
    }

    getAllArticlesFromApi(url) async {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        News news = News.fromJson(jsonDecode(response.body));
        if (news.articles!.isEmpty && news.totalResults == 0) {
          articleNotFound.value = isLoading.value == true ? false : true;
          isLoading.value = false;
          update();
        } else {
          if (isLoading.value == true) {
            allArticles = [...?allArticles, ...?news.articles];
            update();
          } else {
            if (news.articles!.isNotEmpty) {
              allArticles = news.articles;

              if (scrollController.hasClients) scrollController.jumpTo(0.0);

              update();
            }
          }
          articleNotFound.value = false;
          isLoading.value = false;
          update();
        }
      } else {
        articleNotFound.value = true;
        update();
      }
    }


    getAllArticles({channel = '', searchKey = '', reload = false}){
      articleNotFound.value = false;

      if(!reload && isLoading.value == false){

      }else{
        country.value = '';
        category.value = '';
      }
      if(isLoading.value == true){
        pageNum++;
      }else{
        allArticles = [];

        pageNum.value = 2;
      }

      baseUrl = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&";
      baseUrl += country.isEmpty ? 'country=us&' : 'country=$country&';

      baseUrl += category.isEmpty ? 'category=technology&' : 'category=$category&';
      baseUrl += 'apiKey=${Api.api}';

      if(channel != ''){
        country.value = '';
        category.value = '';
        baseUrl =
        "https://newsapi.org/v2/top-headlines?sources=$channel&apiKey=${Api.api}";
      }

      if (searchKey != '') {
        country.value = '';
        category.value = '';
        baseUrl =
        "https://newsapi.org/v2/everything?q=$searchKey&from=2022-07-01&sortBy=popularity&pageSize=10&apiKey=${Api.api}";
      }
      print(baseUrl);

      getAllArticlesFromApi(baseUrl);






    }
    getCarouselArticlesFromApi(url) async {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        News news = News.fromJson(jsonDecode(response.body));
        if (news.articles!.isEmpty && news.totalResults == 0) {
          articleNotFound.value = isLoading.value == true ? false : true;
          isLoading.value = false;
          update();
        } else {
          if (isLoading.value == true) {
            allArticles = [...?carouselArticles, ...?news.articles];
            update();
          } else {
            if (news.articles!.isNotEmpty) {
              carouselArticles = news.articles;

              if (scrollController.hasClients) scrollController.jumpTo(0.0);

              update();
            }
          }
          articleNotFound.value = false;
          isLoading.value = false;
          update();
        }
      } else {
        articleNotFound.value = true;
        update();
      }
    }



      getCarouselArticles({reload = false}) async {
        articleNotFound.value = false;

        if (!reload && isLoading.value == false) {

        } else {
          country.value = '';
        }
        if (isLoading.value == true) {
          pageNum++;
        } else {
          carouselArticles = [];

          pageNum.value = 2;
        }

        baseUrl =
        "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&languages=en&";

        baseUrl += country.isEmpty ? 'country=ng&' : 'country=$country&';
        baseUrl += 'apiKey=${Api.api}';
        print([baseUrl]);

        getCarouselArticlesFromApi(baseUrl);
      }
    }