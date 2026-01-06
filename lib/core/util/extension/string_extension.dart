
extension StringExtensions on String {
  String capitalizeWords() {
    List<String> words = split(" ");

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] =
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }
    }

    return words.join(" ");
  }

  String shorten(int maxLength) {
    if (length <= maxLength) {
      return this;
    } else {
      return "${substring(0, maxLength)}...";
    }
  }
}