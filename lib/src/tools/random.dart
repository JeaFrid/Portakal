import 'dart:math';

class PortakalRandom {
  static String randomWithTime() {
    var day = DateTime.now().day;
    var month = DateTime.now().month;
    var year = DateTime.now().year;
    var hour = DateTime.now().hour;
    var minute = DateTime.now().minute;
    var second = DateTime.now().second;
    var millisecond = DateTime.now().millisecond;

    return "$day$month$year$hour$minute$second$millisecond";
  }

  ///Generate a random String value.
  static String string(int length, {bool includeUppercase = false}) {
    final List abc = [
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
      "k",
      "l",
      "m",
      "n",
      "o",
      "p",
      "r",
      "s",
      "t",
      "u",
      "v",
      "y",
      "x",
      "w",
      "z",
    ];
    String result = "";
    for (var i = 0; i < length; i++) {
      result = result + abc[Random().nextInt(abc.length)];
    }
    if (includeUppercase) {
      result = result.toUpperCase();
    }
    return result;
  }

  ///Generate a random Integer value.
  static int integer(int length) {
    if (length <= 0) return 0;
    if (length == 1) return Random().nextInt(10);

    int min = pow(10, length - 1).toInt();
    int max = pow(10, length).toInt();

    return min + Random().nextInt(max - min);
  }

  ///Generate a random Email value.
  static String email({String? domain}) {
    return "${string(15)}${domain ?? "@gmail.com"}";
  }

  ///Generate a random Password value.
  static String password() {
    String x = string(3, includeUppercase: true);
    String x1 = string(2, includeUppercase: true);
    String x2 = string(1, includeUppercase: true);
    String x3 = string(3, includeUppercase: true);
    String x4 = string(2, includeUppercase: true);
    int x5 = integer(2);
    int x6 = integer(3);
    int x7 = integer(1);
    int x8 = integer(2);

    List<Object> parts = [x, x1, x2, x3, x4, x5, x6, x7, x8];
    parts.shuffle();

    return parts.join('');
  }
}
