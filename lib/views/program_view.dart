import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:prog_soln/ads/ad_state.dart';
import 'package:prog_soln/main.dart';
import 'package:prog_soln/models/code.dart';
import 'package:provider/provider.dart';

class ProgramView extends StatefulWidget {
  final Code code;

  const ProgramView({Key key, this.code}) : super(key: key);

  @override
  _ProgramViewState createState() => _ProgramViewState();
}

class _ProgramViewState extends State<ProgramView> {
  bool showCode = false;

  BannerAd banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.init.then((value) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.codeBannerId,
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
  void dispose() {
    super.dispose();
    banner?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showCode = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: (showCode) ? null : Colors.blue,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        // duration: Duration(milliseconds: 500),
                        child: Text("Instructions"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showCode = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: (showCode) ? Colors.blue : null,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        // duration: Duration(milliseconds: 500),
                        child: Text("Code"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              (showCode)
                                  ? Image.asset(
                                      "assets/dart.png",
                                      height: 15,
                                      width: 15,
                                    )
                                  : Icon(
                                      Icons.info,
                                      color: Colors.blue,
                                      size: 15,
                                    ),
                              const SizedBox(width: 5),
                              Text(
                                (showCode) ? "main.dart" : "README.md",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: MyCodeView(
                      filePath: (showCode)
                          ? widget.code.codepath
                          : widget.code.readmepath,
                    ),
                  ),
                ],
              ),
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
