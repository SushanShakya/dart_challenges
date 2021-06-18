class Isogram {
  bool isIsogram(String s) {
    List<String> seen = [];
    bool isIsogram = true;
    s.split("").forEach((element) {
      if (element == " " || element == "-") {
      } else {
        if (seen.contains(element)) {
          isIsogram = false;
        } else {
          seen.add(element);
        }
      }
    });

    return isIsogram;
  }
}
