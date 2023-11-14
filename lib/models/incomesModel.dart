class IncomesModel {
  int? statusCode;
  Null? message;
  List<IncomeData>? data;

  IncomesModel({this.statusCode, this.message, this.data});

  IncomesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <IncomeData>[];
      json['data'].forEach((v) {
        data!.add(new IncomeData.fromJson(v));
      });
    }
  }
}

class IncomeData {
  int? id;
  String? requestId;
  String? status;
  dynamic rate;
  String? payBy;
  String? feedback;
  dynamic packageId;
  String? amount;
  String? lateTime;
  String? actualTime;
  dynamic tax;
  String? discountAmount;
  String? totalAmount;
  String? totalDuration;
  String? time;
  String? date;
  Customer? customer;
  City? city;
  Employee? employee;
  List<Services>? services;
  List<Services>? extraServices;
  List<Services>? basicServices;
  List<Services>? otherServices;

  IncomeData(
      {this.id,
      this.requestId,
      this.status,
      this.rate,
      this.payBy,
      this.feedback,
      this.packageId,
      this.amount,
      this.lateTime,
      this.actualTime,
      this.tax,
      this.discountAmount,
      this.totalAmount,
      this.totalDuration,
      this.time,
      this.date,
      this.customer,
      this.city,
      this.employee,
      this.services});

  IncomeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    status = json['status'];
    rate = json['rate'];
    payBy = json['pay_by'];
    feedback = json['feedback'];
    packageId = json['package_id'];
    amount = json['amount'];
    lateTime = json['late_time'];
    actualTime = json['actual_time'];
    tax = json['tax'];
    discountAmount = json['discount_amount'];
    totalAmount = json['total_amount'];
    totalDuration = json['total_duration'];
    time = json['time'];
    date = json['date'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
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
  }
}

class Customer {
  int? id;
  String? fwid;
  String? phone;
  String? name;
  List<Location>? location;
  List<Vehicle>? vehicle;

  Customer(
      {this.id, this.fwid, this.phone, this.name, this.location, this.vehicle});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwid = json['fwid'];
    phone = json['phone'];
    name = json['name'];
    if (json['location'] != null) {
      location = <Location>[];
      json['location'].forEach((v) {
        location!.add(new Location.fromJson(v));
      });
    }
    if (json['vehicle'] != null) {
      vehicle = <Vehicle>[];
      json['vehicle'].forEach((v) {
        vehicle!.add(new Vehicle.fromJson(v));
      });
    }
  }
}

class Location {
  int? id;
  String? image;
  String? type;
  String? latitude;
  String? langitude;
  String? locationName;
  int? customerId;

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
}

class Vehicle {
  int? id;
  String? name;
  String? numbers;
  String? letters;
  String? color;
  String? year;
  String? mainImage;
  int? customerId;
  int? manufacturerId;
  String? manufacturerName;
  String? manufacturerLogo;
  int? vehicleModelId;
  String? vehicleModelName;
  int? vehicleTypeId;
  String? vehicleTypeName;
  int? subVehicleTypeId;
  String? subVehicleTypeName;
  Customer? customer;

  Vehicle(
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
      this.subVehicleTypeName,
      this.customer});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    numbers = json['numbers'];
    letters = json['letters'];
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
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }
}

class City {
  int? id;
  String? name;
  int? minAmount;
  int? status;

  City({this.id, this.name, this.minAmount, this.status});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minAmount = json['min_amount'];
    status = json['status'];
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
}

class Services {
  int? id;
  String? title;
  String? image;
  String? info;
  String? type;
  int? duration;
  bool? countable;
  String? requestServicePrice;
  int? requestServiceCount;
  String? requestServiceTotalPrice;

  Services(
      {this.id,
      this.title,
      this.image,
      this.info,
      this.type,
      this.duration,
      this.countable,
      this.requestServicePrice,
      this.requestServiceCount,
      this.requestServiceTotalPrice});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    info = json['info'];
    type = json['type'];
    duration = json['duration'];
    countable = json['countable'];
    requestServicePrice = json['request_service_price'];
    requestServiceCount = json['request_service_count'];
    requestServiceTotalPrice = json['request_service_total_price'];
  }
}
