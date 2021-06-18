import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:prog_soln/ads/ad_state.dart';
import 'package:prog_soln/models/code.dart';
import 'package:prog_soln/views/program_view.dart';
import 'package:provider/provider.dart';

import '../data/data_store.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Code> programs;

  BannerAd banner;

  @override
  void initState() {
    super.initState();
    this.programs = Data.codes;
  }

  @override
  void dispose() {
    super.dispose();
    banner?.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.init.then((value) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.homeBannerId,
          size: AdSize.banner,
          request: AdRequest(),
          listener: BannerAdListener(
            // Called when an ad is successfully received.
            onAdLoaded: (Ad ad) => print('Ad loaded.'),
            // Called when an ad request failed.
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
              // Dispose the ad here to free resources.
              ad.dispose();
              print('Ad failed to load: $error');
            },
            // Called when an ad opens an overlay that covers the screen.
            onAdOpened: (Ad ad) => print('Ad opened.'),
            // Called when an ad removes an overlay that covers the screen.
            onAdClosed: (Ad ad) => print('Ad closed.'),
            // Called when an impression occurs on the ad.
            onAdImpression: (Ad ad) => print('Ad impression.'),
          ),
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = 70.0;
    print(Theme.of(context).scaffoldBackgroundColor);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Dart Challenges"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: programs.length,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              itemBuilder: (context, i) {
                var current = programs[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (c) => MyCodeView(filePath: current.codepath),
                          builder: (c) => ProgramView(
                            code: current,
                          ),
                        ),
                      );
                    },
                    leading: Image.asset("assets/dart.png"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text(
                      current.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text("Click to View"),
                  ),
                );
              },
            ),
          ),
          (banner == null)
              ? SizedBox(height: 50)
              : SizedBox(
                  height: banner.size.height.toDouble(),
                  width: banner.size.width.toDouble(),
                  child: AdWidget(
                    ad: banner,
                  ),
                ),
        ],
      ),
    );
  }
}
