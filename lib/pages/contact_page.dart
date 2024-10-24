import 'package:flutter/material.dart';
import 'package:sqflite_app/controller/contact_controller.dart';
import 'package:sqflite_app/models/contact.dart';
import 'package:sqflite_app/pages/widgets/drawer_navigation.dart';

import 'contact_add_page.dart';
import 'contact_detail.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final contactController = ContactController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshContacts();
  }

  Future<void> refreshContacts() async {
    // Ambil data kontak dan perbarui state
    await contactController.refreshList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contact'),
        backgroundColor: Colors.blue,
      ),
      drawer: DrawerNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ContactAddPage()));
          if (result == true) {
            refreshContacts();
          }
        },
        child: Icon(Icons.add_call),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: contactController.refreshList(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snap.hasData) {
                    List<ContactModel> data = snap.data;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final contact = data.elementAt(index);
                        return GestureDetector(
                          onTap: () async {
                            bool? result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ContactDetail(id: contact.id)));
                            if (result == true) {
                              refreshContacts();
                            }
                          },
                          child: ListTile(
                            leading: CircleAvatar(),
                            title: Text('${contact.nama}'),
                            subtitle: Text('${contact.nomor}'),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                }),
          )
        ],
      ),
    );
  }
}
