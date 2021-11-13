export 'app_themes.dart';
export 'routes/app_pages.dart';

import 'package:get_storage/get_storage.dart';

final box = GetStorage();
final String userId = box.read('userId') ?? '';
