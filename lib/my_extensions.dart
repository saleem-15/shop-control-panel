extension Average on List<int> {
  double get average {
    int sum = 0;
    for (int number in this) {
      sum += number;
    }
    return (sum / length);
  }
}
