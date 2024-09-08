import 'package:demo/controller/homescreen_controller.dart';
import 'package:demo/utils/app_colors.dart';
import 'package:demo/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeDetailsScreen extends StatefulWidget {
  String id;

  HomeDetailsScreen({required this.id, super.key});

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    homeScreenController.detailLoading.value = true;
    await homeScreenController.getIndividualPost(widget.id);
    homeScreenController.detailLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightYellow,
        title: Text(AppStrings.detailsScreen),
      ),
      body: Obx(() => homeScreenController.detailLoading.value
          ? Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                color: AppColors.black,
                size: 60,
              ),
            )
          : Column(
              children: [
                ResponsiveUI("Id",homeScreenController.postDetails.value.id.toString()??""),
                ResponsiveUI("UserId",homeScreenController.postDetails.value.userId.toString()??""),

                ResponsiveUI("Title",homeScreenController.postDetails.value.title??""),
                ResponsiveUI("Body",homeScreenController.postDetails.value.body??""),
               ],
            )),
    );
  }

}
ResponsiveUI(String title,String value){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.black.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        child: Row(
          children: [
            Text(title,style: TextStyle(fontWeight: FontWeight.w500),),
            SizedBox(width: 8,),
            Container(
                width: 260,
                child: Text(value,style: TextStyle(fontWeight: FontWeight.w300),))
          ],
        ),
      ),
    ),
  );
}