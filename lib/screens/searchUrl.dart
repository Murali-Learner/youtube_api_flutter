import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    bool isClick = false;

    _videoId(String url) async {
      String urlid = YoutubePlayer.convertUrlToId(url);
      print(urlid);
      return urlid;
    }

    YoutubePlayerController _controller;
    bool _isPlayerReady = false;

    void listener() {
      if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
        _searchController.text = null;
        _controller = _controller;
      }
    }

    @override
    void initState() {
      super.initState();
      _controller = YoutubePlayerController(
        initialVideoId: "R0KiqCux4xU",
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);
    }

    return Scaffold(
      // extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "video URL",
                  suffixIcon: GestureDetector(
                    onTap: () async {},
                    child: Icon(
                      Icons.search,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            // YoutubePlayer(controller: _controller)
            // isClick ? YoutubePlayer(controller: _videoController) : Container(),
          ],
        ),
      ),
    );
  }
}
