import 'package:file_picker/file_picker.dart';

/// Abstraction for file selection operations
abstract class FilePickerDataSource {
  Future<String?> pickDirectory();
}

/// Implementation using file_picker package
class FilePickerDataSourceImpl implements FilePickerDataSource {
  @override
  Future<String?> pickDirectory() async {
    return await FilePicker.platform.getDirectoryPath();
  }
}
