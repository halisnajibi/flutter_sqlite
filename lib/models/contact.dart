// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContactModel {
  int? id;
  String nama;
  String nomor;
  ContactModel({
    this.id,
    required this.nama,
    required this.nomor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'nomor': nomor,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(id: map['id'], nama: map['nama'], nomor: map['nomor']);
  }
}
