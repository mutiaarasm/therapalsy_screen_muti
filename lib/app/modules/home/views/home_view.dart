import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapalsy_screen_muti/models/home_graphics.dart';
import 'package:therapalsy_screen_muti/services/home_graphics_service.dart';



import '../../deteksi/views/deteksi_view.dart';
import '../../profile/views/profile_view.dart';
import '../../progress/views/progress_view.dart';
import '../../terapi/views/terapi_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF316B5C);
    final double cardHeight = 290;
    final double cardRadius = 22;

    // final List<YoutubeChannelData> dummyYoutubeData = [
    //   YoutubeChannelData("Dr. Sarah Health", 25400),
    //   YoutubeChannelData("Neuro Care", 18700),
    //   YoutubeChannelData("Face Recovery", 14200),
    //   YoutubeChannelData("Physio Therapy", 11300),
    //   YoutubeChannelData("Bell's Palsy Support", 9200),
    // ];
    

    // List card data
    final List<_HomeCardData> cards = [
      _HomeCardData(
        
        bgColor: const Color(0xFFF7C6C6),
        image: 'assets/images/dashboard.png',
        title: "Lets Try\nFace exercise\nfor Bell’s Palsy\nnow!",
        subtitle: "10 minutes",
        buttonText: "LETS TRY !",
        onPressed: () {
          Get.to(() => TerapiView ());
        },
      ),
      _HomeCardData(
        bgColor: const Color(0xFFF7C6C6),
        image: 'assets/images/face1.png',
        title: "Detect your face\nand start your\nrecovery journey\nnow!",
        subtitle: "Fast Scan",
        buttonText: "DETECT MY FACE",
        onPressed: () {
        Get.to(() => const DeteksiView());
      
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Welcome to Therapalsy !',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: mainGreen,
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Carousel slider / PageView
            SizedBox(
              height: cardHeight + 16,
              child: PageView.builder(
                itemCount: cards.length,
                controller: PageController(viewportFraction: 0.88),
                itemBuilder: (context, index) {
                  final data = cards[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        left: index == 0 ? 22 : 12,
                        right: index == cards.length - 1 ? 22 : 12),
                    child: _HomePinkCard(
                      data: data,
                      height: cardHeight,
                      borderRadius: cardRadius,
                      mainGreen: mainGreen,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),
            // Dot indicator
            Center(
              child: _PageIndicator(
                count: cards.length,
              ),
            ),

            const SizedBox(height: 30),

            // Section: Tentang Bell's Palsy
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                "Tentang Bell’s Palsy",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: mainGreen,
                ),
              ),
            ),
            const SizedBox(height: 14),

            // FAQ Card 1
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              child: _FaqCard(
                title: "Apa itu Bell’s Palsy?",
                content: "lorem ipsum dolor amet hehhe\nbaca selengkapnya?",
                mainGreen: mainGreen,
              ),
            ),

            // FAQ Card 2
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              child: _FaqCard(
                title: "Apa Penyebab Bells Palsy?",
                content: "lorem ipsum dolor amet hehhe\nbaca selengkapnya?",
                mainGreen: mainGreen,
              ),
            ),

            const SizedBox(height: 20),
            
            // Grafik Batang
            const SizedBox(height: 28),
            Container(
  height: 430,
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.symmetric(horizontal: 18),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: mainGreen.withOpacity(0.22), width: 1.5),
  ),
  child: FutureBuilder<HomeGraphicsData>(
    future: fetchHomeGraphicsData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData) {
        return const Center(child: Text('No data available'));
      }
      final data = snapshot.data!;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Grafik 1: 5 Video dengan Viewers Terbanyak
            Text("5 Video dengan Viewers Terbanyak",
                style: TextStyle(
                    color: mainGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
            const SizedBox(height: 10),
            _simpleBarChart(
              labels: data.topVideos.map((e) => e.title).toList(),
              values: data.topVideos.map((e) => e.views).toList(),
              barColor: Colors.red,
              height: 120,
            ),
            const SizedBox(height: 20),

            // Grafik 2: Top 10 Kata Kunci Terbanyak
            Text("Top 10 Kata Kunci Terbanyak",
                style: TextStyle(
                    color: mainGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
            const SizedBox(height: 10),
            _simpleBarChart(
              labels: data.topWords.map((e) => e.kata).toList(),
              values: data.topWords.map((e) => e.jumlah).toList(),
              barColor: Colors.orange,
              height: 80,
            ),
            const SizedBox(height: 20),

            // Grafik 3: Top 10 Channel
            Text("Top 10 Channel",
                style: TextStyle(
                    color: mainGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
            const SizedBox(height: 10),
            _simpleBarChart(
              labels: data.topChannels.map((e) => e.channel).toList(),
              values: data.topChannels.map((e) => e.count).toList(),
              barColor: mainGreen,
              height: 80,
            ),
          ],
        ),
      );
    },
  ),
),
          ],
          
          
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: _HomeBottomNav(mainGreen: mainGreen),
    );
  }
}


