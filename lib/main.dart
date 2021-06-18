import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:prog_soln/ads/ad_state.dart';
import 'package:prog_soln/views/home.dart';
import 'package:prog_soln/utils/code_highlighter.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(
    Provider.value(
      value: adState,
      builder: (_, __) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: darkMode ? Brightness.dark : Brightness.light,
        fontFamily: "Poppins",
      ),
      home: HomeView(),
    );
  }
}

class MyCodeView extends StatefulWidget {
  final String filePath;
  final Function onBtnTap;

  MyCodeView({
    @required this.filePath,
    this.onBtnTap,
  });

  @override
  MyCodeViewState createState() {
    return MyCodeViewState();
  }
}

class MyCodeViewState extends State<MyCodeView> {
  double _textScaleFactor = 1.0;

  Widget _getCodeView(String codeContent, BuildContext context) {
    final SyntaxHighlighterStyle style =
        Theme.of(context).brightness == Brightness.dark
            ? SyntaxHighlighterStyle.darkThemeStyle()
            : SyntaxHighlighterStyle.lightThemeStyle();
    return LayoutBuilder(
      builder: (c, box) => Container(
        height: box.maxHeight,
        width: box.maxWidth,
        // color: Colors.blue,
        child: Scrollbar(
          child: SingleChildScrollView(
            // physics: const BouncingScrollPhysics(),
            child: SingleChildScrollView(
              // physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: RichText(
                textScaleFactor: this._textScaleFactor,
                text: TextSpan(
                  style: TextStyle(fontSize: 14.0, fontFamily: "Fira Code"),
                  children: <TextSpan>[
                    DartSyntaxHighlighter(style).format(codeContent)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootBundle.loadString(widget.filePath) ??
          'Error loading source code from $this.filePath',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: _getCodeView(snapshot.data, context),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
