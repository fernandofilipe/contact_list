import 'package:path/path.dart';

class PathHelper {
  PathHelper();

  static String getBaseName(String path) {
    return basename(path);
  }
}
