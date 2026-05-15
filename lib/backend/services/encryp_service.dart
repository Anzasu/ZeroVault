import 'dart:math';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as enc; 

class EncryptionService {
  late final enc.Key _key;
  late final enc.Encrypter _encrypter;

  EncryptionService(String masterKeyHex) {
    _key = enc.Key(Uint8List.fromList(hexToBytes(masterKeyHex)));
    _encrypter = enc.Encrypter(enc.AES(_key));
  }

  // --- encrypt ---
  String encrypt(String plainText) {
    final iv = enc.IV.fromSecureRandom(16);         // enc.IV
    final encrypted = _encrypter.encrypt(plainText, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  // --- decrypt ---
  String decrypt(String encryptedData) {
    final parts = encryptedData.split(':');
    if (parts.length != 2) throw FormatException('Invalid encrypted data');
    final iv = enc.IV.fromBase64(parts[0]);         // enc.IV
    final cipherText = enc.Encrypted.fromBase64(parts[1]);
    return _encrypter.decrypt(cipherText, iv: iv);
  }

  // --- helpers ---
  static String generateMasterKey() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return hexEncode(bytes);
  }

  static List<int> hexToBytes(String hex) {
    final result = <int>[];
    for (int i = 0; i < hex.length; i += 2) {
      result.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return result;
  }

  static String hexEncode(List<int> bytes) =>
      bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}