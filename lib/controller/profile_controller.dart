import 'package:get/get.dart';
import 'package:scam_stories_app/services/my_pref.dart';
import 'package:scam_stories_app/services/user_service.dart';
import 'package:scam_stories_app/utils/image_utils.dart';

UserService _userService = UserService();

class ProfileController extends GetxController {
  Future<void> uploadImage() async {
     var userId = MyPref.userId.val;
    var image = await ImageUtils.selectImage();

    var url = await ImageUtils.uploadImage(image);

    _userService.updateUserImg(url, userId);
  }
}
