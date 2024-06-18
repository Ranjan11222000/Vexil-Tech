class SubmitKycModel {
  String? message;
  String? memberID;
  bool? ifAddInGroup;
  String? groupCode;
  bool? groupLeader;
  List<ObjAddKYCDetails>? objAddKYCDetails;

  SubmitKycModel(
      {this.memberID,
        this.message,
        this.ifAddInGroup,
        this.groupCode,
        this.groupLeader,
        this.objAddKYCDetails});

  SubmitKycModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    memberID = json['MemberID'];
    ifAddInGroup = json['IfAddInGroup'];
    groupCode = json['GroupCode'];
    groupLeader = json['GroupLeader'];
    if (json['objAddKYCDetails'] != null) {
      objAddKYCDetails = <ObjAddKYCDetails>[];
      json['objAddKYCDetails'].forEach((v) {
        objAddKYCDetails!.add(new ObjAddKYCDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['MemberID'] = this.memberID;
    data['IfAddInGroup'] = this.ifAddInGroup;
    data['GroupCode'] = this.groupCode;
    data['GroupLeader'] = this.groupLeader;
    if (this.objAddKYCDetails != null) {
      data['objAddKYCDetails'] =
          this.objAddKYCDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ObjAddKYCDetails {
  String? kYCTypeName;
  String? base64KYCDoc;
  String? kYCName;
  String? noID;
  String? kYCFor;

  ObjAddKYCDetails(
      {this.kYCTypeName,
        this.base64KYCDoc,
        this.kYCName,
        this.noID,
        this.kYCFor});

  ObjAddKYCDetails.fromJson(Map<String, dynamic> json) {
    kYCTypeName = json['KYCTypeName'];
    base64KYCDoc = json['Base64KYCDoc'];
    kYCName = json['KYCName'];
    noID = json['NoID'];
    kYCFor = json['KYCFor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['KYCTypeName'] = this.kYCTypeName;
    data['Base64KYCDoc'] = this.base64KYCDoc;
    data['KYCName'] = this.kYCName;
    data['NoID'] = this.noID;
    data['KYCFor'] = this.kYCFor;
    return data;
  }
}