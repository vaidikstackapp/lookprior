import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:look_prior/screens/post_ad_screen/post_ad_screen.dart';
import 'package:video_player/video_player.dart';

class PostAdScreenViewModel {
  final PostAdScreenState postAdScreenState;

  PostAdScreenViewModel(this.postAdScreenState);
  List<XFile> imagePath = List.empty(growable: true);

  final String videoDescription =
      "Tap the icon below to record a short video for your listing. Your video file size must be 6MB or less. Post up to 3 videos for free! Need to upload a larger video file or want to add more than three? That's OK! We have many storage options to choose from. You will be able to post larger video files after increasing the storage capacity";
  final String photoDescription =
      "Quality images of your items will attract more buyers. Use the icon below to take pictures or upload images already stored on your phone.";
  final ImagePicker _picker = ImagePicker();
  String videoPath = '';
  Future<void> imageSource(ImageSource imageSource) async {
    try {
      final XFile? image =
          await _picker.pickImage(source: imageSource, imageQuality: 50);

      if (image != null) {
        imagePath.add(image);
        postAdScreenState.refresh();
      }
    } on PlatformException catch (e) {
      log("Catch Exception for imageSource---------->$e");
    }
  }

  Future<void> multiImagePicker() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      imagePath.addAll(images);
      postAdScreenState.refresh();
    }
  }

  videoSource(ImageSource imageSource) async {
    try {
      final XFile? video = await _picker.pickVideo(
          source: imageSource, maxDuration: const Duration(seconds: 10));
      if (video != null) {
        videoPath = video.path;
        print("videopath------------->$videoPath");
        postAdScreenState.playerController =
            VideoPlayerController.file(File(videoPath))
              ..initialize().then((_) => postAdScreenState.refresh());
        if (postAdScreenState.playerController != null) {
          postAdScreenState.playerController!.setVolume(1.0);
          postAdScreenState.playerController!.setLooping(true);
        }
      }
    } on PlatformException catch (e) {
      log("Catch exception for videoSource---------->$e");
    }
  }
}
