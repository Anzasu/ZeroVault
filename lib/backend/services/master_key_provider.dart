import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zero_vault/backend/services/encryp_service.dart';

class MasterKeyProvider {
  static const _storage = FlutterSecureStorage();
  static const _keyName = 'master_key';
  static String? _key;

  static Future<String> get key async {
    if (_key != null) return _key!;

    // Try to load existing key
    _key = await _storage.read(key: _keyName);
    if (_key == null) {
      // First launch – generate and save
      _key = EncryptionService.generateMasterKey();
      await _storage.write(key: _keyName, value: _key!);
    }
    return _key!;
  }

  // Used later when PIN changes
  static Future<void> setKey(String newKey) async {
    _key = newKey;
    await _storage.write(key: _keyName, value: newKey);
  }

  // For debugging/reset (optional)
  static Future<void> reset() async {
    _key = null;
    await _storage.delete(key: _keyName);
  }
}