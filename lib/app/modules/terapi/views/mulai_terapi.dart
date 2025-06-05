import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MulaiTerapiView extends StatefulWidget {
  const MulaiTerapiView({super.key});

  @override
  State<MulaiTerapiView> createState() => _MulaiTerapiViewState();
}

class _MulaiTerapiViewState extends State<MulaiTerapiView> {
  // Daftar video latihan
  final List<_LatihanData> latihanList = [
    _LatihanData(
      videoId: 'chzl_w2AwxI',
      judul: 'MOUTH EXERCISE',
      jumlah: '10x',
      instruksi: 'Tahan selama 10 detik',
    ),
    _LatihanData(
      videoId: 'abR1NSb_cTI',
      judul: 'CHEEK EXERCISE',
      jumlah: '8x',
      instruksi: 'Tahan selama 8 detik',
    ),
    _LatihanData(
      videoId: 'lFRoiq6_X-o',
      judul: 'EYE EXERCISE',
      jumlah: '12x',
      instruksi: 'Tahan selama 5 detik',
    ),
    _LatihanData(
      videoId: 'bJA8s_41ip0',
      judul: 'FOREHEAD EXERCISE',
      jumlah: '6x',
      instruksi: 'Tahan selama 7 detik',
    ),
  ];

  int currentIndex = 0;
  late YoutubePlayerController _ytController;

  @override
  void initState() {
    super.initState();
    _ytController = YoutubePlayerController(
      initialVideoId: latihanList[currentIndex].videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );
  }

  void nextLatihan() {
    if (currentIndex < latihanList.length - 1) {
      setState(() {
        currentIndex++;
        _ytController.load(latihanList[currentIndex].videoId);
      });
    }
  }

  void prevLatihan() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _ytController.load(latihanList[currentIndex].videoId);
      });
    }
  }

  @override
  void dispose() {
    _ytController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF306A5A);
    final Color mainPink = const Color(0xFFFF7B7B);

    final latihan = latihanList[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFAFAFAF),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, size: 28, color: Colors.black54),
                  ),
                  const Spacer(),
                  Text(
                    'LATIHAN ${currentIndex + 1} DARI ${latihanList.length}',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 28), // Untuk keseimbangan dengan tombol close
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Video Youtube
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: YoutubePlayer(
                  controller: _ytController,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: mainGreen,
                  width: double.infinity,
                  aspectRatio: 1,
                ),
              ),
            ),
            // Konten bawah
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Jumlah dan instruksi
                      Text(
                        latihan.jumlah,
                        style: TextStyle(
                          color: mainGreen,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '(${latihan.instruksi})',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 22),
                      // Judul latihan
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            latihan.judul,
                            style: TextStyle(
                              color: mainPink,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.5,
                              letterSpacing: 1.1,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(Icons.error_outline, color: mainPink, size: 18),
                        ],
                      ),
                      const Spacer(),
                      // Tombol berikutnya
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: currentIndex < latihanList.length - 1 ? nextLatihan : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainGreen,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'BERIKUTNYA',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Tombol sebelumnya
                      TextButton(
                        onPressed: currentIndex > 0 ? prevLatihan : null,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black38,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 1.1,
                          ),
                        ),
                        child: const Text('SEBELUMNYA'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model data latihan
class _LatihanData {
  final String videoId;
  final String judul;
  final String jumlah;
  final String instruksi;
  _LatihanData({
    required this.videoId,
    required this.judul,
    required this.jumlah,
    required this.instruksi,
  });
}
