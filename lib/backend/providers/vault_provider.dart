import 'package:flutter/foundation.dart';
import 'package:zero_vault/backend/repositories/vault_repo.dart';
import 'package:zero_vault/backend/services/encryp_service.dart';
import 'package:zero_vault/backend/services/master_key_provider.dart';

class VaultProvider extends ChangeNotifier {
  VaultRepo? _repository;
  bool _isInitialised = false;

  List<Map<String, dynamic>> _credentials = [];
  List<Map<String, dynamic>> _subscriptions = [];

  List<Map<String, dynamic>> get credentials => _credentials;
  List<Map<String, dynamic>> get subscriptions => _subscriptions;

  String _credentialSearch = '';
  String _subscriptionSearch = '';
  String _credentialSort = 'title ASC';
  String _subscriptionSort = 'newsletter_name ASC';

  // ---- Initialisation (called after unlock) ----
  Future<void> init(String masterKeyHex) async {
    if (_isInitialised) return;
    _repository = VaultRepo(EncryptionService(masterKeyHex));
    await _loadAll();
    _isInitialised = true;
    notifyListeners();
  }

  Future<void> _loadAll() async {
    if (_repository == null) return;
    _credentials = await _repository!.getAllCredentials(
      searchQuery: _credentialSearch.isNotEmpty ? _credentialSearch : null,
      sortBy: _credentialSort,
    );
    _subscriptions = await _repository!.getAllSubscriptions(
      searchQuery: _subscriptionSearch.isNotEmpty ? _subscriptionSearch : null,
      sortBy: _subscriptionSort,
    );
    notifyListeners();
  }

  // ---- Refresh (called after changes) ----
  Future<void> refresh() => _loadAll();

  // ---- Search / Sort ----
  void setCredentialSearch(String q) { _credentialSearch = q; _loadAll(); }
  void setSubscriptionSearch(String q) { _subscriptionSearch = q; _loadAll(); }
  // ... other sort methods ...

 

  // ---- Credentials CRUD ---------------------------------------------
  Future<void> addCredential(
    {required String title, 
    required String usernameOrEmail, 
    required String password, 
    String? notes}) async {
    if (_repository == null) return;
    await _repository!.insertCredential(title: title, usernameOrEmail: usernameOrEmail, password: password, notes: notes);
    await refresh();
  }

  Future<void> updateCredential(int id, {
    required String title,
    required String usernameOrEmail,
    required String password,
    String? notes,
  }) async {
        if (_repository == null) return;

    await _repository!.updateCredential(id,
      title: title,
      usernameOrEmail: usernameOrEmail,
      password: password,
      notes: notes,
      
    );
    await refresh();
  }

  Future<void> deleteCredential({required int id}) async {
        if (_repository == null) return;

    await _repository!.deleteCredential(id);
    await refresh();
  }

  // ---- SUbscriptions CRUD -------------------------------------------
  Future<void> addSubscription({
    required String newsletterName,
    required String email,
    String? frequency,
  }) async {
    await _repository!.insertSubscription(
      newsletterName: newsletterName,
      email: email,
      frequency: frequency,
    );
    await refresh();
  }

  Future<void> updateSubscription(int id, {
    required String newsletterName,
    required String email,
    String? frequency,
  }) async {
    await _repository!.updateSubscription(id,
      newsletterName: newsletterName,
      email: email,
      frequency: frequency,
    );
    await refresh();
  }

  Future<void> deleteSubscription({required int id}) async {
    await _repository!.deleteSubscription(id);
    await refresh();
  }

Map<String, dynamic>? getCredentialById(int id) {
  try {
    return _credentials.firstWhere((c) => c['id'] == id);
  } catch (_) {
    return null;
  }
}

Map<String, dynamic>? getSubscriptionById(int id) {
  try {
    return _subscriptions.firstWhere((c) => c['id'] == id);
  } catch (_) {
    return null;
  }
}

}