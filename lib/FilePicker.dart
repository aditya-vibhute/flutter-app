import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Filepicker extends StatelessWidget {
     Filepicker({super.key});

  FilePickerResult? result;
  String? filename;
  bool isLoading=false;
  File? fileToDisplay;
  PlatformFile? pickedFile;

 Future<File?> selectFile()async{
    try{

      result=await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if(result!=null){
        pickedFile=result!.files.first;
        fileToDisplay=File(pickedFile!.path.toString());

      }

    }
    catch(e){
      log("Something went Wrong");
      fileToDisplay=null;

    }
    return fileToDisplay;


  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

