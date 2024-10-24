import 'package:flutter/material.dart';
import 'package:sqflite_app/controller/contact_controller.dart';

class ContactAddPage extends StatefulWidget {
  const ContactAddPage({super.key});

  @override
  State<ContactAddPage> createState() => _ContactAddPageState();
}

class _ContactAddPageState extends State<ContactAddPage> {
  final controllerContact = ContactController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: controllerContact.namaC,
              decoration: InputDecoration(
                  hintText: 'Nama',
                  labelText: 'Nama',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: controllerContact.nomorC,
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
              onTap: () => controllerContact.addItem().then((_) {
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
