// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   return runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Home_page(),
//   ));
// }
//
// class Home_page extends StatefulWidget {
//   const Home_page({Key? key}) : super(key: key);
//
//   @override
//   State<Home_page> createState() => _Home_pageState();
// }
//
// class _Home_pageState extends State<Home_page> {
//   final assetsAudioPlayer = AssetsAudioPlayer();
//   bool audio = true;
//   double value=10;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (audio == true) ...{
//                 FloatingActionButton(
//                   onPressed: () {
//                     assetsAudioPlayer.open(Audio(''),
//                         showNotification: true);
//
//                     audio = false;
//                     setState(() {});
//                   },
//                   child: Icon(Icons.play_arrow),
//                 ),
//               } else if (audio == false) ...{
//                 FloatingActionButton(
//                   onPressed: () {
//                     assetsAudioPlayer.stop();
//                     audio = true;
//                     setState(() {});
//                   },
//                   child: Icon(Icons.stop),
//                 ),
//               },
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:music/Home_page.dart';

void main() {
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home_page(),
  ));
}
