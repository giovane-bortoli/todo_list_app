import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/core/errors/exceptions.dart';

/// Gerenciador de cache customizado que encapsula operações do SharedPreferences
/// Fornece métodos type-safe e tratamento de erros consistente
/// Reduz duplicação de código nas implementações de DataSource
class CacheManager {
  final SharedPreferences _preferences;

  CacheManager(this._preferences);

  /// Salva uma string no cache
  Future<void> saveString(String key, String value) async {
    try {
      final success = await _preferences.setString(key, value);
      if (!success) {
        throw CacheException(message: 'Falha ao salvar dados com chave: $key');
      }
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(message: 'Erro ao salvar string: ${e.toString()}');
    }
  }

  /// Recupera uma string do cache
  String? getString(String key) {
    try {
      return _preferences.getString(key);
    } catch (e) {
      throw CacheException(message: 'Erro ao recuperar string: ${e.toString()}');
    }
  }

  /// Salva um objeto (converte para JSON automaticamente)
  Future<void> saveObject<T>(String key, T object, Map<String, dynamic> Function(T) toMap) async {
    try {
      final map = toMap(object);
      final jsonString = json.encode(map);
      await saveString(key, jsonString);
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(message: 'Erro ao salvar objeto: ${e.toString()}');
    }
  }

  /// Recupera um objeto (converte de JSON automaticamente)
  T? getObject<T>(String key, T Function(Map<String, dynamic>) fromMap) {
    try {
      final jsonString = getString(key);
      if (jsonString == null || jsonString.isEmpty) {
        return null;
      }

      final map = json.decode(jsonString) as Map<String, dynamic>;
      return fromMap(map);
    } catch (e) {
      throw CacheException(message: 'Erro ao recuperar objeto: ${e.toString()}');
    }
  }

  /// Salva uma lista de objetos (converte para JSON automaticamente)
  Future<void> saveList<T>(String key, List<T> list, Map<String, dynamic> Function(T) toMap) async {
    try {
      final listOfMaps = list.map((item) => toMap(item)).toList();
      final jsonString = json.encode(listOfMaps);
      await saveString(key, jsonString);
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(message: 'Erro ao salvar lista: ${e.toString()}');
    }
  }

  /// Recupera uma lista de objetos (converte de JSON automaticamente)
  List<T> getList<T>(String key, T Function(Map<String, dynamic>) fromMap) {
    try {
      final jsonString = getString(key);
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => fromMap(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw CacheException(message: 'Erro ao recuperar lista: ${e.toString()}');
    }
  }

  /// Remove um item do cache
  Future<void> remove(String key) async {
    try {
      final success = await _preferences.remove(key);
      if (!success) {
        throw CacheException(message: 'Falha ao remover dados com chave: $key');
      }
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(message: 'Erro ao remover item: ${e.toString()}');
    }
  }

  /// Limpa todo o cache
  Future<void> clear() async {
    try {
      final success = await _preferences.clear();
      if (!success) {
        throw CacheException(message: 'Falha ao limpar cache');
      }
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(message: 'Erro ao limpar cache: ${e.toString()}');
    }
  }

  /// Verifica se existe uma chave no cache
  bool containsKey(String key) {
    try {
      return _preferences.containsKey(key);
    } catch (e) {
      throw CacheException(message: 'Erro ao verificar chave: ${e.toString()}');
    }
  }

  /// Salva um valor booleano
  Future<void> saveBool(String key, bool value) async {
    try {
      final success = await _preferences.setBool(key, value);
      if (!success) {
        throw CacheException(message: 'Falha ao salvar booleano com chave: $key');
      }
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(message: 'Erro ao salvar booleano: ${e.toString()}');
    }
  }

  /// Recupera um valor booleano
  bool? getBool(String key) {
    try {
      return _preferences.getBool(key);
    } catch (e) {
      throw CacheException(message: 'Erro ao recuperar booleano: ${e.toString()}');
    }
  }

  /// Salva um valor inteiro
  Future<void> saveInt(String key, int value) async {
    try {
      final success = await _preferences.setInt(key, value);
      if (!success) {
        throw CacheException(message: 'Falha ao salvar inteiro com chave: $key');
      }
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(message: 'Erro ao salvar inteiro: ${e.toString()}');
    }
  }

  /// Recupera um valor inteiro
  int? getInt(String key) {
    try {
      return _preferences.getInt(key);
    } catch (e) {
      throw CacheException(message: 'Erro ao recuperar inteiro: ${e.toString()}');
    }
  }

  /// Salva um valor double
  Future<void> saveDouble(String key, double value) async {
    try {
      final success = await _preferences.setDouble(key, value);
      if (!success) {
        throw CacheException(message: 'Falha ao salvar double com chave: $key');
      }
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(message: 'Erro ao salvar double: ${e.toString()}');
    }
  }

  /// Recupera um valor double
  double? getDouble(String key) {
    try {
      return _preferences.getDouble(key);
    } catch (e) {
      throw CacheException(message: 'Erro ao recuperar double: ${e.toString()}');
    }
  }
}
