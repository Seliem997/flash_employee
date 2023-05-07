import 'dart:math' as math;
import 'package:maps_launcher/maps_launcher.dart';
import '../base/service/base_service.dart';

class CommonService extends BaseService {
  // static final _storageInstance = FirebaseStorage.instance;
  // static final _firestoreInstance = FirebaseFirestore.instance;
  //
  // static Future<ResponseResult> uploadImageToStorage(
  //     Uint8List file, FileStorageType fileType,
  //     {String extendedProfileId = ""}) async {
  //   Status status;
  //   String filePath = "";
  //   String fileUrl = "";
  //   late Reference ref;
  //   try {
  //     if (fileType == FileStorageType.profilePicture) {
  //       filePath =
  //           "${StorageFolder.users.key}/${CacheHelper.returnData(key: CacheKey.userId.key)}/${StorageFolder.profilePicture.key}";
  //       ref = _storageInstance.ref().child("$filePath/pp.jpeg");
  //     } else if (fileType == FileStorageType.extendedProfileImage) {
  //       filePath =
  //           "${StorageFolder.users.key}/${CacheHelper.returnData(key: CacheKey.userId.key)}/${StorageFolder.extendedProfiles.key}/$extendedProfileId";
  //       ref = _storageInstance.ref().child("$filePath/image.jpeg");
  //     }
  //     UploadTask uploadTask =
  //         ref.putData(file, SettableMetadata(contentType: 'image/jpeg'));
  //     await uploadTask.then((res) async {
  //       await res.ref.getDownloadURL().then((value) {
  //         log("Url : $value");
  //         fileUrl = value;
  //       });
  //     });
  //
  //     if (fileUrl.isNotEmpty && fileType == FileStorageType.profilePicture) {
  //       status = Status.success;
  //       _firestoreInstance
  //           .collection("Users")
  //           .doc(CacheHelper.returnData(key: CacheKey.userId.key))
  //           .update({"Profile Photo": fileUrl});
  //     } else if (fileUrl.isNotEmpty &&
  //         fileType == FileStorageType.extendedProfileImage) {
  //       status = Status.success;
  //       _firestoreInstance
  //           .collection("Users")
  //           .doc(CacheHelper.returnData(key: CacheKey.userId.key))
  //           .collection("extendedProfiles")
  //           .doc("vehicles")
  //           .collection("data")
  //           .doc(extendedProfileId)
  //           .update({"image": fileUrl});
  //     } else {
  //       status = Status.error;
  //     }
  //   } catch (e) {
  //     status = Status.error;
  //     log('error uploading file to storage $e');
  //   }
  //   return ResponseResult(status, fileUrl);
  // }

  // static void signInFirstDialog(BuildContext context) {
  //   StylishDialog(
  //     context: context,
  //     alertType: StylishDialogType.INFO,
  //     title: TextWidget(
  //       text: S.of(context).joinUs,
  //       color: AppColor.dark,
  //       textSize: 16,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     content: Column(
  //       children: [
  //         TextWidget(
  //           text: S.of(context).pleaseJoinUsFirstToUseThisFeature,
  //           color: AppColor.dark,
  //           textSize: 14,
  //           fontWeight: FontWeight.w400,
  //         ),
  //         verticalSpace(5),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             DefaultButton(
  //               text: S.of(context).notNow,
  //               backgroundColor: AppColor.grey,
  //               height: 35,
  //               width: 120,
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             horizontalSpace(3),
  //             DefaultButton(
  //               text: S.of(context).login,
  //               height: 35,
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 navigateTo(context, const LoginScreen());
  //               },
  //               width: 100,
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //     // animationLoop: true,
  //   ).show();
  // }

  // static void mismatchItemsDialog(BuildContext context) {
  //   StylishDialog(
  //     context: context,
  //     alertType: StylishDialogType.WARNING,
  //     title: TextWidget(
  //       text: S.of(context).itemsTypesProblem,
  //       color: AppColor.dark,
  //       textSize: 16,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     content: Column(
  //       children: [
  //         TextWidget(
  //           text: S.of(context).youCantCheckoutAPlanWithAShopItemPlease,
  //           color: AppColor.dark,
  //           textSize: 14,
  //           fontWeight: FontWeight.w400,
  //         ),
  //         verticalSpace(5),
  //         DefaultButton(
  //           text: S.of(context).gotIt,
  //           height: 35,
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //         ),
  //       ],
  //     ),
  //     // animationLoop: true,
  //   ).show();
  // }

  static Future<void> openMap(double latitude, double longitude,
      {bool isQuery = false}) async {
    if (isQuery) {
      MapsLauncher.launchQuery(
          "X9G5+XCF, El Basatin, Cairo Governorate 4237026, Egypt");
    } else {
      MapsLauncher.launchCoordinates(latitude, longitude);
    }
  }

  static String generateRandomString(int len) {
    var r = math.Random();
    const _chars = '1234567890';
    // const _chars =
    //     'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  // static Future<bool> checkIsThereUpdate(
  //     String androidLatestVersion, String iOSLatestVersion) async {
  //   final packageInfo = await PackageInfo.fromPlatform();
  //
  //   bool needUpdate = false;
  //   final currentVersion = packageInfo.version.split(".");
  //   final remoteVersionAndroid = androidLatestVersion.split(".");
  //   final remoteVersionIOS = iOSLatestVersion.split(".");
  //   if (Platform.isAndroid) {
  //     if (int.parse(remoteVersionAndroid[0]) > int.parse(currentVersion[0])) {
  //       needUpdate = true;
  //     } else if (int.parse(remoteVersionAndroid[1]) >
  //         int.parse(currentVersion[1])) {
  //       needUpdate = true;
  //     } else if (int.parse(remoteVersionAndroid[2]) >
  //         int.parse(currentVersion[2])) {
  //       needUpdate = true;
  //     }
  //   } else {
  //     if (int.parse(remoteVersionIOS[0]) > int.parse(currentVersion[0])) {
  //       needUpdate = true;
  //     } else if (int.parse(remoteVersionIOS[1]) >
  //         int.parse(currentVersion[1])) {
  //       needUpdate = true;
  //     } else if (int.parse(remoteVersionIOS[2]) >
  //         int.parse(currentVersion[2])) {
  //       needUpdate = true;
  //     }
  //   }
  //   return needUpdate;
  // }
}
