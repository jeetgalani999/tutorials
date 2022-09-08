// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:music/Modal.dart';
//
// import 'Home_page.dart';
//
// class Details extends StatefulWidget {
//   final Argument data;
//
//   Details.name({required this.data});
//
//   @override
//   State<Details> createState() => _DetailsState();
// }
//
// class _DetailsState extends State<Details> {
//   final assetsAudioPlayer = AssetsAudioPlayer();
//
//   AudioPlayer player = AudioPlayer();
//   bool _play = false;
//   bool _play1 = false;
//   double value1 = 0;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//
//   int maxduration = 100;
//   int currentpos = 0;
//   String currentpostlabel = "00:00";
//
//   @override
//   void initState() {
//     player.onDurationChanged.listen((Duration d) {
//       //get the duration of audio
//       maxduration = d.inMilliseconds;
//       setState(() {});
//     });
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.black,
//         centerTitle: true,
//         title: Text('Now playing'),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             SizedBox(
//                 height: double.infinity,
//                 width: double.infinity,
//                 child: ColorFiltered(
//                     colorFilter: ColorFilter.mode(
//                         Colors.black.withOpacity(0.5), BlendMode.dstATop),
//                     child: Image.asset(
//                       widget.data.image,
//                       fit: BoxFit.fill,
//                     ))),
//             Center(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 150,
//                   ),
//                   Container(
//                     width: 200,
//                     margin: EdgeInsets.all(10),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Image(
//                         image: AssetImage(widget.data.image),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(),
//                     child: Text(widget.data.name,
//                         style: TextStyle(color: Colors.white, fontSize: 30)),
//                   ),
//                   AudioWidget.assets(
//                     path: widget.data.music,
//                     play: _play1,
//                     child: FloatingActionButton(
//                       onPressed: () {
//                         _play1 = !_play1;
//                         setState(() {});
//                       },
//                       child:
//                           _play1 ? Icon(Icons.pause) : Icon(Icons.play_arrow),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volume_control/volume_control.dart';

import 'Modal.dart';

class Details extends StatefulWidget {
  final Argument data;

  Details.name({required this.data});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int maxduration = 100;
  int currentpos = 0;
  bool isplaying = false;
  String currentpostlabel = "00:00";
  bool audioplayed = false;
  late Uint8List audiobytes;

  AudioPlayer player = AudioPlayer();
  double? _val;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ByteData bytes =
          await rootBundle.load(widget.data.music); //load audio from assets
      audiobytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      player.onDurationChanged.listen((Duration d) {
        //get the duration of audio
        maxduration = d.inMilliseconds;
        setState(() {});
      });

      player.onAudioPositionChanged.listen((Duration p) async {
        currentpos =
            p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds: currentpos).inHours;
        int sminutes = Duration(milliseconds: currentpos).inMinutes;
        int sseconds = Duration(milliseconds: currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";
        _val = await VolumeControl.volume;
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Now Playing"),
            centerTitle: true,
            backgroundColor: Colors.black),
        body: SafeArea(
          child: Container(
              child: Stack(
            children: [
              SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.dstATop),
                      child: Image.asset(
                        widget.data.image,
                        fit: BoxFit.fill,
                      ))),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        margin: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: AssetImage(widget.data.image),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(widget.data.name,
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(widget.data.details,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  int result = await player.stop();
                                  if (result == 1) {
                                    //stop success
                                    setState(() {
                                      isplaying = false;
                                      audioplayed = false;
                                      currentpos = 0;
                                    });
                                  } else {
                                    print("Error on stop audio.");
                                  }
                                },
                                child: Icon(
                                  Icons.stop,
                                  color: Colors.white,
                                  size: 30,
                                )),
                            GestureDetector(
                                onTap: () async {
                                  if (!isplaying && !audioplayed) {
                                    int result =
                                        await player.playBytes(audiobytes);
                                    if (result == 1) {
                                      setState(() {
                                        isplaying = true;
                                        audioplayed = true;
                                      });
                                    } else {
                                      print("Error while playing audio.");
                                    }
                                  } else if (audioplayed && !isplaying) {
                                    int result = await player.resume();
                                    if (result == 1) {
                                      setState(() {
                                        isplaying = true;
                                        audioplayed = true;
                                      });
                                    } else {
                                      print("Error on resume audio.");
                                    }
                                  } else {
                                    int result = await player.pause();
                                    if (result == 1) {
                                      setState(() {
                                        isplaying = false;
                                      });
                                    } else {
                                      print("Error on pause audio.");
                                    }
                                  }
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                      color: Colors.white,
                                      size: 50,
                                      isplaying
                                          ? Icons.pause
                                          : Icons.play_arrow),
                                )),
                            GestureDetector(
                              onDoubleTap: () {
                                VolumeControl.setVolume(0.5);
                                setState(() {});
                              },
                              onTap: () async {
                                _val = await VolumeControl.volume;
                                VolumeControl.setVolume(0);
                                setState(() {});
                              },
                              child: Icon(
                                  _val == 0
                                      ? Icons.headphones
                                      : Icons.volume_mute,
                                  // Icons.headphones,
                                  color: Colors.white,
                                  size: 30),
                            ),
                          ],
                        ),
                      ),
                      Slider(
                        thumbColor: Colors.lightGreen,
                        inactiveColor: Colors.grey,
                        activeColor: Colors.green,
                        value: double.parse(currentpos.toString()),
                        min: 0,
                        max: double.parse(maxduration.toString()),
                        divisions: maxduration,
                        // label: currentpostlabel,
                        onChanged: (double value) async {
                          int seekval = value.round();
                          int result = await player
                              .seek(Duration(microseconds: seekval));
                          await player.seek(Duration(milliseconds: seekval));
                          if (result == 1) {
                            currentpos = seekval;
                          } else {
                            print("Seek unsuccessful.");
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(currentpostlabel,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            Text('/',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            Text(widget.data.time,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
        ));
  }
}
//     label: Text("Stop")),
// ElevatedButton.icon(
//     onPressed: () async {
//       int result = await player.stop();
//       if (result == 1) {
//         //stop success
//         setState(() {
//           isplaying = false;
//           audioplayed = false;
//           currentpos = 0;
//         });
//       } else {
//         print("Error on stop audio.");
//       }
//     },
//     icon: Icon(Icons.stop),

// Container(
// child: Text(
// currentpostlabel,
// style: TextStyle(fontSize: 25),
// ),
// ),

// Container(
// child: Slider(
// thumbColor: Colors.lightGreen,
// inactiveColor: Colors.grey,
// activeColor: Colors.green,
// value: double.parse(currentpos.toString()),
// min: 0,
// max: double.parse(maxduration.toString()),
// divisions: maxduration,
// label: currentpostlabel,
// onChanged: (double value) async {
// int seekval = value.round();
// int result =
//     await player.seek(Duration(microseconds: seekval));
// await player.seek(Duration(milliseconds: seekval));
// if (result == 1) {
// //seek successful
// currentpos = seekval;
// } else {
// print("Seek unsuccessful.");
// }
// },
// )),
