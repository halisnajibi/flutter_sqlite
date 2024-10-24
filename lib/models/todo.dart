// ignore_for_file: public_member_api_docs, sort_constructors_first

class TodoModel {
  int? id;
  String nama;
  String deskripsi;
  bool done;
  TodoModel({
    this.id,
    required this.nama,
    required this.deskripsi,
    this.done = false,
  });

  static List<TodoModel> dummyData = [
    TodoModel(nama: "todo 1", deskripsi: "dsrkispsdi 1"),
    TodoModel(nama: "todo 2", deskripsi: "dsrkispsdi 2", done: true),
    TodoModel(nama: "todo 3", deskripsi: "dsrkispsdi 3"),
    TodoModel(nama: "todo 4", deskripsi: "dsrkispsdi 4"),
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'done': done
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
        id: map['id'],
        nama: map['nama'],
        deskripsi: map['deskripsi'],
        done: map['done'] == 0 ? false : true);
  }
}
