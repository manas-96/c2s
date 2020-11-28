//import 'package:call2sex/ForgotPassword.dart';
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
  Loader(){
    return CircularProgressIndicator();
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
    //(response.statusCode);
    if (response.statusCode == 200) {
      final responseData = await json.decode(response.body);
      //(responseData);
      await _storeAuth(responseData["data"][0]);
      return responseData;
    } else {
      throw Exception('Failed to load post');
    }
  }
   fetchVoter() async {
     final header = await _buildHeaderWithAuth();
     SharedPreferences pref= await SharedPreferences.getInstance();
     String id= pref.getString("id");
    final response = await http.get("https://www.call2sex.com/api/KycApi/FetchUserDocs?user_id=$id",headers: header );
    //(response.statusCode);
    if (response.statusCode == 200) {
      final responseData = await json.decode(response.body);
      //print(responseData);
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
      //(responseData);
      await _storeAuth(responseData["data"][0]);
      return responseData;
    } else {
      throw Exception('Failed to load post');
    }
  }
  Future<Map<String, dynamic>> EnquiryOtp(String contact, String otp) async {
    // final authHeader = await _buildHeader();

    final response = await http.get("https://www.call2sex.com/api/EnquiryApi/CheckOTP?contact=$contact&otp=$otp", );
    //(response.statusCode);
    if (response.statusCode == 200) {
      final responseData = await json.decode(response.body);
      //(responseData);
      //await _storeAuth(responseData["data"][0]);
      return responseData;
    } else {
      throw Exception('Failed to load post');
    }
  }
  Future<Map<String, dynamic>> signUP(body) async {
    final response = await http.post("https://www.call2sex.com/api/LoginApi/UserRegister", headers: _buildHeader(), body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  Future<Map<String, dynamic>> saveEnquiry(body) async {
    final response = await http.post("https://www.call2sex.com/api/EnquiryApi/SaveEnquiry",  body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  Future<Map<String, dynamic>> enquiry2(body) async {
    final response = await http.post("https://www.call2sex.com/api/EnquiryApi/SaveEnquiry",  body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  Future<Map<String, dynamic>> resendOTP(String contact, String otp,String name) async {
    final response = await http.get("https://www.call2sex.com/api/LoginApi/ResendOtp?contact=$contact&otp=$otp&name=$name",  );
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  acceptBooking(String bookingId,) async {
    final header=await _buildHeaderWithAuth();
    final response = await http.get("https://www.call2sex.com/api/WorkerApi/BookingAccept?booking_id=$bookingId",headers: header  );
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to accept booking');
    }
  }
  fetchWorkerInfo(String id) async {

    final header=await _buildHeaderWithAuth();
    final response = await http.get("https://www.call2sex.com/api/WorkerApi/FetchInfo?user_id=$id",headers: header  );
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to accept booking');
    }
  }
  modelDetails(String id) async {

    final header=await _buildHeaderWithAuth();
    final response = await http.get("https://www.call2sex.com/api/GuestApi/FetchModelDetails?user_id=$id",headers: header  );
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to accept booking');
    }
  }
  Future<Map<String, dynamic>> forgotPassword(String contact,) async {
    final response = await http.get("https://www.call2sex.com/api/LoginApi/ForgetPassword?contact=$contact",  );
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
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
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
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
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
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
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
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
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }

  workerList() async {
    final header= await _buildHeaderWithAuth();

    final response = await http.get("https://www.call2sex.com/api/GuestApi/FetchModels",headers: header);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  fetchFreeGallery(String id) async {
    final header= await _buildHeaderWithAuth();

    final response = await http.get("https://www.call2sex.com/api/WorkerApi/FetchFreeGallery?user_id=$id",headers: header);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      ////(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  fetchPrimeGallery(String id) async {
    final header= await _buildHeaderWithAuth();

    final response = await http.get("https://www.call2sex.com/api/WorkerApi/FetchPrimeGallery?user_id=$id",headers: header);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      ////(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  fetchBank(String id) async {
    final header= await _buildHeaderWithAuth();

    final response = await http.get("https://www.call2sex.com/api/WorkerApi/FetchBank?user_id=$id",headers: header);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      ////(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }

  saveBankDetails(String bank, String account, String name, String ifsc)async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    //(id);
    final body={
      "bank_name":bank,
      "accholder_name":name,
      "account_no":account,
      "ifce_code":ifsc,
      "user_id":id,
    };
    final response = await http.post("https://www.call2sex.com/api/GuestApi/SaveBank",headers: header,body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  saveLike(String likerId, String islike)async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    //(id);
    final body={
      "liker_id":likerId,
      "islike":islike,
      "user_id":id,
    };
    final response = await http.post("https://www.call2sex.com/api/GuestApi/SaveLike",headers: header,body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  fetchLike(String liker_id) async {
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    final response = await http.get("https://www.call2sex.com/api/GuestApi/FetchLike?user_id=$id&liker_id=$liker_id",headers: header);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      ////(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  changePassword(String pass, String oldPass)async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    //(id);
    final body={
      "password":pass,
      "oldpassword":oldPass,
      "user_id":id,
    };
    final response = await http.post("https://www.call2sex.com/api/WorkerApi/UpdatePassword",headers: header,body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  saveFreeGallery( String img)async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    //(id);
    final body={
      "id":"0",
      "user_id":id,
      "imgurl":img,
    };
    final response = await http.post("https://www.call2sex.com/api/WorkerApi/SaveFreeGallery",headers: header,body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  savePrimeGallery( String img)async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    //(id);
    final body={
      "id":"0",
      "user_id":id,
      "imgurl":img,
    };
    final response = await http.post("https://www.call2sex.com/api/WorkerApi/SavePrimeGallery",headers: header,body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  SaveGuestSelfie( String img)async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    //(id);
    final body={
      "id":"0",
      "user_id":id,
      "imgurl":img,
    };
    final response = await http.post("https://www.call2sex.com/api/GuestApi/SaveGuestSelfie",headers: header,body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      print(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  uploadFront(String kyc, String cat, String front_imgurl, String back_imgurl)async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    //(id);
    final body={
      "user_id":id,
      "kyc_id":kyc,
      "front_imgurl":front_imgurl,
      "cat_id":cat,
      "back_imgurl":back_imgurl
    };
    final response = await http.post("https://www.call2sex.com/api/KycApi/SaveUserKyc",headers: header,body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  uploadBack( String img, String kyc, String cat, String imgurl )async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    //(id);
    final body={
      "kyc_id":kyc,
      "user_id":id,
      "back_imgurl":imgurl,
      "cat_id":cat,
    };
    final response = await http.post("https://www.call2sex.com/api/KycApi/SaveUserKyc",headers: header,body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  fetchGuestSelfie()async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    final response = await http.get("https://www.call2sex.com/api/WorkerApi/FetchInfo?user_id=$id",headers: header,);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  updateRate( String hour, String night, String trip, String shots)async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    String id= pref.getString("id");
    //(id);
    final body={
      "user_id":id,
      "hour":hour,
      "night":night,
      "trip":trip,
      "shots":shots
    };
    final response = await http.post("https://www.call2sex.com/api/WorkerApi/UpdateRateChart",headers: header,body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  fetchRate(String id )async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();


    final response = await http.get("https://www.call2sex.com/api/WorkerApi/FetchRateChart?user_id=$id",headers: header,);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed');
    }
  }
  modelsDetails(String id)async{
    final header= await _buildHeaderWithAuth();
    final response = await http.get("https://www.call2sex.com/api/GuestApi/FetchModelDetails?user_id=$id",headers: header,);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed');
    }
  }
  pendingBooking(String id)async{
    final header= await _buildHeaderWithAuth();
    final response = await http.get("https://www.call2sex.com/api/WorkerApi/FetchPendingBooking?user_id=$id",headers: header,);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      return resData;
    } else {
      throw Exception('Failed');
    }
  }
  pendingBookingGuest(String id)async{
    final header= await _buildHeaderWithAuth();
    final response = await http.get("https://www.call2sex.com/api/GuestApi/FetchGuestPendingBooking?user_id=$id",headers: header,);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      return resData;
    } else {
      throw Exception('Failed');
    }
  }
  fetchWithdraw(String id)async{
    final header= await _buildHeaderWithAuth();
    final response = await http.get("https://www.call2sex.com/api/WalletApi/FetchWithdraw?user_id=$id",headers: header,);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      ////(resData);
      return resData;
    } else {
      throw Exception('Failed');
    }
  }
  fetchPrime(String id)async{
    final header= await _buildHeaderWithAuth();
    final response = await http.get("https://www.call2sex.com/api/GuestApi/FetchSubscription?user_id=$id",headers: header,);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed');
    }
  }
  bookingConfirmation(String id,String url )async{
    final header= await _buildHeaderWithAuth();
    final response = await http.get("$url?user_id=$id",headers: header,);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed');
    }
  }
  bookingCancel(String id )async{
    final header= await _buildHeaderWithAuth();
    final response = await http.get("https://www.call2sex.com/api/WorkerApi/BookingReject?booking_id=$id",headers: header,);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed');
    }
  }
  verifyBooking(String id,String otp )async{
    final header= await _buildHeaderWithAuth();
    final response = await http.get("https://www.call2sex.com/api/WorkerApi/VerifyOTP?booking_id=$id&otp=$otp",headers: header,);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed');
    }
  }
  completeBooking(String id,String url )async{
    final header= await _buildHeaderWithAuth();
    final response = await http.get("$url?user_id=$id",headers: header,);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed');
    }
  }
  bookModel(String workerId, String userId,String serviceName,String amount )async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    final body={
      "guest_id":userId,
      "worker_id":workerId,
      "service_name":serviceName,
      "price":amount
    };

    final response = await http.post("https://www.call2sex.com/api/GuestApi/SaveBooking",headers: header,body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  withdrawalReq(String id,String amount )async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    final body={
      "user_id":id,
      "amount":amount
    };

    final response = await http.post("https://www.call2sex.com/api/WalletApi/SaveWithdraw",headers: header,body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
      return resData;
    } else {
      throw Exception('Failed to SignUp');
    }
  }
  contacts(String list,String count,String mac )async{
    //final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    final body={
      "contacts":list,
      "count":count,
      "mac":mac
    };

     try{
       final response = await http.post("https://www.call2sex.com/api/ContactApi/SaveContacts",body: body);
       //("status code");
       print(response.statusCode);
       if (response.statusCode == 200) {
         final resData =await  json.decode(response.body);
         //(resData);
         return resData;
       }
     }
     catch(e){

     }
  }
  prime(String id,String amount , String duration, String duration_start,String pack_name)async{
    final header= await _buildHeaderWithAuth();
    SharedPreferences pref= await SharedPreferences.getInstance();
    final body={
      "user_id":id,
      "amount":amount,
      "duration_start":duration_start,
      "pack_name":pack_name,
      "duration":duration

    };

    final response = await http.post("https://www.call2sex.com/api/GuestApi/SaveSubscription",headers: header,body: body);
    //(response.statusCode);
    if (response.statusCode == 200) {
      final resData =await  json.decode(response.body);
      //(resData);
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

    final currentAPIToken =  preferences.getString('api_token');
    //(" your token $currentAPIToken");
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
    await prefs.setString("image", data["image"]);

  }
}
