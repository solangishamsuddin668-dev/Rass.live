Jigar ab ham Ras live dobara shoro se bana ty hai ok isko chaik karlo fer Batana Kiya Kiya Karna hai 

// RASSLIVE - FINAL V6 - 50 GIFTS + GHADI WATCH - CHAPPAL REMOVED ✅
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'package:permission_handler/permission_handler.dart';

// --- ZEGO KEYS ---
const int zegoAppID = 0;
const String zegoAppSign = 'PUT_YOUR_NEW_SIGN_HERE_AFTER_RESET';

List<CameraDescription> cameras = [];
int myDiamonds = 100;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.microphone.request();
  try {
    cameras = await availableCameras();
  } catch (e) {
    debugPrint("Camera Error: $e");
  }
  runApp(const MyApp());
}

// --- ROOMS ---
class RoomCategory {
  String name; String liveID; bool isPrivate; String type; int score;
  RoomCategory({required this.name, required this.liveID, required this.isPrivate, required this.type, this.score = 0});
}

List<RoomCategory> allRooms = [
  RoomCategory(name: "Female Live Room 1", liveID: "female_room_1", isPrivate: false, type: "female", score: 150),
  RoomCategory(name: "Private Room 🔒", liveID: "private_room_1", isPrivate: true, type: "private", score: 200),
  RoomCategory(name: "Ludo Game Room", liveID: "game_ludo", isPrivate: false, type: "game", score: 120),
  RoomCategory(name: "Video Editing Room", liveID: "video_edit_room", isPrivate: false, type: "editing", score: 180),
];

// --- GIFTS MODEL ---
class GiftModel {
  String name; int diamond; int rs; String type; Color color; String emoji; String desc;
  GiftModel({required this.name, required this.diamond, required this.rs, required this.type, required this.color, required this.emoji, required this.desc});
}

