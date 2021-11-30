import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:youtube_api/methods/channelInfo.dart';
import 'package:youtube_api/methods/videosList.dart';
import 'package:youtube_api/methods/youtubeData.dart';
import 'package:youtube_api/screens/displayVideo.dart';
import 'package:youtube_api/screens/searchUrl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    String playListId = "";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Youtube",
          style: TextStyle(color: Colors.black, fontSize: 37),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Container(
            height: _height * 0.1,
            width: _width * 0.1,
            child: FutureBuilder<ChannelInfo>(
              future: YoutubeData.channelData(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? profileImg(context, snapshot)
                    : Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () async {},
                          icon: Icon(
                            Icons.person_rounded,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          height: _height,
          width: _width,
          // color: Colors.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: _height * 0.87,
                width: _width,
                // color: Colors.red,
                child: FutureBuilder<VideosList>(
                  future: YoutubeData.getVideos("UU5lbdURzjB0irr-FTbjWN1A"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<VideoItem> videosList = snapshot.data.videos;
                      return Column(
                        children: [
                          Text(
                            snapshot.data.videos.first.video.channelTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          SizedBox(
                            height: _height * 0.007,
                          ),
                          Container(
                            height: _height * 0.8,
                            width: _width,
                            alignment: Alignment.center,
                            // color: Colors.grey,
                            child: ListView.builder(
                              itemCount: videosList.length,
                              itemBuilder: (context, index) {
                                VideoItem videoItem = videosList[index];
                                return GestureDetector(
                                  onTap: () {
                                    print(videoItem.video.resourceId.toJson());
                                    // Navigator.push(context, MaterialPageRoute(
                                    //   builder: (context) {
                                    //     return PlayVideo(
                                    //       videoItem: videoItem,
                                    //     );
                                    //   },
                                    // ));
                                  },
                                  child: thumbnail(
                                      _height, _width, videosList, index),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [CircularProgressIndicator()],
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container profileImg(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return Container(
      alignment: Alignment.center,
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.2,
      child: InkWell(
        onTap: () async {
          print(snapshot
              .data.items.first.contentDetails.relatedPlaylists.uploads);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return UserScreen();
          //     },
          //   ),
          // );
        },
        child: CircleAvatar(
          radius: 23,
          backgroundImage: CachedNetworkImageProvider(
              snapshot.data.items.first.snippet.thumbnails.medium.url),
        ),
      ),
    );
  }

  Stack thumbnail(
      double _height, double _width, List<VideoItem> videosList, int index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              // color: Colors.black,
              ),
          height: _height * 0.34,
          width: _width,
          alignment: Alignment.center,
          child: Material(
            borderRadius: BorderRadius.circular(50),
            elevation: 8,
            type: MaterialType.card,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: ListTile(
                tileColor: Colors.amber,
                title: CachedNetworkImage(
                  imageUrl: videosList[index].video.thumbnails.maxres.url,
                  height: 200,
                  width: 200,
                  placeholder: (context, url) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  },
                  errorWidget: (context, url, error) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  },
                ),
                subtitle: Text(
                  videosList[index].video.title,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: _height * 0.01,
        ),
      ],
    );
  }
}
