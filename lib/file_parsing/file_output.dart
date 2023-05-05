import 'dart:developer';

import 'package:creator/creator.dart';
import 'package:ffmpeg_converter/file_parsing/file_parsing_barrel.dart';

///String containing full file path and new name used for converted file.
///
///Takes inputStringCreator value and parses and converts it into new file name.
final outputStringCreator = Creator((ref) {
  //TODO: #5 @anadreau Change variable names so function flow is easier to follow.
  var fileInput = ref.watch(fileInputStringCreator);
  var parsedFileBySlash = fileInput.split('/');
  String? filePathResult;
  String newFileName;
  String result;
  String edittedFileName = ref.watch(fileNameCreator);

  if (fileInput != '') {
    List workingParsedFileList = parsedFileBySlash;

    ///String that represents the original filename
    var oldFileName = parsedFileBySlash.removeLast();

    ///Removes last item in list which should be the old file name
    workingParsedFileList.removeRange(
        parsedFileBySlash.length, parsedFileBySlash.length);

    ///Joins the workingParsedFileList by / into single String
    String joinedOutput = workingParsedFileList.join('/');

    ///finds the index where the file type starts based on last '.'
    int filetypeIndex = oldFileName.lastIndexOf('.');

    if (edittedFileName.isNotEmpty || edittedFileName != '') {
      oldFileName = edittedFileName;
      newFileName = '$oldFileName.converted.mp4';
      log('here');
    } else {
      ///Creates new String from oldFileName without the old filetype plus
      ///.converted.mp4
      log('skipped if statement');
      newFileName = '${oldFileName.substring(0, filetypeIndex)}.converted.mp4';
    }

    log('Joined: $joinedOutput');
    log('old: $oldFileName');
    log('new: $newFileName');
    result = '$joinedOutput/$newFileName';
    filePathResult = result.substring(1);
    log('result: $result');
    log('result: $filePathResult');
  } else {
    filePathResult = null;
  }

  return filePathResult;
});
