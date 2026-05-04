import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListUserDataPage(),
    );
  }
}

class UserModel {
  int? id;
  String nama;
  int umur;

  UserModel({
    this.id,
    required this.nama,
    required this.umur,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nama: json['nama'],
      umur: json['umur'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'umur': umur,
    };
  }
}

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  static Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'user.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            umur INTEGER
          )
        ''');
      },
    );
  }

  static Future<int> insertData(UserModel user) async {
    final db = await database;
    return await db.insert('users', user.toJson());
  }

  static Future<List<UserModel>> getData() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('users');
    return result.map((e) => UserModel.fromJson(e)).toList();
  }

  static Future<int> updateData(UserModel user) async {
    final db = await database;
    final map = user.toJson();
    map.remove('id');
    return await db.update(
      'users',
      map,
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<int> deleteData(int id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}


class ListUserDataPage extends StatefulWidget {
  const ListUserDataPage({super.key});

  @override
  State<ListUserDataPage> createState() => _ListUserDataPageState();
}

class _ListUserDataPageState extends State<ListUserDataPage> {
  List<UserModel> userList = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController umurController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reloadData();
  }

  Future<void> _reloadData() async {
    final data = await DatabaseHelper.getData();
    if (mounted) {
      setState(() {
        userList = data;
      });
    }
  }

  void form({int? id, BuildContext? context}) {
    if (id != null) {
      final user = userList.firstWhere((element) => element.id == id);
      nameController.text = user.nama;
      umurController.text = user.umur.toString();
    } else {
      nameController.clear();
      umurController.clear();
    }

    showModalBottomSheet(
      context: context ?? this.context,
      isScrollControlled: true,
      builder: (BuildContext bottomSheetContext) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(bottomSheetContext).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nama"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: umurController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Umur"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final umurValue = int.tryParse(umurController.text);
                  if (umurValue != null) {
                    handleSave(
                      id: id,
                      nama: nameController.text,
                      umur: umurValue,
                      context: bottomSheetContext,
                    );
                  }
                },
                child: Text(id == null ? "Tambah" : "Perbarui"),
              ),
            ],
          ),
        );
      }, 
    );
  }

  Future<void> handleSave({
    int? id,
    required String nama,
    required int umur,
    required BuildContext context,
  }) async {
    if (id != null) {
      await DatabaseHelper.updateData(UserModel(id: id, nama: nama, umur: umur));
    } else {
      await DatabaseHelper.insertData(UserModel(nama: nama, umur: umur));
    }

    if (mounted && context.mounted) {
      Navigator.pop(context);
      await _reloadData();
    }
  }

  void delete(int id, BuildContext buildContext) {
    showDialog(
      context: buildContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Konfirmasi Hapus"),
          content: const Text("Apakah yakin ingin menghapus user ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () async {
                await DatabaseHelper.deleteData(id);
                if (mounted && dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                  await _reloadData();
                }
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Data User"),
      ),
      body: userList.isEmpty
          ? const Center(
              child: Text("Belum ada data user"),
            )
          : ListView.builder(
              itemCount: userList.length,
              itemBuilder: (BuildContext listContext, int index) {
                final user = userList[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(user.nama),
                    subtitle: Text("Umur: ${user.umur}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => form(id: user.id),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => delete(user.id!, context),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
      onPressed: () => form(),
      child: const Icon(Icons.add),
      ),
    );
  }
}