import 'package:dartz/dartz.dart';
import 'package:localstorage/localstorage.dart';

abstract class KeyValueStorage {
  Future<Option<dynamic>> load(String key);

  Future<void> save(String key, value);
}

class LocalStorageImpl implements KeyValueStorage {
  static final filename = 'local_storage.json';

  @override
  Future<Option<dynamic>> load(String key) async {
    var _localStorage = await _prepareLocalStorage();
    return _localStorage
        .map((storage) => storage.getItem(key))
        .where((item) => item != null);
  }

  @override
  Future<void> save(String key, data) async {
    var _localStorage = await _prepareLocalStorage();
    _localStorage.forEach((storage) => storage.setItem(key, data));
  }

  Future<Option<LocalStorage>> _prepareLocalStorage() async {
    var localStorage = new LocalStorage(filename);

    final storageReady = await localStorage.ready;

    if (storageReady == false) return None();

    return Some(localStorage);
  }
}
