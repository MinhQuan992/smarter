import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await storage.ref('images/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String> downloadUrl(String imageName) async {
    return await storage.ref('images/$imageName').getDownloadURL();
  }
}