// --- Widget untuk Card Pink di Carousel ---
class _HomeCardData {
  final Color bgColor;
  final String image;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  _HomeCardData({
    required this.bgColor,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
  });
}

class _HomePinkCard extends StatelessWidget {
  final _HomeCardData data;
  final double height;
  final double borderRadius;
  final Color mainGreen;

  const _HomePinkCard({
    required this.data,
    required this.height,
    required this.borderRadius,
    required this.mainGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: data.bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        children: [
          // Image
          Positioned(
            right: 0,
            left: 60,
            top: 0,
            bottom:0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius),
              ),
              child: Image.asset(
                data.image,
                width: 350,
                fit: BoxFit.contain,

              ),
            ),
          ),
          // Text dan tombol
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (data.subtitle == "10 minutes")
                      const Icon(Icons.access_time, color: Colors.white, size: 18),
                    if (data.subtitle == "10 minutes")
                      const SizedBox(width: 6),
                    Text(
                      data.subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: data.onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 0,
                    ),
                    child: Text(
                      data.buttonText,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Dot Indicator sederhana untuk PageView ---
class _PageIndicator extends StatefulWidget {
  final int count;
  const _PageIndicator({required this.count});

  @override
  State<_PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<_PageIndicator> {
  int currentPage = 0;
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.count, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: currentPage == index ? const Color(0xFF316B5C) : Colors.grey[300],
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}

// --- FAQ Card Widget ---
class _FaqCard extends StatelessWidget {
  final String title;
  final String content;
  final Color mainGreen;

  const _FaqCard({
    required this.title,
    required this.content,
    required this.mainGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: mainGreen.withOpacity(0.22), width: 1.5),
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: mainGreen,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// --- Bottom Navigation Bar ---
class _HomeBottomNav extends StatelessWidget {
  final Color mainGreen;
  const _HomeBottomNav({required this.mainGreen});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: mainGreen,
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.crop_free),
          label: 'Detection',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          label: 'Progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      currentIndex: 0,
      onTap: (index) {
        switch (index) {
          case 0:
            Get.to(() => const HomeView());
            break;
          case 1:
            // Navigasi ke deteksi
            Get.to(() => const DeteksiView());
            break;
          case 2:
            // Navigasi ke progress
            Get.to(() => const ProgressView());
          case 3:
          
            // Navigasi ke ProfileView
            Get.to(() => const ProfileView());
            break;
        }
      },
    );
  }
}
Widget _simpleBarChart({
  required List<String> labels,
  required List<int> values,
  required Color barColor,
  double height = 120,
}) {
  return SizedBox(
    height: height,
    child: BarChart(
      BarChartData(
        barGroups: List.generate(
          values.length,
          (i) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: values[i].toDouble(),
                color: barColor,
                width: 18,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx >= 0 && idx < labels.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      labels[idx],
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    ),
  );
}

