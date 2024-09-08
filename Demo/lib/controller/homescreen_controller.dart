import 'dart:async';

import 'package:demo/api/api_service.dart';
import 'package:demo/models/posts.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class HomeScreenController extends GetxController {
  RxList posts = <Posts>[].obs;
  var postDetails = Posts().obs;
  RxBool loading = true.obs;
  RxBool detailLoading = true.obs;

  /// Get post from api ///

  Future getPosts() async {
    final data = await ApiService().getPosts();
    posts.value = data.map<Posts>((post) => Posts.fromJson(post)).toList();
  }

  Future getIndividualPost(id) async {
    final data = await ApiService().getIndividualPost(id);
    postDetails.value = Posts.fromJson(data);
  }

  startTimer(int index) {
    posts[index].timer1 = new Timer.periodic(Duration(seconds: 1), (str) {
      posts[index].timer.value=str.tick;
      print("posts[index].timer ${posts[index].timer}");
    });
  }
  pauseTimer(int index){
    if(posts[index].timer1!=null){
  posts[index].timer1.cancel();
  }
  }
  resumeTimer(int index){
    posts[index].timer1 = new Timer.periodic(Duration(seconds: 1), (str) {
      posts[index].timer.value+=str.tick;
      print("posts[index].timer ${posts[index].timer}");
    });
  }
}
