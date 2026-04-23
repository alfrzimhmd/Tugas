import 'package:flutter/material.dart';

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
}

class ListUserDataPage extends StatefulWidget {
  const ListUserDataPage({super.key});

  @override
  State<ListUserDataPage> createState() => _ListUserDataPageState();
}

class _ListUserDataPageState extends State<ListUserDataPage> {

  List<UserModel> userList = [
    UserModel(id: 1, nama: "satu", umur: 10),
    UserModel(id: 2, nama: "dua", umur: 11),
    UserModel(id: 3, nama: "tiga", umur: 12),
    UserModel(id: 4, nama: "empat", umur: 13),
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController umurController = TextEditingController();

  void form({int? id}) {
    if (id != null) {
      final user = userList.firstWhere((element) => element.id == id);
      nameController.text = user.nama;
      umurController.text = user.umur.toString();
    } else {
      nameController.clear();
      umurController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nama",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: umurController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Umur",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  handleSave(
                    id: id,
                    nama: nameController.text,
                    umur: int.parse(umurController.text),
                  );
                },
                child: Text(id == null ? "Tambah" : "Perbarui"),
              )
            ],
          ),
        );
      },
    );
  }

  void handleSave({
    int? id,
    required String nama,
    required int umur,
  }) {
    if (id != null) {
      final user = userList.firstWhere((element) => element.id == id);

      setState(() {
        user.nama = nama;
        user.umur = umur;
      });
    } else {
      final nextId = userList.length + 1;

      final newUser = UserModel(
        id: nextId,
        nama: nama,
        umur: umur,
      );

      setState(() {
        userList.add(newUser);
      });
    }

    Navigator.pop(context);
  }

  void delete(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konfirmasi Hapus"),
          content: const Text("Apakah anda yakin ingin menghapus user ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  userList.removeWhere((element) => element.id == id);
                });
                Navigator.pop(context);
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
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
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
                    onPressed: () => delete(user.id!),
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