// --- 50 GIFTS - CHAPPAL REMOVED, GHADI ADDED ---
final List<GiftModel> allGifts = [
  GiftModel(name: "Narel 🥥", diamond: 5, rs: 2, type: "narel", color: Colors.brown, emoji: "🥥", desc: "Gussa"),
  GiftModel(name: "Karela 🥒", diamond: 5, rs: 2, type: "karela", color: Colors.green, emoji: "🥒", desc: "Gussa"),
  GiftModel(name: "Tamatar 🍅", diamond: 10, rs: 5, type: "tamatar", color: Colors.red, emoji: "🍅", desc: "Gussa"),
  GiftModel(name: "Kabootar 🕊️", diamond: 10, rs: 5, type: "kabootar", color: Colors.grey, emoji: "🕊️", desc: "Pyar wala"),
  GiftModel(name: "Anda 🥚", diamond: 15, rs: 7, type: "anda", color: Colors.yellow, emoji: "🥚", desc: "Gussa"),
  GiftModel(name: "Dil ❤️", diamond: 20, rs: 10, type: "dil", color: Colors.red, emoji: "❤️", desc: "Love Dil"),
  GiftModel(name: "Ghadi ⌚", diamond: 25, rs: 12, type: "ghadi", color: Colors.blueGrey, emoji: "⌚", desc: "Ghadi Gift"), // <-- CHAPPAL KI JAGAH GHADI
  GiftModel(name: "Dhadkan 💓", diamond: 40, rs: 20, type: "dhadkan", color: Colors.redAccent, emoji: "💓", desc: "Dhadkan"),
  GiftModel(name: "Love Kiss 💋", diamond: 50, rs: 25, type: "love", color: Colors.pink, emoji: "💋", desc: "Urti Kiss"),
  GiftModel(name: "Coffee ☕", diamond: 60, rs: 30, type: "coffee", color: Colors.brown, emoji: "☕", desc: "Garam Coffee"),
  GiftModel(name: "Gulab 🌹", diamond: 100, rs: 50, type: "gulab", color: Colors.pinkAccent, emoji: "🌹", desc: "Mezban par"),
  GiftModel(name: "Ice Cream 🍦", diamond: 120, rs: 60, type: "icecream", color: Colors.pink, emoji: "🍦", desc: "Thandi Icecream"),
  GiftModel(name: "Tota Maina 🦜", diamond: 150, rs: 75, type: "tota_maina", color: Colors.green, emoji: "🦜", desc: "Love Birds Jodi"),
  GiftModel(name: "Chocolate 🍫", diamond: 160, rs: 80, type: "chocolate", color: Colors.brown, emoji: "🍫", desc: "Meethi Chocolate"),
  GiftModel(name: "Teddy 🧸", diamond: 180, rs: 90, type: "teddy", color: Colors.brown, emoji: "🧸", desc: "Pyaara Teddy"),
  GiftModel(name: "Ring 💍", diamond: 200, rs: 100, type: "ring", color: Colors.amber, emoji: "💍", desc: "Ring"),
  GiftModel(name: "Dress 👗", diamond: 200, rs: 100, type: "dress", color: Colors.purple, emoji: "👗", desc: "Bridal Dress"),
  GiftModel(name: "Perfume 🌸", diamond: 250, rs: 125, type: "perfume", color: Colors.pink, emoji: "🌸", desc: "Khushbu"),
  GiftModel(name: "Heart Arrow 💘", diamond: 300, rs: 150, type: "heart_arrow", color: Colors.red, emoji: "💘", desc: "Dil me teer"),
  GiftModel(name: "Crown 👑", diamond: 320, rs: 160, type: "crown", color: Colors.amber, emoji: "👑", desc: "Raja Crown"),
  GiftModel(name: "I Love You 💖", diamond: 350, rs: 175, type: "iloveu", color: Colors.pink, emoji: "💖", desc: "Feeling wala"),
  GiftModel(name: "Guitar 🎸", diamond: 400, rs: 200, type: "guitar", color: Colors.brown, emoji: "🎸", desc: "Music"),
  GiftModel(name: "Bike 🏍️", diamond: 450, rs: 225, type: "bike", color: Colors.red, emoji: "🏍️", desc: "Tez Bike"),
  GiftModel(name: "Propose 💍❤️", diamond: 500, rs: 250, type: "propose", color: Colors.pinkAccent, emoji: "💍❤️", desc: "Shaadi Propose"),
  GiftModel(name: "Pegasus 🐴🪽", diamond: 500, rs: 250, type: "pegasus", color: Colors.white, emoji: "🐴🪽", desc: "Udta Ghoda"),
  GiftModel(name: "Firework 🎆", diamond: 500, rs: 250, type: "firework_gift", color: Colors.amber, emoji: "🎆", desc: "Atishbazi"),
  GiftModel(name: "Car 🚗", diamond: 550, rs: 275, type: "car", color: Colors.blue, emoji: "🚗", desc: "Nayi Car"),
  GiftModel(name: "Lock Heart 🔐❤️", diamond: 600, rs: 300, type: "lock_heart", color: Colors.deepPurple, emoji: "🔐❤️", desc: "Dil Lock"),
  GiftModel(name: "Tiger 🐯", diamond: 700, rs: 350, type: "tiger", color: Colors.orange, emoji: "🐯", desc: "Sher"),
  GiftModel(name: "Lion 🦁", diamond: 800, rs: 400, type: "lion", color: Colors.amber, emoji: "🦁", desc: "Jungle King"),
  GiftModel(name: "Hathi 🐘", diamond: 1000, rs: 500, type: "hathi", color: Colors.grey, emoji: "🐘", desc: "Hathi Raja"),
  GiftModel(name: "Eagle 🦅", diamond: 1200, rs: 600, type: "eagle", color: Colors.brown, emoji: "🦅", desc: "Uqab"),
  GiftModel(name: "Castle 🏰", diamond: 1500, rs: 750, type: "castle", color: Colors.grey, emoji: "🏰", desc: "Mehal"),
  GiftModel(name: "Rocket 🚀", diamond: 1800, rs: 900, type: "rocket", color: Colors.white, emoji: "🚀", desc: "Rocket"),
  GiftModel(name: "Unicorn 🦄", diamond: 2000, rs: 1000, type: "unicorn", color: Colors.pink, emoji: "🦄", desc: "Jadui Ghoda"),
  GiftModel(name: "Money Rain 💸", diamond: 2500, rs: 1250, type: "money", color: Colors.green, emoji: "💸", desc: "Paisa Barish"),
  GiftModel(name: "Diamond Rain 💎", diamond: 3000, rs: 1500, type: "diamond_rain", color: Colors.blue, emoji: "💎", desc: "Heera Barish"),
  GiftModel(name: "Phoenix 🦚", diamond: 3500, rs: 1750, type: "phoenix", color: Colors.red, emoji: "🦚", desc: "Phoenix Bird"),
  GiftModel(name: "Whale 🐋", diamond: 4000, rs: 2000, type: "whale", color: Colors.blue, emoji: "🐋", desc: "Samandar Wala"),
  GiftModel(name: "Galaxy 🌌", diamond: 4500, rs: 2250, type: "galaxy", color: Colors.deepPurple, emoji: "🌌", desc: "Poori Galaxy"),
  GiftModel(name: "Helicopter 🚁", diamond: 4800, rs: 2400, type: "heli", color: Colors.grey, emoji: "🚁", desc: "Udata Helicopter"),
  GiftModel(name: "Universe 🌠", diamond: 5000, rs: 2500, type: "universe", color: Colors.purple, emoji: "🌠", desc: "Kainat"),
  GiftModel(name: "Golden Crown 👑✨", diamond: 6000, rs: 3000, type: "gold_crown", color: Colors.amber, emoji: "👑✨", desc: "Sone ka Taj"),
  GiftModel(name: "Super Car 🏎️", diamond: 7000, rs: 3500, type: "supercar", color: Colors.red, emoji: "🏎️", desc: "Super Fast Car"),
  GiftModel(name: "Private Jet ✈️", diamond: 7500, rs: 3750, type: "jet", color: Colors.white, emoji: "✈️", desc: "Jahaz"),
  GiftModel(name: "Yacht 🛥️", diamond: 7800, rs: 3900, type: "yacht", color: Colors.blue, emoji: "🛥️", desc: "Samandar Jahaz"),
  GiftModel(name: "Taj Mahal 🕌", diamond: 7900, rs: 3950, type: "taj", color: Colors.white, emoji: "🕌", desc: "Mohabbat ki Nishani"),
  GiftModel(name: "KingKong 🦍", diamond: 8000, rs: 4000, type: "kingkong", color: Colors.brown, emoji: "🦍", desc: "KingKong Power"),
  GiftModel(name: "Dragon 🐉", diamond: 15000, rs: 7500, type: "dragon", color: Colors.red, emoji: "🐉", desc: "Aag Wala Dragon"),
  GiftModel(name: "Jadu Wala Jin 🧞‍♂️", diamond: 25000, rs: 12500, type: "jinn", color: Colors.deepPurpleAccent, emoji: "🧞‍♂️", desc: "3 Wishes - Final Boss"),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: cameras.isEmpty
         ? const Scaffold(body: Center(child: Text("Camera nahi mila - Mobile pe chalao")))
          : LiveRoom(camera: cameras.first),
    );
  }
}

class LiveRoom extends StatefulWidget {
  final CameraDescription camera;
  const LiveRoom({super.key, required this.camera});
  @override
  State<LiveRoom> createState() => _LiveRoomState();
}

class _LiveRoomState extends State<LiveRoom> {
  late CameraController _controller;
  bool _isInit = false;
  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() { _isInit = true; });
    });
  }
  @override
  void dispose() {
    if (_isInit) _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if (!_isInit) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: const Text("RASSLIVE V6 - GHADI ⌚")),
      body: CameraPreview(_controller),
    );
  }
}
