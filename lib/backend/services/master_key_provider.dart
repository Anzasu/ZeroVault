
class MasterKeyProvider {
   static String? _key;
  static String? get key => _key;
  static void setKey(String key) => _key = key;
  static void clear() => _key = null;
  
}