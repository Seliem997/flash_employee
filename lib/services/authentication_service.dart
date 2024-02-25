import 'dart:convert';
import 'dart:developer';
import 'package:flash_employee/models/problemSignInProblem.dart';
import 'package:flash_employee/models/profileModel.dart';
import 'package:image_picker/image_picker.dart';

import '../base/service/base_service.dart';
import '../models/invoicesModel.dart';
import '../models/loginModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/cache_helper.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/shared_preference_keys.dart';
import '../utils/enum/statuses.dart';
import 'package:http/http.dart' as http;

import 'firebase_service.dart';

class AuthenticationService extends BaseService {
  Future<ResponseResult> forgotPassword(String email) async {
    Status status = Status.error;
    List<InvoiceData>? invoices;
    Map<String, dynamic> body = {"nameOrEmail": email};
    try {
      await requestFutureData(
          api: Api.forgotPassword,
          body: body,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
            } else if (response["status_code"] == 400) {
              status = Status.emailNotRegistered;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in forgot password $e");
    }
    return ResponseResult(status, "");
  }

  Future<ResponseResult> checkCode(String email, String code) async {
    Status status = Status.error;
    Map<String, dynamic> body = {"email": email, "code": code};
    try {
      await requestFutureData(
          api: Api.checkCode,
          body: body,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
            } else if (response["status_code"] == 400) {
              status = Status.codeNotCorrect;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in checking code $e");
    }
    return ResponseResult(status, "");
  }

  Future<ResponseResult> updatePhoneNumber(String phoneNumber) async {
    Status status = Status.error;

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    Map<String, dynamic> body = {"_method": "PUT", "phone": phoneNumber};
    try {
      await requestFutureData(
          api: Api.updateProfile,
          withToken: true,
          body: body,
          headers: headers,
          jsonBody: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
            } else if (response["status_code"] == 400) {
              status = Status.codeNotCorrect;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in checking code $e");
    }
    return ResponseResult(status, "");
  }

  Future<ResponseResult> updateProfilePicture(XFile image) async {
    Status status = Status.error;
    ProfileModel? userDataResponse;

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer ${CacheHelper.returnData(key: CacheKey.token)}"
    };

    try {
      var request = http.MultipartRequest("POST", Uri.parse(Api.updateProfile));

      request.headers.addAll(headers);

      request.fields['_method'] = "PUT";

      request.files.add(await http.MultipartFile.fromPath("image", image.path));

      logger.i(
          "Request Called: ${Api.updateProfile}\nHeaders: ${request.headers}\nBody:${request.fields}\nFiles:${request.files}");

      await request.send().then((stream) async {
        await http.Response.fromStream(stream).then((value) {
          final response = jsonDecode(value.body);
          userDataResponse = ProfileModel.fromJson(response);
          logger.i("Response: $response");
          if (userDataResponse!.statusCode == 200) {
            log("Successss");
            status = Status.success;
          } else if (userDataResponse!.statusCode == 400) {
            status = Status.codeNotCorrect;
            log("Failureee");
          }
        });
      }).timeout(const Duration(seconds: 30));
    } catch (e) {
      logger.e("Error in checking code $e");
      status = Status.error;
    }
    log("Status ${status.key}");
    return ResponseResult(status, userDataResponse?.data?.image ?? "");
  }

  Future<ResponseResult> signIn(String userName, String password) async {
    Status status = Status.error;
    late LoginModel loginModel;
    UserData? userData;
    Map<String, dynamic> body = {
      "username": userName,
      "password": password,
      "fcm_token": await FirebaseService.getDeviceToken()
    };
    try {
      await requestFutureData(
          api: Api.login,
          body: body,
          requestType: Request.post,
          onSuccess: (response) async {
            if (response["status_code"] == 200) {
              status = Status.success;
              loginModel = LoginModel.fromJson(response);
              CacheHelper.saveData(
                  key: CacheKey.token,
                  value: "Bearer ${loginModel.data!.token!}");
              CacheHelper.saveData(key: CacheKey.loggedIn, value: true);
              userData = LoginModel.fromJson(response).data!.user!;
              await CacheHelper.saveData(
                  key: CacheKey.userName, value: userData!.name!);
              await CacheHelper.saveData(
                  key: CacheKey.userId, value: userData!.id!);
              await CacheHelper.saveData(
                  key: CacheKey.userImage, value: userData!.image!);
              await CacheHelper.saveData(
                  key: CacheKey.email, value: userData!.email);
              await CacheHelper.saveData(
                  key: CacheKey.phoneNumber, value: userData!.phone);
              await CacheHelper.saveData(
                  key: CacheKey.empId, value: userData!.fwId);
              await CacheHelper.saveData(
                  key: CacheKey.countryCode, value: userData!.countryCode);
              await CacheHelper.saveData(
                  key: CacheKey.busNo, value: userData!.busNo);
              await CacheHelper.saveData(
                  key: CacheKey.stcId, value: userData!.stcId);
              await CacheHelper.saveData(
                  key: CacheKey.madaMachineId, value: userData!.mada);
              await CacheHelper.saveData(
                  key: CacheKey.rate, value: userData!.rate);
              await CacheHelper.saveData(
                  key: CacheKey.position, value: userData!.position);
            } else if (response["status_code"] == 400) {
              if (response["message"].toString().contains("not active")) {
                status = Status.employeeNotActive;
              } else {
                status = Status.invalidEmailOrPass;
              }
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error Signing in $e");
    }
    return ResponseResult(status, userData);
  }

  Future<ResponseResult> getMyProfile() async {
    Status status = Status.error;
    UserData? userData;
    try {
      await requestFutureData(
          api: Api.getMyProfile,
          withToken: true,
          requestType: Request.get,
          onSuccess: (response) async {
            if (response["status_code"] == 200) {
              status = Status.success;
              userData = ProfileModel.fromJson(response).data!;
              await CacheHelper.saveData(
                  key: CacheKey.userName, value: userData!.name!);
              await CacheHelper.saveData(
                  key: CacheKey.userId, value: userData!.id!);
              await CacheHelper.saveData(
                  key: CacheKey.userImage, value: userData!.image!);
              await CacheHelper.saveData(
                  key: CacheKey.email, value: userData!.email);
              await CacheHelper.saveData(
                  key: CacheKey.phoneNumber, value: userData!.phone);
              await CacheHelper.saveData(
                  key: CacheKey.countryCode, value: userData!.countryCode);
              await CacheHelper.saveData(
                  key: CacheKey.empId, value: userData!.fwId);
              await CacheHelper.saveData(
                  key: CacheKey.busNo, value: userData!.busNo);
              await CacheHelper.saveData(
                  key: CacheKey.stcId, value: userData!.stcId);
              await CacheHelper.saveData(
                  key: CacheKey.madaMachineId, value: userData!.mada);
              await CacheHelper.saveData(
                  key: CacheKey.rate, value: userData!.rate);
            } else if (response["status_code"] == 400) {
              status = Status.invalidEmailOrPass;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error Signing in $e");
    }
    return ResponseResult(status, userData);
  }

  Future<ResponseResult> getProblemSignIn() async {
    Status status = Status.error;
    ProblemSignInData? problemSignInData;
    try {
      await requestFutureData(
          api: Api.getProblemSignIn,
          withToken: true,
          requestType: Request.get,
          onSuccess: (response) async {
            if (response["status_code"] == 200) {
              status = Status.success;
              problemSignInData =
                  ProblemSignInModel.fromJson(response).problemSignInData!;
            } else if (response["status_code"] == 400) {
              status = Status.invalidEmailOrPass;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error Signing in $e");
    }
    return ResponseResult(status, problemSignInData);
  }

  void signOut() async {
    try {
      CacheHelper.saveData(key: CacheKey.loggedIn, value: false);
      CacheHelper.saveData(key: CacheKey.userName, value: "");
      CacheHelper.saveData(key: CacheKey.email, value: "");
    } catch (e) {
      log("Error Signing out $e");
    }
  }
}
