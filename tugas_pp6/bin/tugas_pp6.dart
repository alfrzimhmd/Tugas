import 'dart:io';

// MODEL
class Mahasiswa {
  int id;
  String nama;
  String jurusan;
  int angkatan;

  Mahasiswa({
    required this.id,
    required this.nama,
    required this.jurusan,
    required this.angkatan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'jurusan': jurusan,
      'angkatan': angkatan,
    };
  }

  factory Mahasiswa.fromMap(Map<String, dynamic> map) {
    return Mahasiswa(
      id: map['id'],
      nama: map['nama'],
      jurusan: map['jurusan'],
      angkatan: map['angkatan'],
    );
  }
}

// DATABASE SIMULASI
List<Map<String, dynamic>> database = [];

// CRUD FUNCTIONS
// TAMBAH
void tambahMahasiswa() {
  print("\n=== Tambah Mahasiswa ===");

  stdout.write("ID: ");
  int id = int.parse(stdin.readLineSync()!);

  stdout.write("Nama: ");
  String nama = stdin.readLineSync()!;

  stdout.write("Jurusan: ");
  String jurusan = stdin.readLineSync()!;

  stdout.write("Angkatan: ");
  int angkatan = int.parse(stdin.readLineSync()!);

  Mahasiswa mhs = Mahasiswa(
    id: id,
    nama: nama,
    jurusan: jurusan,
    angkatan: angkatan,
  );

  database.add(mhs.toMap());

  print("Data berhasil ditambahkan");
}

// TAMPILKAN
void tampilkanMahasiswa() {
  print("\n=== Data Mahasiswa ===");

  if (database.isEmpty) {
    print("Data kosong");
    return;
  }

  for (var data in database) {
    Mahasiswa mhs = Mahasiswa.fromMap(data);
    print(
        "ID: ${mhs.id} | Nama: ${mhs.nama} | Jurusan: ${mhs.jurusan} | Angkatan: ${mhs.angkatan}");
  }
}

// UPDATE
void updateMahasiswa() {
  print("\n=== Update Mahasiswa ===");

  stdout.write("Masukkan ID yang akan diupdate: ");
  int id = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < database.length; i++) {
    if (database[i]['id'] == id) {
      stdout.write("Nama baru: ");
      String nama = stdin.readLineSync()!;

      stdout.write("Jurusan baru: ");
      String jurusan = stdin.readLineSync()!;

      stdout.write("Angkatan baru: ");
      int angkatan = int.parse(stdin.readLineSync()!);

      Mahasiswa newData = Mahasiswa(
        id: id,
        nama: nama,
        jurusan: jurusan,
        angkatan: angkatan,
      );

      database[i] = newData.toMap();

      print("Data berhasil diupdate");
      return;
    }
  }

  print("ID tidak ditemukan");
}

// DELETE
void hapusMahasiswa() {
  print("\n=== Hapus Mahasiswa ===");

  stdout.write("Masukkan ID yang akan dihapus: ");
  int id = int.parse(stdin.readLineSync()!);

  database.removeWhere((data) => data['id'] == id);

  print("Data berhasil dihapus");
}

// MENU
void main() {
  while (true) {
    print("\n===== MENU MAHASISWA =====");
    print("1. Tambah Mahasiswa");
    print("2. Tampilkan Semua");
    print("3. Update Mahasiswa");
    print("4. Hapus Mahasiswa");
    print("5. Keluar");
    stdout.write("Pilih menu: ");

    String? pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1':
        tambahMahasiswa();
        break;
      case '2':
        tampilkanMahasiswa();
        break;
      case '3':
        updateMahasiswa();
        break;
      case '4':
        hapusMahasiswa();
        break;
      case '5':
        print("Program selesai");
        return;
      default:
        print("Pilihan tidak valid");
    }
  }
}