import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:upticker/Pages/AudioConfig.dart';

class AudioPlayerClass extends StatefulWidget {
  AudioPlayerClass({Key key, this.url}) : super(key: key);
  final String url;
  @override
  _AudioPlayerClassState createState() => _AudioPlayerClassState();
}

class _AudioPlayerClassState extends State<AudioPlayerClass> {
  AudioPlayer _player;
  bool playing = true;
  @override
  void initState() {
    _player = AudioPlayer();
    _init();
    super.initState();
  }

  //https://upticker.ams3.digitaloceanspaces.com/upticker/media/audios/test_0.mp3?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=SDLOCDW2Z3JGPD54AJP5%2F20210127%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20210127T093846Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=2fe8251f000d25dca61da04cfd44a543c4b74112047ddce83c572446955d8a2f

  _init() async {
    print('url is = ${widget.url}');
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    try {
      await _player
          .setUrl('${widget.url}')
          .then((value) => {print('second is = ${value.inMilliseconds}')});
    } catch (e) {
      print("An error occured $e");
    }
    _player.play();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        height: height / 10,
        width: width,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            SizedBox(
              width: width / 10,
            ),
            InkWell(
              onTap: () {
                if (playing == false) {
                  setState(() {
                    playing = true;
                  });
                  _player.play();
                } else {
                  setState(() {
                    playing = false;
                  });
                  _player.pause();
                }
              },
              child: Icon(playing == false ? Icons.pause : Icons.play_arrow,
                  color: Colors.black),
            ),
            SizedBox(
              width: width / 30,
            ),
            StreamBuilder<Duration>(
              stream: _player.durationStream,
              builder: (context, snapshot) {
                final duration = snapshot.data ?? Duration.zero;
                return StreamBuilder<Duration>(
                  stream: _player.positionStream,
                  builder: (context, snapshot) {
                    var position = snapshot.data ?? Duration.zero;
                    if (position > duration) {
                      position = duration;
                    }
                    return SeekBar(
                      duration: duration,
                      position: position,
                      onChangeEnd: (newPosition) {
                        _player.seek(newPosition);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
