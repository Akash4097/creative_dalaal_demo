import 'dart:math';

class UniqueId {
  static String generateUniqueId() {
    final random = Random();
    return '${DateTime.now().millisecondsSinceEpoch}-${random.nextInt(100000)}';
  }
}
