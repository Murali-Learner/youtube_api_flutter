import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:youtube_api/methods/channelInfo.dart';
import 'package:youtube_api/methods/videosList.dart';

class YoutubeData {
  static String apiKey = 'AIzaSyDIomyWHJmrRG2Y7dkx9_7n89QA0KdxgjU';

  static String channelId = 'UC5lbdURzjB0irr-FTbjWN1A';
  static Future<ChannelInfo> channelData() async {
    var client = http.Client();
    final String uri =
        "https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id=$channelId&key=$apiKey";

    try {
      final channaelResponse = await client.get(Uri.parse(uri));

      return channelInfoFromJson(channaelResponse.body);
    } catch (e) {
      print(e);
      return channelData();
    }
  }

  static Future<VideosList> getVideos(String playlistID) async {
    String apiKey = 'AIzaSyDIomyWHJmrRG2Y7dkx9_7n89QA0KdxgjU';
    var client = http.Client();
    const channelId = 'UC5lbdURzjB0irr-FTbjWN1A';

    try {
      final videoResponse = await client.get(
        Uri.parse(
          "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=$playlistID&key=$apiKey&maxResults=15",
        ),
      );
      print(videosListFromJson(videoResponse.body));
      return videosListFromJson(videoResponse.body);
    } catch (e) {
      print(e);
      return VideosList();
    }
  }
}
