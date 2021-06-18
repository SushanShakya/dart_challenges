import 'package:prog_soln/data/programs.dart';
import 'package:prog_soln/models/code.dart';

class Data {
  static List<Code> codes = List.generate(
    programs.length,
    (i) => Code.fromMap(i, programs[i]),
  );
}
