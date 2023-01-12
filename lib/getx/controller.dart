import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Controller extends GetxController{
  XFile? file;
  String? imageUrl = "";
  void pickImage()async{
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(
        source: ImageSource.gallery);
    print('${file?.path}');

    if (file == null) return;
    //Import dart:core
    String uniqueFileName =
    DateTime.now().millisecondsSinceEpoch.toString();

    /*Step 2: Upload to Firebase storage*/
    //Install firebase_storage
    //Import the library

    //Get a reference to storage root
    Reference referenceRoot =
    FirebaseStorage.instance.ref();
    Reference referenceDirImages =
    referenceRoot.child('images');

    //Create a reference for the image to be stored
    Reference referenceImageToUpload =
    referenceDirImages.child(uniqueFileName);

    //Handle errors/success
    try {
      //Store the file
      await referenceImageToUpload
          .putFile(File(file!.path));
      //Success: get the download URL
      imageUrl =
          await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      //Some error occurred
    }
    // Navigator.pop(context);
    update();
  }
}