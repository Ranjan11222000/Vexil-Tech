import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'registration_view_model.dart';

class ImagePickerController extends GetxController {
  final registerVM = Get.find<RegistrationViewModel>();

  Future getImage(int index) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image =
      await picker.pickImage(source: ImageSource.camera, imageQuality: 30);

      if (image != null) {


        // Update the imagePath value to the new path
        registerVM.kycModelList[index].image = image.path;
        update();

      }
    } catch (e) {
      rethrow;
    }
  }

}
