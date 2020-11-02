import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class APIClient{
  static successToast(String msg) {
    return SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.green,
      duration: Duration(seconds:2),
    );
  }

  static errorToast(String msg) {
    return SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.red,
      duration: Duration(seconds:2),
    );
  }
  Future<Map<String, dynamic>> authRequest(String contact, String password) async {
    // final authHeader = await _buildHeader();

    final response = await http.get("https://www.call2sex.com/api/LoginApi/Login?user_contact=$contact&password=$password", );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseData = await json.decode(response.body);
      print(responseData);
      await _storeAuth(responseData["data"][0]);
      return responseData;
    } else {
      throw Exception('Failed to load post');
    }
  }
  Future<Map<String, dynamic>> otpVerification(String contact, String otp) async {
    // final authHeader = await _buildHeader();

    final response = await http.get("https://www.call2sex.com/api/LoginApi/CheckOTP?contact=$contact&otp=$otp", );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseData = await json.decode(response.body);
      print(responseData);
      //await _storeAuth(responseData["data"][0]);
      return responseData;
    } else {
      throw Exception('Failed to load post');
    }
  }
  Future<Map<String, dynamic>> signUP(body) async {
    final response = await http.post("https://www.call2sex.com/api/LoginApi/UserRegister", headers: _buildHeader(), body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      print(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }


  primaryBalance() async {
    final header= await _buildHeaderWithAuth();
    SharedPreferences preferences= await SharedPreferences.getInstance();
    String id= preferences.getString("id");
    final response = await http.get("https://www.call2sex.com/api/WalletApi/FetchWalletBalance_Primary?UserId=$id",headers: header);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      print(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  secondaryBalance() async {
    final header= await _buildHeaderWithAuth();
    SharedPreferences preferences= await SharedPreferences.getInstance();
    String id= preferences.getString("id");
    final response = await http.get("https://www.call2sex.com/api/WalletApi/FetchWalletBalance_Secondary?UserId=$id",headers: header);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      print(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  primaryTrancation() async {
    final header= await _buildHeaderWithAuth();
    SharedPreferences preferences= await SharedPreferences.getInstance();
    String id= preferences.getString("id");
    final response = await http.get("https://www.call2sex.com/api/WalletApi/PrimaryFetchWallet?UserId=$id",headers: header);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      print(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }

  secondaryTrancation() async {
    final header= await _buildHeaderWithAuth();
    SharedPreferences preferences= await SharedPreferences.getInstance();
    String id= preferences.getString("id");
    final response = await http.get("https://www.call2sex.com/api/WalletApi/SecondaryFetchWallet?UserId=$id",headers: header);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      print(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }

  workerList() async {
    final header= await _buildHeaderWithAuth();

    final response = await http.get("https://www.call2sex.com/api/GuestApi/FetchModels",headers: header);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      print(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }

  saveBankDetails(String bank, String account, String name, String ifsc)async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    final body={
      "bank_name":bank,
      "accholder_name":name,
      "account_no":account,
      "ifce_code":ifsc,
      "user_id":id,
    };
    final response = await http.post("https://www.call2sex.com/api/GuestApi/SaveBank",headers: header);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      print(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }

  _buildHeader(){
    return { 'Accept' : 'application/json', 'cache-control' : 'no-cache'};
  }

  _buildHeaderWithAuth() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();

    final currentAPIToken = await preferences.getString('api_token');
    print(" your token $currentAPIToken");
    return { 'Accept' : 'application/json', 'authorization' : 'Bearer '+currentAPIToken, 'cache-control' : 'no-cache'};
  }
  _storeAuth(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('email',data['email']);
    await prefs.setString('uid', data["uid"].toString());


    await prefs.setString('api_token', data["access_token"].toString());

    await prefs.setString('mobile',data['contact']);
    await prefs.setString('firstname', data["firstname"].toString());
    await prefs.setString('lastname', data["lastname"].toString());
    await prefs.setString('id', data["user_id"].toString());
    await prefs.setString("user_type", data["user_type"]);
    await prefs.setString("contact", data["contact"]);

    print("email"+prefs.getString('email'));
    print(prefs.getString('id'));
    print(prefs.getString('api_token'));
  }
}
