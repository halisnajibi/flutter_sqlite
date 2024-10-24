import 'package:flutter/material.dart';
import 'package:sqflite_app/controller/contact_controller.dart';

import 'contact_edit.dart';

class ContactDetail extends StatefulWidget {
  final id;
  ContactDetail({super.key, required this.id});

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  late int id;
  ContactController contactController = ContactController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;
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
        title: Text("Contact"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: FutureBuilder(
                  future: contactController.getBYID(id),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snap.hasData) {
                      final data = snap.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(),
                          Text("${data!.nama}"),
                          Text("${data.nomor}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    bool? result = await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ContactEdit(
                                                  contact: data,
                                                )));
                                    if (result == true) {
                                      refreshContacts();
                                    }
                                  },
                                  child: Icon(Icons.edit)),
                              ElevatedButton(
                                  onPressed: () {
                                    contactController.deleteItem(id).then((_) {
                                      Navigator.pop(context, true);
                                    });
                                  },
                                  child: Icon(Icons.delete))
                            ],
                          )
                        ],
                      );
                    }
                    return Container();
                  }),
            ),
          )),
    );
  }
}
