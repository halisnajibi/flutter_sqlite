import 'package:flutter/material.dart';
import 'package:sqflite_app/controller/home_contoller.dart';
import 'package:sqflite_app/pages/widgets/drawer_navigation.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final homeController = HomeContoller();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.refreshList().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todolist Sqflite"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            homeController.tampilForm(context, () {
              homeController.addItem().then((_) {
                setState(() {});
              });
            });
          },
          child: Icon(Icons.add)),
      drawer: DrawerNavigation(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: homeController.searchC,
              decoration: InputDecoration(
                hintText: 'Cari',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                homeController.cariTodo().then((_) {
                  setState(() {});
                });
              },
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: homeController.todoList.length,
            itemBuilder: (context, index) {
              final data = homeController.todoList.elementAt(index);
              return ListTile(
                title: Text('${data.nama}'),
                subtitle: Text('${data.deskripsi}'),
                leading: data.done
                    ? IconButton(
                        icon: Icon(Icons.check_circle),
                        onPressed: () {
                          homeController
                              .updateItem(index, !data.done)
                              .then((_) {
                            setState(() {});
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.radio_button_unchecked),
                        onPressed: () {
                          homeController
                              .updateItem(index, !data.done)
                              .then((_) {
                            setState(() {});
                          });
                        },
                      ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    homeController.deleteItem(data.id ?? 0).then((_) {
                      setState(() {});
                    });
                  },
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
