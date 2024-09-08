import 'dart:developer';

import 'package:demo/api/api_service_path.dart';
import 'package:demo/utils/app_strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiService {
  Future getPosts() async {
    try {
      final response = await Dio().get(ApiServicePath.post);
      print("Response data => ${response}");
      return response.data;
    } on DioException catch (error) {
      showError(error.response!.statusCode);
    }
  }
  Future getIndividualPost(String id) async {
    try {
      final response = await Dio().get("${ApiServicePath.post}/$id");
      log("Response data => $response");
      return response.data  ;
    } on DioException catch (error) {
      showError(error.response!.statusCode);
    }
  }

  showError(int? statusCode) {
    switch (statusCode) {
      case 400:
        showSnackBar(AppStrings.syntaxError);
      case 500:
        showSnackBar(AppStrings.serverError);
      case 401:
        showSnackBar(AppStrings.syntaxError);
      default:
        showSnackBar(AppStrings.somethingWentWrong);
    }
  }

  showSnackBar(String message) {
    Get.showSnackbar(GetSnackBar(title: message,));
  }
}
