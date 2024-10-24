import 'package:flutter/material.dart';
import 'package:sqflite_app/controller/contact_controller.dart';
import 'package:sqflite_app/models/contact.dart';

class ContactEdit extends StatefulWidget {
  final ContactModel contact;
  ContactEdit({super.key, required this.contact});

  @override
  State<ContactEdit> createState() => _ContactEditState();
}

class _ContactEditState extends State<ContactEdit> {
  late ContactModel contact;
  ContactController contactController = ContactController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contact = widget.contact;
    contactController.namaC.text = contact.nama;
    contactController.nomorC.text = contact.nomor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact edit"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: contactController.namaC,
              decoration: InputDecoration(
                  hintText: 'Nama',
                  labelText: 'Nama',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: contactController.nomorC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Nomor',
                  labelText: 'Nomor',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () => contactController.updateItem(contact.id!).then((_) {
                Navigator.pop(context, true);
              }),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
                child: Center(
                    child: Text(
                  'Simpan',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
