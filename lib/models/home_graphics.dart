class TopVideo {
  final String title;
  final int views;
  TopVideo({required this.title, required this.views});
  factory TopVideo.fromJson(Map<String, dynamic> json) =>
      TopVideo(title: json['title'], views: json['views']);
}

class TopWord {
  final String kata;
  final int jumlah;
  TopWord({required this.kata, required this.jumlah});
  factory TopWord.fromJson(Map<String, dynamic> json) =>
      TopWord(kata: json['Kata'], jumlah: json['Jumlah']);
}

class TopChannel {
  final String channel;
  final int count;
  TopChannel({required this.channel, required this.count});
  factory TopChannel.fromJson(Map<String, dynamic> json) =>
      TopChannel(channel: json['channel'], count: json['count']);
}

class HomeGraphicsData {
  final List<TopVideo> topVideos;
  final List<TopWord> topWords;
  final List<TopChannel> topChannels;
  HomeGraphicsData({
    required this.topVideos,
    required this.topWords,
    required this.topChannels,
  });

  factory HomeGraphicsData.fromJson(Map<String, dynamic> json) => HomeGraphicsData(
        topVideos: (json['top_videos'] as List)
            .map((e) => TopVideo.fromJson(e))
            .toList(),
        topWords: (json['top_words'] as List)
            .map((e) => TopWord.fromJson(e))
            .toList(),
        topChannels: (json['top_channels'] as List)
            .map((e) => TopChannel.fromJson(e))
            .toList(),
      );
}
