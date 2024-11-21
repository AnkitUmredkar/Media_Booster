import 'dart:math';

import 'package:flutter/material.dart';
import 'package:media_booster/view/video_page.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/theme_provider.dart';
import '../provider/video_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    VideoProvider providerTrue =
        Provider.of<VideoProvider>(context, listen: true);
    VideoProvider providerFalse =
        Provider.of<VideoProvider>(context, listen: false);
    ThemeProvider themeProviderTrue =
        Provider.of<ThemeProvider>(context, listen: true);
    ThemeProvider themeProviderFalse =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Image.asset(
              themeProviderTrue.isDark
                  ? "assets/images/yt_logo_darkmode.png"
                  : "assets/images/yt_logo_lightmode.png",
              height: themeProviderTrue.isDark ? 60 : 50,
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
              ),
              onPressed: () {},
              tooltip: 'Notifications',
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
              ),
              onPressed: () {},
              tooltip: 'Search',
            ),
            IconButton(
              icon: Icon(
                themeProviderTrue.isDark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode,
              ),
              onPressed: () {
                themeProviderFalse.toggleTheme();
              },
              tooltip: 'Theme',
            ),
            const SizedBox(width: 10),
            const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                  "https://media.licdn.com/dms/image/v2/D4D03AQE6gxMXqVCKNg/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1728405022067?e=2147483647&v=beta&t=6WTdCLLWDhBrER_ng-dSoK9H7yaeWBQwR__8g-CWNm4"),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: providerFalse.fetchApiData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return showShimmerEffect();
              },
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount:
                  providerTrue.videoPlayerModal!.categories.first.videos.length,
              itemBuilder: (context, index) {
                final video = providerTrue
                    .videoPlayerModal!.categories.first.videos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 10.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      int comment = Random().nextInt(1000);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VideoPage(
                            videoUrl: video.sources.first,
                            title: video.title,
                            channelName: video.description,
                            views: '1M',
                            comment: comment,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Video Thumbnail
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  video.thumb,
                                ),
                              )),
                        ),
                        // Video Details
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                          leading: const CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('assets/images/ytlogo.png'),
                          ),
                          title: Text(
                            video.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            'Channel Name • ${index + 1}M views • ${index + 1} days ago',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Shorts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Library',
          ),
        ],
      ),
    );
  }

  Padding showShimmerEffect() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
