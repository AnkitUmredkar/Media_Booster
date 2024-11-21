import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../modal/video_modal.dart';
import '../service/api_service.dart';

class VideoProvider extends ChangeNotifier {
  VideoPlayerModal? videoPlayerModal;
  ChewieController? chewieController;

  ApiService apiHelper = ApiService(); // instance of api helper class

  late VideoPlayerController videoPlayerController;

  Future<VideoPlayerModal?> fetchApiData() async {
    final data = await apiHelper.fetchApiData();
    videoPlayerModal = VideoPlayerModal.fromJson(data);
    return videoPlayerModal;
  }

  Future<void> videoControllerInitializer(String videoUrl) async {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        videoUrl.split('http').join('https'),
      ),
    );
    await videoPlayerController.initialize();
  }

  Future<void> chewieControllerInitializer(String videoUrl) async {
    await videoControllerInitializer(videoUrl);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      aspectRatio: videoPlayerController.value.aspectRatio,
      // Progress bar customization
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.red,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.white.withOpacity(0.5),
      ),
      playbackSpeeds: [0.5, 1.0, 1.5, 2.0],
      allowFullScreen: true,
      fullScreenByDefault: false,
      placeholder: const Center(
        child: CircularProgressIndicator(color: Colors.red),
      ),
      subtitleBuilder: (context, subtitle) => Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.black54,
        child: Text(
          subtitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
    notifyListeners();
  }

  VideoProvider() {
    fetchApiData();
  }
}
