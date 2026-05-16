import 'package:flutter/foundation.dart';
import 'package:zero_vault/backend/repositories/vault_repo.dart';
import 'package:zero_vault/backend/services/encryp_service.dart';
import 'package:zero_vault/backend/services/master_key_provider.dart';

class VaultProvider extends ChangeNotifier {
  late VaultRepo _repository;

  List<Map<String, dynamic>> _credentials = [];
  List<Map<String, dynamic>> _subscriptions = [];

  List<Map<String, dynamic>> get credentials => _credentials;
  List<Map<String, dynamic>> get subscriptions => _subscriptions;

  String _searchQuery = '';
  String _credentialSort = 'title ASC';
  String _subscriptionSort = 'newsletter_name ASC';

  // ---- Initialization ------------------------------------------------
  Future<void> init() async {
    final masterKey = await MasterKeyProvider.key;
    _repository = VaultRepo(EncryptionService(masterKey));
    await refresh();
  }

  // ---- Refresh all lists from DB ------------------------------------
  Future<void> refresh() async {
    _credentials = await _repository.getAllCredentials(
      searchQuery: _searchQuery.isNotEmpty ? _searchQuery : null,
      sortBy: _credentialSort,
    );
    _subscriptions = await _repository.getAllSubscriptions(
      searchQuery: _searchQuery.isNotEmpty ? _searchQuery : null,
      sortBy: _subscriptionSort,
    );
    notifyListeners();
  }

  // ---- Search & Sort ------------------------------------------------
  void setSearch(String query) {
    _searchQuery = query;
    refresh();
  }

  void setCredentialSort(String sort) {
    _credentialSort = sort;
    refresh();
  }

  void setSubscriptionSort(String sort) {
    _subscriptionSort = sort;
    refresh();
  }

  // ---- Credentials CRUD ---------------------------------------------
  Future<void> addCredential({
    required String title,
    required String usernameOrEmail,
    required String password,
    String? notes,
  }) async {
    await _repository.insertCredential(
      title: title,
      usernameOrEmail: usernameOrEmail,
      password: password,
      notes: notes,
    );
    await refresh();
  }

  Future<void> updateCredential(int id, {
    String? title,
    String? usernameOrEmail,
    String? password,
    String? notes,
  }) async {
    await _repository.updateCredential(id,
      title: title,
      usernameOrEmail: usernameOrEmail,
      password: password,
      notes: notes,
      
    );
    await refresh();
  }

  Future<void> deleteCredential(int id) async {
    await _repository.deleteCredential(id);
    await refresh();
  }

  // ---- SUbscriptions CRUD -------------------------------------------
  Future<void> addSubscription({
    required String newsletterName,
    required String email,
    String? frequency,
  }) async {
    await _repository.insertSubscription(
      newsletterName: newsletterName,
      email: email,
      frequency: frequency,
    );
    await refresh();
  }

  Future<void> updateSubscription(int id, {
    String? newsletterName,
    String? email,
    String? frequency,
  }) async {
    await _repository.updateSubscription(id,
      newsletterName: newsletterName,
      email: email,
      frequency: frequency,
    );
    await refresh();
  }

  Future<void> deleteSubscription(int id) async {
    await _repository.deleteSubscription(id);
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