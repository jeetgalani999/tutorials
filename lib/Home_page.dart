import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music/Details.dart';
import 'package:music/Modal.dart';

List image = [
  'assets/images/img.png',
  'assets/images/img_1.png',
  'assets/images/img_2.png',
  'assets/images/img_3.png',
  'assets/images/img_4.png',
  'assets/images/img_5.png',
  'assets/images/img_6.png',
  'assets/images/img_7.png',
  'assets/images/img_8.png',
  'assets/images/img_9.png',
];
List name = [
  'Tera Ban Jaunga ',
  'Yaara           ',
  'Ghungroo War    ',
  'Pal Pal Dil Ke  ',
  'Dil Mein Ho Tum ',
  'Dheere Dheere   ',
  'Kesariya Tera   ',
  'Param Sundari   ',
  'Deva Deva       ',
  'Aashiqui Aa Gayi',
];

List details = [
  'Tulsi Kumar &   \nAkhil Sachdeva',
  'Mamta Sharma    ',
  'Arijit Singh &  \nShilpa Rao',
  'Arijit Singh &  \nparampara',
  'Armaan Malik    ',
  'Honey Singh     ',
  'Arijit Singh    ',
  'Shreya Gaushal  ',
  'Arijit Singh    ',
  'Arijit Singh    ',
];

List color = [
  Colors.blue,
  Colors.blueAccent,
  Colors.cyan,
  Colors.green,
  Colors.lightGreen,
  Colors.deepOrange,
  Colors.orange,
  Colors.pink,
  Colors.red,
  Colors.deepPurple,
];
List<bool> audio1 = [
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
  true,
];
List music = [
  'assets/audio/Tera Ban Jaunga - Kabir Singh 320 Kbps.mp3',
  'assets/audio/Yaara - Mamta Sharma 320 Kbps.mp3',
  'assets/audio/01 - Ghungroo - War (2019).mp3',
  'assets/audio/Y2Mate.is - Pal Pal Dil Ke Paas - Title Song  Lyrical  Karan Deol, Sahher Bambba  Arijit Singh, Parampara-i1HpSzorjlc-48k-1660230949314.mp3',
  'assets/audio/Dil Mein Ho Tum - Cheat India.mp3',
  'assets/audio/Dheere Dheere (Yo Yo Honey Singh) - 320Kbps.mp3',
  'assets/audio/Kesariya-Tera-Ishq-Hai-Piya.mp3',
  'assets/audio/Param Sundari - Mimi.mp3',
  'assets/audio/Deva Deva.mp3',
  'assets/audio/Aashiqui Aa Gayi - Radhe Shyam.mp3'
];
List time = [
  '0:3:56',
  '0:4:26',
  '0:5:3',
  '0:4:22',
  '0:5:26',
  '0:3:32',
  '0:4:28',
  '0:3:20',
  '0:4:39',
  '0:4:20',
];

class Home_page extends StatefulWidget {
  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  bool audio = true;
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text('Rainbow Music'),
          centerTitle: true,
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details.name(
                          data: Argument.name(
                        image: image[index],
                        name: name[index],
                        details: details[index],
                        time: time[index],
                        music: music[index],
                      )),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 100,
                    width: 190,
                    decoration: BoxDecoration(
                      color: color[index],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: CircleAvatar(
                                maxRadius: 30,
                                minRadius: 30,
                                backgroundImage: AssetImage(image[index]),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  name[index],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  details[index],
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 280),
                          child: Row(
                            children: [
                              if (audio1[index] == true) ...{
                                FloatingActionButton(
                                  heroTag: 'Hero1',
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  onPressed: () {
                                    assetsAudioPlayer.open(Audio(music[index]),
                                        showNotification: true);
                                    audio1[index] = false;
                                    setState(() {});
                                  },
                                  child: Icon(Icons.play_arrow),
                                ),
                              } else if (audio1[index] == false) ...{
                                FloatingActionButton(
                                  heroTag: 'Hero2',
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  onPressed: () {
                                    assetsAudioPlayer.stop();
                                    audio1[index] = true;
                                    setState(() {});
                                  },
                                  child: Icon(Icons.stop),
                                ),
                              },
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
            itemCount: name.length));
  }
}
