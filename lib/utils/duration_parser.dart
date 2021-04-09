String durationToMinutesSeconds(String _duration) {
  String data;
  Duration duration = Duration(milliseconds: int.parse(_duration));

  int minutes = duration.inMinutes;
  int seconds = (duration.inSeconds) - (minutes * 60);

  data = minutes.toString() + ":";
  if (seconds <= 9) data += "0";

  data += seconds.toString();
  return data;
}
