
import 'dart:convert';

import 'package:recruit_app/pages/storage_manager.dart';

import 'constant.dart';

class ShareHelper{
 static String is_fist = "is_first";
 static String search_history_job = "search_history_job";
 static String search_history_company = "search_history_company";
 static String city = "city";
 static String is_Login = "is_Login";
 static String kUser = "kUser";

 static bool isLogin(){
   if(StorageManager.sharedPreferences != null &&StorageManager.sharedPreferences.getBool(is_Login) !=null &&StorageManager.sharedPreferences.getBool(is_Login) ){
     return true;
   }else{
     return false;
   }
 }
 static bool isFistLogin(){
   if(StorageManager.sharedPreferences != null && StorageManager.sharedPreferences.getBool(is_fist) !=null &&StorageManager.sharedPreferences.getBool(is_fist)){
     return true;
   }else{
     return false;
   }
 }
 static String getCity(){
   String mcity;
   if(StorageManager.sharedPreferences != null && StorageManager.sharedPreferences.getString(city) !=null&&StorageManager.sharedPreferences.getString(city) !=""){

     mcity = StorageManager.sharedPreferences.getString(city);
   }else {
     mcity = "北京";
   }
   return mcity;
 }
 static  putCity(String mcity){
   StorageManager.sharedPreferences.setString(city, mcity);
 }
 static List<dynamic> getSearchJob(){
   List <dynamic> searchLists ;
   if(StorageManager.sharedPreferences != null && StorageManager.sharedPreferences.getString(search_history_job) !=null&&StorageManager.sharedPreferences.getString(search_history_job) !=""){

     searchLists = json.decode(StorageManager.sharedPreferences.getString(search_history_job));
   }
     return searchLists;

 }
 static void putSearchJob(String job){
   List <dynamic> searchLists;
   if(StorageManager.sharedPreferences != null && StorageManager.sharedPreferences.getString(search_history_job) !=null&&StorageManager.sharedPreferences.getString(search_history_job) !=""){
     searchLists = json.decode(StorageManager.sharedPreferences.getString(search_history_job));
     searchLists.insert(0,job);
   }else{
     searchLists= new List();
     searchLists.add(job);
   }

   StorageManager.sharedPreferences.setString(search_history_job, json.encode(searchLists));


 }
// static User getUser(){
//   var userMap = StorageManager.localStorage.getItem(UserModel.kUser);
//   User _user = userMap != null ? User.fromJson(userMap) : null;
//   return _user;
//}
}