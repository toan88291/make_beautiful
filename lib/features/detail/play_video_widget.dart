import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideoWidget extends StatefulWidget {
  final String linkVideo;

  PlayVideoWidget(this.linkVideo);

  @override
  _PlayVideoWidgetState createState() => _PlayVideoWidgetState();
}

class _PlayVideoWidgetState extends State<PlayVideoWidget> {
  YoutubePlayerController _youtubePlayerController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.linkVideo != null) {
      _youtubePlayerController = YoutubePlayerController(
        initialVideoId: widget.linkVideo,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          disableDragSeek: false,
          hideThumbnail: true,
          enableCaption: false,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.linkVideo != null
          ? YoutubePlayer(
        controller: _youtubePlayerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _youtubePlayerController.metadata.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              debugPrint('Settings Tapped!');
            },
          ),
        ],
        onEnded: (data) {
          debugPrint('Next Video Started!');
        },
      )
          : Center(
        child: Text(
          'Chưa có video ...',
          style:
          Theme.of(context).textTheme.subtitle2.copyWith(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}