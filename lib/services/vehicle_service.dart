import 'dart:developer';

import '../base/service/base_service.dart';
import '../models/manufacturersModel.dart';

import '../models/requestResult.dart';
import '../models/vehiclesModelsModel.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class VehicleService extends BaseService {
  Future<ResponseResult> getManufacturers() async {
    Status result = Status.error;
    /*Map<String, String> headers = const {
      'Content-Type': 'application/json'};*/

    List<ManufacturerData> manufacturerDataList = [];
    try {
      await requestFutureData(
          api: Api.getManufacturers,
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          // headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              manufacturerDataList =
                  ManufacturersModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Manufacturer Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Manufacturer Data$e");
    }
    return ResponseResult(result, manufacturerDataList);
  }

  Future<ResponseResult> getManufacturersOfType(
      {required int vehicleTypeId}) async {
    Status result = Status.error;
    List<ManufacturerData> manufacturerDataList = [];
    try {
      await requestFutureData(
          api: '${Api.getManufacturersOfType}$vehicleTypeId',
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          onSuccess: (response) async {
            try {
              result = Status.success;
              manufacturerDataList =
                  ManufacturersModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Manufacturer Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Manufacturer Data$e");
    }
    return ResponseResult(result, manufacturerDataList);
  }

  Future<ResponseResult> getVehiclesModels({required int manufactureId}) async {
    Status result = Status.error;

    List<VehiclesModelsData> vehiclesModelsDataList = [];
    try {
      await requestFutureData(
          api: '${Api.getVehiclesModels}$manufactureId',
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          onSuccess: (response) async {
            try {
              result = Status.success;
              vehiclesModelsDataList =
                  VehicleModelsModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Vehicle Models Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Vehicle Models Data$e");
    }
    return ResponseResult(result, vehiclesModelsDataList);
  }

  Future<ResponseResult> updateVehicle({
    required int vehicleId,
    required int vehicleTypeId,
    required String? name,
    required String? year,
    required String? color,
    required String? letters,
    required String? numbers,
    required int? manufacturerId,
    required int? vehicleModelId,
    required int? subVehicleTypeId,
  }) async {
    Status result = Status.error;
    Map<String, String> headers = const {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "vehicle_type_id": vehicleTypeId,
      "name_en": name ?? "",
      "year": int.tryParse(year ?? ""),
      "color": int.tryParse(color ?? ""),
      "letters": letters,
      "numbers": int.tryParse(numbers ?? ""),
      "manufacturer_id": manufacturerId,
      "vehicle_model_id": vehicleModelId,
      "sub_vehicle_type_id": subVehicleTypeId
    };

    List<ManufacturerData> manufacturerDataList = [];
    try {
      await requestFutureData(
          api: Api.updateVehicle(vehicleId),
          requestType: Request.put,
          jsonBody: true,
          withToken: true,
          headers: headers,
          body: body,
          onSuccess: (response) async {
            try {
              result = Status.success;
              // manufacturerDataList =
              //     ManufacturersModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error updating vehicle\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error updating vehicle$e");
    }
    return ResponseResult(result, manufacturerDataList);
  }
}
