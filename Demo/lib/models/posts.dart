import 'dart:async';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Posts {
  int? userId;
  int? id;
  String? title;
  String? body;
  RxInt timer=0.obs;
  Timer? timer1;


  Posts({this.userId, this.id, this.title, this.body});

  Posts.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
