class RequestsModel {
  int? statusCode;
  Null? message;
  List<RequestData>? data;

  RequestsModel({this.statusCode, this.message, this.data});

  RequestsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RequestData>[];
      json['data'].forEach((v) {
        data!.add(new RequestData.fromJson(v));
      });
    }
  }
}

class RequestData {
  int? id;
  String? requestId;
  String? status;
  dynamic distance;
  dynamic rate;
  String? payBy;
  dynamic feedback;
  dynamic packageId;
  String? amount;
  dynamic tax;
  String? discountAmount;
  String? totalAmount;
  String? totalDuration;
  String? time;
  String? date;
  String? slotsDate;
  Customer? customer;
  City? city;
  Employee? employee;
  VehicleRequest? vehicleRequest;
  Location? locationRequest;
  List<Services>? services;
  List<Services>? extraServices;
  List<Services>? basicServices;
  List<Services>? otherServices;
  List<Slots>? slots;

  RequestData(
      {this.id,
      this.requestId,
      this.status,
      this.distance,
      this.rate,
      this.payBy,
      this.feedback,
      this.packageId,
      this.amount,
      this.tax,
      this.discountAmount,
      this.totalAmount,
      this.totalDuration,
      this.time,
      this.date,
        this.slotsDate,
        this.customer,
      this.city,
      this.employee,
      this.services,
        this.slots
      });

  RequestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    status = json['status'];
    distance = json['distance'];
    rate = json['rate'];
    payBy = json['pay_by'];
    feedback = json['feedback'];
    packageId = json['package_id'];
    amount = json['amount'];
    tax = json['tax'];
    discountAmount = json['discount_amount'];
    totalAmount = json['total_amount'];
    totalDuration = json['total_duration'];
    time = json['time'];
    date = json['date'];
    slotsDate = json['slots_date'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    vehicleRequest = json['vehicleRequest'] != null
        ? VehicleRequest.fromJson(json['vehicleRequest'])
        : null;
    locationRequest = json['request_address'] != null
        ? Location.fromJson(json['request_address'])
        : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    if (json['services_other'] != null) {
      otherServices = <Services>[];
      json['services_other'].forEach((v) {
        otherServices!.add(Services.fromJson(v));
      });
    }
    if (json['services_extra'] != null) {
      extraServices = <Services>[];
      json['services_extra'].forEach((v) {
        extraServices!.add(Services.fromJson(v));
      });
    }
    if (json['services_basic'] != null) {
      basicServices = <Services>[];
      json['services_basic'].forEach((v) {
        basicServices!.add(Services.fromJson(v));
      });
    }
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(Slots.fromJson(v));
      });
    }
  }
}

class Customer {
  int? id;
  String? fwid;
  String? name;
  String? phone;
  List<Location>? location;

  Customer({this.id, this.fwid, this.name, this.location});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwid = json['fwid'];
    name = json['name'];
    phone = json['phone'];
    if (json['location'] != null) {
      location = <Location>[];
      json['location'].forEach((v) {
        location!.add(Location.fromJson(v));
      });
    }
  }
}

class VehicleRequest {
  int? id;
  String? name;
  String? numbers;
  String? letters;
  String? lettersInArabic;
  String? color;
  String? year;
  String? mainImage;
  dynamic customerId;
  dynamic manufacturerId;
  String? manufacturerName;
  String? manufacturerLogo;
  dynamic vehicleModelId;
  String? vehicleModelName;
  dynamic vehicleTypeId;
  String? vehicleTypeName;
  dynamic subVehicleTypeId;
  String? subVehicleTypeName;

  VehicleRequest(
      {this.id,
      this.name,
      this.numbers,
      this.letters,
      this.color,
      this.year,
      this.mainImage,
      this.customerId,
      this.manufacturerId,
      this.manufacturerName,
      this.manufacturerLogo,
      this.vehicleModelId,
      this.vehicleModelName,
      this.vehicleTypeId,
      this.vehicleTypeName,
      this.subVehicleTypeId,
      this.subVehicleTypeName});

  VehicleRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    numbers = json['numbers'];
    letters = json['letters'];
    lettersInArabic = json['letters_others'];
    color = json['color'];
    year = json['year'];
    mainImage = json['main_image'];
    customerId = json['customer_id'];
    manufacturerId = json['manufacturer_id'];
    manufacturerName = json['manufacturer_name'];
    manufacturerLogo = json['manufacturer_logo'];
    vehicleModelId = json['vehicle_model_id'];
    vehicleModelName = json['vehicle_model_name'];
    vehicleTypeId = json['vehicle_type_id'];
    vehicleTypeName = json['vehicle_type_name'];
    subVehicleTypeId = json['sub_vehicle_type_id'];
    subVehicleTypeName = json['sub_vehicle_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['numbers'] = this.numbers;
    data['letters'] = this.letters;
    data['color'] = this.color;
    data['year'] = this.year;
    data['main_image'] = this.mainImage;
    data['customer_id'] = this.customerId;
    data['manufacturer_id'] = this.manufacturerId;
    data['manufacturer_name'] = this.manufacturerName;
    data['manufacturer_logo'] = this.manufacturerLogo;
    data['vehicle_model_id'] = this.vehicleModelId;
    data['vehicle_model_name'] = this.vehicleModelName;
    data['vehicle_type_id'] = this.vehicleTypeId;
    data['vehicle_type_name'] = this.vehicleTypeName;
    data['sub_vehicle_type_id'] = this.subVehicleTypeId;
    data['sub_vehicle_type_name'] = this.subVehicleTypeName;
    return data;
  }
}

class Location {
  int? id;
  String? image;
  String? type;
  String? latitude;
  String? langitude;
  String? locationName;
  dynamic customerId;

  Location(
      {this.id,
      this.image,
      this.type,
      this.latitude,
      this.langitude,
      this.locationName,
      this.customerId});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    type = json['type'];
    latitude = json['latitude'];
    langitude = json['langitude'];
    locationName = json['location_name'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['type'] = this.type;
    data['latitude'] = this.latitude;
    data['langitude'] = this.langitude;
    data['location_name'] = this.locationName;
    data['customer_id'] = this.customerId;
    return data;
  }
}

class City {
  int? id;
  String? name;
  dynamic minAmount;
  dynamic status;

  City({this.id, this.name, this.minAmount, this.status});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minAmount = json['min_amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['min_amount'] = this.minAmount;
    data['status'] = this.status;
    return data;
  }
}

class Employee {
  int? id;
  String? name;

  Employee({this.id, this.name});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Services {
  int? id;
  String? title;
  String? image;
  String? info;
  String? type;
  dynamic duration;
  bool? countable;
  dynamic count;

  Services(
      {this.id,
      this.title,
      this.image,
      this.info,
      this.type,
      this.duration,
      this.countable});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    info = json['info'];
    type = json['type'];
    duration = json['duration'];
    countable = json['countable'];
    count = json['request_service_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['info'] = this.info;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['countable'] = this.countable;
    return data;
  }
}

class Slots {
  int? id;
  String? startAt;
  String? endAt;
  dynamic employeeId;
  dynamic shiftId;
  String? status;
  dynamic gapTime;
  String? createdAt;

  Slots(
      {this.id,
        this.startAt,
        this.endAt,
        this.employeeId,
        this.shiftId,
        this.status,
        this.gapTime,
        this.createdAt});

  Slots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    employeeId = json['employee_id'];
    shiftId = json['shift_id'];
    status = json['status'];
    gapTime = json['gap_time'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['employee_id'] = this.employeeId;
    data['shift_id'] = this.shiftId;
    data['status'] = this.status;
    data['gap_time'] = this.gapTime;
    data['created_at'] = this.createdAt;
    return data;
  }
}