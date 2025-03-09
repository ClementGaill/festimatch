// ignore_for_file: file_names
import 'dart:math';

String generateCodeFromTimestamp() {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  String code = '';

  Random random = Random(timestamp); // Utilisation du timestamp comme seed

  for (int i = 0; i < 6; i++) {
    code += chars[random.nextInt(chars.length)];
  }

  return code;
}
