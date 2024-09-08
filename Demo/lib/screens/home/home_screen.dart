import 'dart:math';
import 'package:demo/controller/homescreen_controller.dart';
import 'package:demo/screens/home_details_screen.dart';
import 'package:demo/utils/app_colors.dart';
import 'package:demo/utils/app_strings.dart';
import 'package:demo/utils/shared_preferences/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Homescreen extends StatefulWidget {
   Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  HomeScreenController homeScreenController =Get.put(HomeScreenController());
  @override
  void initState() {
    getData();
    super.initState();
  }
  getData()async{
    homeScreenController.loading.value=true;

    await homeScreenController.getPosts();
    homeScreenController.loading.value=false;

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightYellow,
        title: const Text(AppStrings.demo),
      ),
      body:
          Obx(()=>homeScreenController.loading.value?Center(
            child: LoadingAnimationWidget.threeRotatingDots(
              color: AppColors.black,
              size: 60,
            ),
          )
       :RefreshIndicator(
            onRefresh: ()async{
              await getData();
            },
         child: ListView.builder(
           shrinkWrap: true,
             itemCount: homeScreenController.posts.length,
             itemBuilder: (context,index){
               return
                 FutureBuilder(future: SharedPreference.checkIdAvailable(homeScreenController.posts[index].id.toString()),
                     builder: (context, snapshot) {
                       Random random = new Random();
                       int randomNumber = random.nextInt(100);
                       return VisibilityDetector(
                         onVisibilityChanged: (visibilityInfo){
                           // var visiblePercentage = visibilityInfo.visibleFraction * 100;
                           // print("visiblePercentage $index $visiblePercentage");
                           // if(visiblePercentage>2){
                           //   homeScreenController.startTimer(index);
                           // }else{
                           //   homeScreenController.pauseTimer(index);
                           // }
                         },
                         key: Key('my-widget-key'),
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                           child: Container(
                             decoration: BoxDecoration(
                               border: Border.all(color: AppColors.black.withOpacity(0.5)),
                                   borderRadius: BorderRadius.circular(8)
                             ),
                             child: ListTile(
                               dense: true,

                               onTap: (){
                                 SharedPreference.storeData(homeScreenController.posts[index].id.toString());
                                 homeScreenController.startTimer(index);
                                 setState(() {

                                 });
                                 Get.to(()=>  HomeDetailsScreen(id: homeScreenController.posts[index].id.toString(),));
                               },
                               tileColor:snapshot.data==true?AppColors.white: AppColors.lightYellow,
                               title: Text(

                                 homeScreenController.posts[index].title,style: const TextStyle(fontWeight: FontWeight.w500),),
                               subtitle: Text(homeScreenController.posts[index].body,style: const TextStyle(fontWeight: FontWeight.w300),),
                               trailing: Column(
                                 children: [
                                   const Icon(Icons.timer),
                                   Text(randomNumber.toString()),
                                 ],
                               ),
                             ),
                           ),
                         ),
                       );

                     },);
             }),
       )),
    );
  }
}
