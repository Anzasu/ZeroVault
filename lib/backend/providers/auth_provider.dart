import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../services/master_key_provider.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = true;
  bool _hasPin = false;
  bool _isLocked = true;

  bool get isLoading => _isLoading;
  bool get hasPin => _hasPin;
  bool get isLocked => _isLocked;

  Future<void> initialize() async {
    _hasPin = await _authService.hasPin();
    _isLocked = _hasPin; // start locked if PIN exists
    _isLoading = false;
    notifyListeners();
  }

  void unlock() {
    _isLocked = false;
    notifyListeners();
  }

  void lock() {
    MasterKeyProvider.clear();
    _isLocked = true;
    notifyListeners();
  }

  void pinCreated() {
    _hasPin = true;
    _isLocked = false;
    notifyListeners();
  }
}