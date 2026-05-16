import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const _saltKey = 'pin_salt';
  static const _blobKey = 'pin_blob';

  // ---- Check if a PIN has been set ----
  Future<bool> hasPin() async {
    final salt = await _storage.read(key: _saltKey);
    final blob = await _storage.read(key: _blobKey);
    return salt != null && blob != null;
  }

  // ---- Create PIN on first setup ----
  /// Returns the master encryption key (hex) to use immediately.
  Future<String> createPin(String pin, String masterKeyHex) async {
    // 1. Generate random 16‑byte salt
    final salt = List<int>.generate(16, (_) => Random.secure().nextInt(256));

    // 2. Derive a 256‑bit key from PIN + salt
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 100000,
      bits: 256,
    );
    final pinKey = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(pin)),
      nonce: salt,
    );

    // 3. Prepare plaintext: 8‑byte verification token + 32‑byte master key
    final verificationToken = List<int>.generate(8, (_) => Random.secure().nextInt(256));
    final masterKeyBytes = hexToBytes(masterKeyHex);
    final plaintext = Uint8List.fromList([...verificationToken, ...masterKeyBytes]);

    // 4. Encrypt with AES‑GCM
    final cipher = AesGcm.with256bits(nonceLength: 12);   // create cipher
    final nonce = List<int>.generate(12, (_) => Random.secure().nextInt(256));
    final encrypted = await cipher.encrypt(
      plaintext,
      secretKey: pinKey,   // pass secretKey here
      nonce: nonce,
    );

    // 5. Store salt and blob (nonce + ciphertext + tag)
    final blob = [...encrypted.nonce, ...encrypted.cipherText, ...encrypted.mac.bytes];
    await _storage.write(key: _saltKey, value: hexEncode(salt));
    await _storage.write(key: _blobKey, value: base64Encode(Uint8List.fromList(blob)));

    return masterKeyHex;
  }

  // ---- Verify PIN and return master key ----
  Future<String?> verifyPin(String pin) async {
    final saltHex = await _storage.read(key: _saltKey);
    final blobBase64 = await _storage.read(key: _blobKey);
    if (saltHex == null || blobBase64 == null) return null;

    final salt = hexToBytes(saltHex);
    final blob = base64Decode(blobBase64);

    if (blob.length != 12 + 40 + 16) return null;
    final nonce = blob.sublist(0, 12);
    final cipherText = blob.sublist(12, 12 + 40);
    final tag = blob.sublist(12 + 40);

    // Derive key from PIN + salt
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 100000,
      bits: 256,
    );
    final pinKey = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(pin)),
      nonce: salt,
    );

    final cipher = AesGcm.with256bits(nonceLength: 12);
    try {
      final decrypted = await cipher.decrypt(
        SecretBox(cipherText, nonce: nonce, mac: Mac(tag)),
        secretKey: pinKey,   // pass secretKey here
      );
      if (decrypted.length != 40) return null;
      final masterKeyBytes = decrypted.sublist(8);
      return hexEncode(masterKeyBytes);
    } catch (_) {
      return null;
    }
  }

  // ---- Helpers ----
  static String hexEncode(List<int> bytes) =>
      bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

  static List<int> hexToBytes(String hex) {
    final result = <int>[];
    for (int i = 0; i < hex.length; i += 2) {
      result.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return result;
  }
}