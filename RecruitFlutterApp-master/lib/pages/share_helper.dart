
import 'dart:convert';

import 'package:recruit_app/pages/account/register/User.dart';
import 'package:recruit_app/pages/storage_manager.dart';

import 'constant.dart';

class ShareHelper{
 static String is_fist = "is_first";
 static String search_history_job = "search_history_job";
 static String normal_world = "normal_world";
 static String search_history_company = "search_history_company";
 static String search_history_jl = "search_history_jl";
 static String city = "city";
 static String is_Login = "is_Login";
 static String is_BossLogin = "is_BOSSLogin";
 static String kUser = "kUser";
 static String BOSSUser = "BosskUser";

 static void saveBanner(List data,String key){

   StorageManager.sharedPreferences.setString(key, json.encode(data));


 }
 static bool isAgree(){
   if(StorageManager.sharedPreferences != null &&StorageManager.sharedPreferences.getBool("is_agree") !=null &&StorageManager.sharedPreferences.getBool("is_agree")){
     return true;
   }else{
     return false;
   }
 }
 static bool isLogin(){
   if(StorageManager.sharedPreferences != null &&StorageManager.sharedPreferences.getBool(is_Login) !=null &&StorageManager.sharedPreferences.getBool(is_Login) ){
     return true;
   }else{
     return false;
   }
 }
 static bool isBossLogin(){
   if(StorageManager.sharedPreferences != null &&StorageManager.sharedPreferences.getBool(is_BossLogin) !=null &&StorageManager.sharedPreferences.getBool(is_BossLogin) ){
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
 static List<dynamic> getNormal(){
   List <dynamic> searchLists ;
   if(StorageManager.sharedPreferences != null && StorageManager.sharedPreferences.getString(normal_world) !=null&&StorageManager.sharedPreferences.getString(normal_world) !=""){

     searchLists = json.decode(StorageManager.sharedPreferences.getString(normal_world));
   }
   return searchLists;

 }
 static void putNormal(String job){
   List <dynamic> searchLists;
   if(StorageManager.sharedPreferences != null && StorageManager.sharedPreferences.getString(normal_world) !=null&&StorageManager.sharedPreferences.getString(normal_world) !=""){
     searchLists = json.decode(StorageManager.sharedPreferences.getString(normal_world));
     searchLists.insert(0,job);
   }else{
     searchLists= new List();
     searchLists.add(job);
   }

   StorageManager.sharedPreferences.setString(normal_world, json.encode(searchLists));


 }
 static List<dynamic> getSearchCompany(){
   List <dynamic> searchLists ;
   if(StorageManager.sharedPreferences != null && StorageManager.sharedPreferences.getString(search_history_company) !=null&&StorageManager.sharedPreferences.getString(search_history_company) !=""){

     searchLists = json.decode(StorageManager.sharedPreferences.getString(search_history_company));
   }
   return searchLists;

 }
 static void putSearchCompany(String job){
   List <dynamic> searchLists;
   if(StorageManager.sharedPreferences != null && StorageManager.sharedPreferences.getString(search_history_company) !=null&&StorageManager.sharedPreferences.getString(search_history_company) !=""){
     searchLists = json.decode(StorageManager.sharedPreferences.getString(search_history_company));
     searchLists.insert(0,job);
   }else{
     searchLists= new List();
     searchLists.add(job);
   }

   StorageManager.sharedPreferences.setString(search_history_company, json.encode(searchLists));


 }
 static List<dynamic> getSearchJl(){
   List <dynamic> searchLists ;
   if(StorageManager.sharedPreferences != null && StorageManager.sharedPreferences.getString(search_history_jl) !=null&&StorageManager.sharedPreferences.getString(search_history_jl) !=""){

     searchLists = json.decode(StorageManager.sharedPreferences.getString(search_history_jl));
   }
   return searchLists;

 }
 static void putSearchJl(String job){
   List <dynamic> searchLists;
   if(StorageManager.sharedPreferences != null && StorageManager.sharedPreferences.getString(search_history_jl) !=null&&StorageManager.sharedPreferences.getString(search_history_jl) !=""){
     searchLists = json.decode(StorageManager.sharedPreferences.getString(search_history_jl));
     searchLists.insert(0,job);
   }else{
     searchLists= new List();
     searchLists.add(job);
   }

   StorageManager.sharedPreferences.setString(search_history_jl, json.encode(searchLists));


 }
 static User getUser(){
   var userMap = StorageManager.localStorage.getItem(kUser);
   User _user = userMap != null ? User.fromJson(userMap) : null;
   return _user;
}
 static User getBosss(){
   var userMap = StorageManager.localStorage.getItem(BOSSUser);
   User _user = userMap != null ? User.fromJson(userMap) : null;
   return _user;
 }

 static bool isHaveData(String id,String type){
   String key = getUser().userId+type;
   if(StorageManager.sharedPreferences != null && StorageManager.sharedPreferences.getString(key) !=null&&StorageManager.sharedPreferences.getString(key) !=""){
     List <dynamic> searchLists= json.decode(StorageManager.sharedPreferences.getString(key));
     for(var ite in searchLists ){
       if(ite["id"] == id){
         return true;
       }
     }

     return false;
   }else{
     return false;
   }
 }
 static void saveData(Map job,String type){
   String key = getUser().userId+type;
   List <dynamic> searchLists;
   if(StorageManager.sharedPreferences != null && StorageManager.sharedPreferences.getString(key) !=null&&StorageManager.sharedPreferences.getString(key) !=""){
     searchLists = json.decode(StorageManager.sharedPreferences.getString(key));
     searchLists.insert(0,job);
   }else{
     searchLists= new List();
     searchLists.add(job);
   }

   StorageManager.sharedPreferences.setString(key, json.encode(searchLists));


 }
 static void deletData(String id,String type){
   String key = getUser().userId+type;
   if(StorageManager.sharedPreferences != null && StorageManager.sharedPreferences.getString(key) !=null&&StorageManager.sharedPreferences.getString(key) !=""){
     List <dynamic> searchLists= json.decode(StorageManager.sharedPreferences.getString(key));
     for(var ite in searchLists ){
       if(ite["id"] == id){
         searchLists.remove(ite);
         StorageManager.sharedPreferences.setString(key, json.encode(searchLists));

         break;
       }
     }
   }
 }
}