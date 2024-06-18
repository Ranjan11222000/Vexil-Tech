import 'dart:io';

import 'package:flutter/material.dart';

class KycModel {
  List<KycTypeModelList>? kycTypeModelList;

  KycModel({this.kycTypeModelList});

  KycModel.fromJson(Map<String, dynamic> json) {
    if (json['KycTypeModelList'] != null) {
      kycTypeModelList = <KycTypeModelList>[];
      json['KycTypeModelList'].forEach((v) {
        kycTypeModelList!.add(new KycTypeModelList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kycTypeModelList != null) {
      data['KycTypeModelList'] =
          this.kycTypeModelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KycTypeModelList {
  int? kYCTypeId;
  String? kYCTypeName;
  List<KycList>? kycList;
  String? selectedKyc;
  String? selectedKycFor;
  String? image;
  String? idNumber;
  TextEditingController idController = TextEditingController();

  KycTypeModelList({this.kYCTypeId, this.kYCTypeName, this.kycList,this.selectedKycFor,this.image,this.idNumber}){
    if (kycList != null && kycList!.isNotEmpty) {
      selectedKyc = kycList!.first.kYCName;
    }
  }

  KycTypeModelList.fromJson(Map<String, dynamic> json) {
    kYCTypeId = json['KYCTypeId'];
    kYCTypeName = json['KYCTypeName'];
    selectedKycFor = json['selectedKycFor'];
    image = json['image'];
    idNumber = json['idNumber'];
    if (json['KycList'] != null) {
      kycList = <KycList>[];
      json['KycList'].forEach((v) {
        kycList!.add(new KycList.fromJson(v));
      });
    }
    if (kycList!.isNotEmpty) {
      selectedKyc = kycList!.first.kYCName;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['KYCTypeId'] = this.kYCTypeId;
    data['KYCTypeName'] = this.kYCTypeName;
    data['selectedKycFor'] = this.selectedKycFor;
    data['image'] = this.image;
    data['idNumber'] = this.idNumber;
    if (this.kycList != null) {
      data['KycList'] = this.kycList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KycList {
  int? kYCId;
  String? kYCName;

  KycList({this.kYCId, this.kYCName});

  KycList.fromJson(Map<String, dynamic> json) {
    kYCId = json['KYCId'];
    kYCName = json['KYCName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['KYCId'] = this.kYCId;
    data['KYCName'] = this.kYCName;
    return data;
  }
}