import '../models/mahasiswa.dart';

class MahasiswaHelper {
  final List<Mahasiswa> _dataMahasiswa = [];
  int _autoId = 1;

  List<Mahasiswa> getAll() {
    return _dataMahasiswa;
  }

  void add(Mahasiswa mahasiswa) {
    mahasiswa.id = _autoId++;
    _dataMahasiswa.add(mahasiswa);
  }

  void update(Mahasiswa mahasiswa) {
    int index = _dataMahasiswa.indexWhere((m) => m.id == mahasiswa.id);
    if (index != -1) {
      _dataMahasiswa[index] = mahasiswa;
    }
  }

  void delete(int id) {
    _dataMahasiswa.removeWhere((m) => m.id == id);
  }

  Mahasiswa? getById(int id) {
    try {
      return _dataMahasiswa.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }
}
