// lib/utils/performance_utils.dart
class PerformanceUtils {
  static String formatDuration(Duration duration) {
    return '${duration.inMilliseconds}ms';
  }

  static double calculateAverage(List<Duration> durations) {
    return durations.map((d) => d.inMilliseconds).reduce((a, b) => a + b) /
        durations.length;
  }
}