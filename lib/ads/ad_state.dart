import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class AdState {
  Future<InitializationStatus> init;

  AdState(this.init);

  // String get bannerId => "ca-app-pub-3940256099942544/6300978111";

  String get homeBannerId => "ca-app-pub-4317773806707889/1662943918";

  String get codeBannerId => "ca-app-pub-4317773806707889/5224830692";
}
