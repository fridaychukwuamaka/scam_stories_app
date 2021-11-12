import 'package:get/get.dart';
import 'package:scam_stories_app/constants/constants.dart';
import 'package:scam_stories_app/repository/user_service.dart';
import 'package:scam_stories_app/utils/image_utils.dart';

UserService _userService = UserService();

class ProfileController extends GetxController {
  Future<void> uploadImage() async {
    var image = await ImageUtils.selectImage();

    var url = await ImageUtils.uploadImage(image);

    _userService.updateUserImg(url, userId);
  }
}
