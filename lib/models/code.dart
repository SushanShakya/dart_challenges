class Code {
  final int id;
  final String title;
  final String codepath;
  final String readmepath;

  Code({this.id, this.title, this.codepath, this.readmepath});

  factory Code.fromMap(int id, Map<String, dynamic> map) {
    return Code(
      id: id,
      title: map['title'],
      codepath: "lib/programs/dart/" + map['file'].toString() + ".dart",
      readmepath: "lib/programs/dart/" + map['file'].toString() + ".md",
    );
  }

  @override
  String toString() {
    return 'Code(id: $id, title: $title, codepath: $codepath, readmepath: $readmepath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Code &&
        other.id == id &&
        other.title == title &&
        other.codepath == codepath &&
        other.readmepath == readmepath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        codepath.hashCode ^
        readmepath.hashCode;
  }
}
