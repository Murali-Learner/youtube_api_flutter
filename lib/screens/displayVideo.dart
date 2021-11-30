import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:youtube_api/methods/videosList.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayVideo extends StatefulWidget {
  final VideoItem videoItem;
  PlayVideo({this.videoItem});
  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  YoutubePlayerController _videoController;
  bool _isPlayerReady = false;
  bool textFull = false;
  @override
  void initState() {
    super.initState();

    _videoController = YoutubePlayerController(
      initialVideoId: widget.videoItem.video.resourceId.videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        hideControls: false,
        hideThumbnail: false,
        enableCaption: true,
        disableDragSeek: false,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_videoController.value.isFullScreen) {
      //
    }
  }

  @override
  void deactivate() {
    _videoController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: [
              YoutubePlayer(
                controller: _videoController,
                controlsTimeOut: Duration(seconds: 3),
              ),
              Container(
                child: Text(
                  widget.videoItem.video.title,
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: _height * 0.06),
                child: RichText(
                  // maxLines: 9,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: widget.videoItem.video.description,
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print(_videoController.value.errorCode);
                        }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
