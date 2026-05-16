

import 'package:zero_vault/backend/services/db_helper.dart';
import 'package:zero_vault/backend/services/encryp_service.dart';

class VaultRepo {
  final EncryptionService _encryption;

  VaultRepo(this._encryption);

  // **************** OPerators for credentials ****************

  Future<List<Map<String, dynamic>>> getAllCredentials({
    String? searchQuery,
    String sortBy = 'title ASC',
  })async{
    final db = await DBHelper.database;
    String? where;
    List<dynamic> args = [];
    if (searchQuery != null && searchQuery.isNotEmpty){
      where = 'WHERE title LIKE ? OR username_or_email LIKE ?';
      args = ['%$searchQuery%', '%$searchQuery%'];
    }
    final result = await db.rawQuery(
      'SELECT * FROM credentials ${where ?? ''} ORDER BY $sortBy',
      args,
    );
    return result.map((row){
      final decryptedPassword = _encryption.decrypt(row['encrypted_password'] as String);
      final decryptedNotes = row['encrypted_notes'] != null 
      ? _encryption.decrypt(row['encrypted_notes'] as String)
      : null;
      return {
        ...row,
        'password': decryptedPassword,
        'notes': decryptedNotes,
      };
    }).toList();
  }

  Future<int> insertCredential({
    required String title,
    required String usernameOrEmail,
    required String password,
    String? notes,
  }) async {
    final db = await DBHelper.database;
    final timeNow = DateTime.now().toIso8601String();
    return db.insert('credentials', {
      'title': title,
      'username_or_email': usernameOrEmail,
      'encrypted_password': _encryption.encrypt(password),
      'encrypted_notes': notes != null ? _encryption.encrypt(notes) : null,
      'created_at': timeNow,
      'updated_at': timeNow

    });
  }

  Future<void> updateCredential (int id, {
    String? title,
    String? usernameOrEmail,
    String? password,
    String? notes,
  }) async {
    final db = await DBHelper.database;
    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };
    
    if(title != null) updates['title'] = title;
    if(usernameOrEmail != null) updates['username_or_email'] = usernameOrEmail;
    if(password != null) updates['encrypted_password'] = _encryption.encrypt(password);
    if (notes != null) {
      updates['encrypted_notes'] = _encryption.encrypt(notes);
    } else {
      updates['encrypted_notes'] = null;   // <-- explicitly clear the column
    }    
    
    await db.update('credentials', updates, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteCredential(int id) async{
    final db = await DBHelper.database;
    await db.delete('credentials', where: 'id = ?', whereArgs: [id]);
  }

  // **************** OPerators for subscriptions ****************

  Future<List<Map<String, dynamic>>> getAllSubscriptions({
    String? searchQuery,
    String sortBy = 'newsletter_name ASC',
  }) async {
    final db = await DBHelper.database;
    String? where;
    List<dynamic> args = [];
    if (searchQuery != null && searchQuery.isNotEmpty) {
      where = 'WHERE newsletter_name LIKE ? OR email LIKE ?';
      args = ['%$searchQuery%', '%$searchQuery%'];
    }
    return db.rawQuery(
      'SELECT * FROM subscriptions ${where ?? ''} ORDER BY $sortBy',
      args,
    );
  }

  Future<int> insertSubscription({
    required String newsletterName,
    required String email,
    String? frequency,
  }) async {
    final db = await DBHelper.database;
    final now = DateTime.now().toIso8601String();
    return db.insert('subscriptions', {
      'newsletter_name': newsletterName,
      'email': email,
      'frequency': frequency,
      'created_at': now,
      'updated_at': now,
    });
  }

  Future<void> updateSubscription(int id, {
    String? newsletterName,
    String? email,
    String? frequency,
  }) async {
    final db = await DBHelper.database;
    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };
    if (newsletterName != null) updates['newsletter_name'] = newsletterName;
    if (email != null) updates['email'] = email;
    if (frequency != null) updates['frequency'] = frequency;
    await db.update('subscriptions', updates, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteSubscription(int id) async {
    final db = await DBHelper.database;
    await db.delete('subscriptions', where: 'id = ?', whereArgs: [id]);
  }
}