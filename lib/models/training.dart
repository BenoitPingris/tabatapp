import 'package:tabatapp/utils/id.dart';

// (prepare + (nbSeries * timeSerie) + (rest * nbSeries - 1)) * nbCycle

class Training {
  final String name;
  final int prepare;
  final int nbSeries;
  final int timeSerie;
  final int nbCycle;
  final int rest;
  final String id;

  Training(
      {this.name,
      this.prepare,
      this.nbSeries,
      this.timeSerie,
      this.nbCycle,
      this.rest})
      : id = getRandomString(10);

  String totalDuration() {
    final Duration duration = Duration(
        seconds: prepare +
            (nbSeries * timeSerie * nbCycle) +
            (rest * (nbSeries - 1) * nbCycle) +
            rest * 2 * (nbCycle - 1));
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
