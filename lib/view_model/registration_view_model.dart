import 'package:get/get.dart';
import '../data/Network/network_api_service.dart';
import '../model/get_kyc_model.dart';
import '../model/post_kyc_model.dart';
import '../res/status.dart';
import '../res/utils/utils.dart';

class RegistrationViewModel extends GetxController {
  List<String> kycForList = ["Member", "Husband", "Wife", "Brother"];
  final reqStatus = Status.LOADING.obs;
  final getApi = NetworkApiService();
  final submitLoading = false.obs;
  final getAllData = <ObjAddKYCDetails>[];
  RxList<KycTypeModelList> kycModelList = <KycTypeModelList>[].obs;

  void setReqStatus(Status value) => reqStatus.value = value;

  void getKycDetail() async {
    setReqStatus(Status.LOADING);
    try {
      getApi.getApiResponse().then(
        (value) {
          KycModel kycModel = KycModel.fromJson(value);
          kycModelList.value = kycModel.kycTypeModelList ?? [];

          setReqStatus(Status.COMPLETED);
          // sendPort.send("Getting the API");
        },
      ).onError((error, stackTrace) {
        setReqStatus(Status.ERROR);
        Utils.errorSnackBar("Error", error.toString());
      });
    } catch (e) {
      setReqStatus(Status.ERROR);
      Utils.errorSnackBar("Catch Error", e.toString());
      rethrow;
    }
  }

  void submitModel() async {
    for (var a in kycModelList) {
      /*if((a.image??"").isEmpty){
        submitLoading.value=false;
        Utils.successSnackBar("Error", "Image is required");
        break;
      }*/
      getAllData.add(ObjAddKYCDetails(
          kYCTypeName: a.kYCTypeName ?? "",
          base64KYCDoc: a.image ?? "",
          kYCName: a.selectedKyc ?? "",
          noID: a.idNumber ?? "",
          kYCFor: a.selectedKycFor ?? ""));
    }

    if(submitLoading.value){

      Map data = {
        "MemberID": "BRT00000021",
        "IfAddInGroup": true,
        "GroupCode": "0020002",
        "GroupLeader": true,
        "objAddKYCDetails":getAllData
      };

      try{
        getApi.postApiResponse(data).then((value) {
          submitLoading.value=false;
          Utils.successSnackBar("Error",value);

        },).onError((error, stackTrace) {
          submitLoading.value=false;
          Utils.errorSnackBar("Error", error.toString());
        },);
      }catch(e){
        submitLoading.value=false;
        Utils.errorSnackBar("Error", e.toString());
        rethrow;
      }
    }
  }
}
