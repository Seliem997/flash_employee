class ProblemSignInModel {
  int? statusCode;
  Null? message;
  ProblemSignInData? problemSignInData;

  ProblemSignInModel({this.statusCode, this.message, this.problemSignInData});

  ProblemSignInModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    problemSignInData = json['data'] != null
        ? new ProblemSignInData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.problemSignInData != null) {
      data['problemSignInData'] = this.problemSignInData!.toJson();
    }
    return data;
  }
}

class ProblemSignInData {
  dynamic currentPage;
  List<Data>? data;
  String? firstPageUrl;
  dynamic from;
  dynamic lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  dynamic perPage;
  Null? prevPageUrl;
  dynamic to;
  dynamic total;

  ProblemSignInData(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  ProblemSignInData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  String? message;
  String? phoneSignProblem;
  String? whatsappSignProblem;
  String? notification;
  String? from;
  String? to;
  Null? oSType;
  String? type;

  Data(
      {this.id,
      this.message,
      this.phoneSignProblem,
      this.whatsappSignProblem,
      this.notification,
      this.from,
      this.to,
      this.oSType,
      this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    phoneSignProblem = json['phone_sign_problem'];
    whatsappSignProblem = json['whatsapp_sign_problem'];
    notification = json['notification'];
    from = json['from'];
    to = json['to'];
    oSType = json['OSType'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['phone_sign_problem'] = this.phoneSignProblem;
    data['whatsapp_sign_problem'] = this.whatsappSignProblem;
    data['notification'] = this.notification;
    data['from'] = this.from;
    data['to'] = this.to;
    data['OSType'] = this.oSType;
    data['type'] = this.type;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
