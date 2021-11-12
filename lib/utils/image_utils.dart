import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:scam_stories_app/constants/constants.dart';
import 'package:uuid/uuid.dart';

final ImagePicker _picker = ImagePicker();
final _uuid = Uuid();

class ImageUtils {
  static Future<String> uploadImage(XFile image) async {
    var id = _uuid.v4();
    try {
      var sentImage = await firebase_storage.FirebaseStorage.instance
          .ref('dp/' + id + image.name)
          .putFile(File(image.path));
      var url = await sentImage.ref.getDownloadURL();
      print(url);

      AppThemes.snackBar('Image Uploaded Succefully');
      return url;
    } catch (e) {
      firebase_storage.FirebaseException? error;
      error = e as firebase_storage.FirebaseException?;

      AppThemes.snackBar(error!.message);
      throw (e);
    }
  }

  static Future<XFile> selectImage() async {
    // Pick an image
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    return image!;
  }
}
