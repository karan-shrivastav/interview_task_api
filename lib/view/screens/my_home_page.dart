import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:interview_task_api/widgets/common_text_field.dart';
import 'package:interview_task_api/widgets/gradient_button.dart';
import 'package:provider/provider.dart';
import '../../localDatabase/services/todo_functions.dart';
import '../../localDatabase/widgets/add_task_widget.dart';
import '../../models/sql_model.dart';
import '../../providers/task_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/add_user_popup.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isConnected = false;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late Connectivity _connectivity;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    fetchTodos();
    _connectivity = Connectivity();
    _checkConnection();
    context.read<UserProvider>().getAllUsers();
    context.read<TaskProvider>().getAllTasks();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result;
      });
    });
    super.initState();
  }

  Future<void> _checkConnection() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    setState(() {
      _connectionStatus = result;
    });
  }

  Future<List<SQLModel>>? futureTodos;

  final todoDB = TodoFunctions();

  void fetchTodos() {
    setState(() {
      futureTodos = todoDB.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final tasks = taskProvider.tasks;
    if (_connectionStatus == ConnectivityResult.none) {
      isConnected = false;
      print('Not connected');
    } else {
      isConnected = true;
      print('Connected');
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isConnected) {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext ctx) {
                return const AddUserPopup(
                  userId: 1,
                );
              },
            );
          } else {
            _createLocalData();
          }
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Tasks Screen'),
        backgroundColor: Colors.blue,
      ),
      body: isConnected
          ? tasks.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(tasks[index].title ?? ''),
                        subtitle: Text('${tasks[index].id ?? 0}'),
                        trailing: SizedBox(
                          width: 50,
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    context
                                        .read<TaskProvider>()
                                        .deleteData(tasks[index].id ?? 0);
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<SQLModel>>(
              future: futureTodos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData && snapshot.data != null) {
                    final todos = snapshot.data!;
                    return todos.isEmpty
                        ? const Center(
                            child: Text(
                              'No tasks available.',
                            ),
                          )
                        : ListView.builder(
                            itemCount: todos.length,
                            itemBuilder: (context, index) {
                              final todo = todos[index];
                              return Slidable(
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        _updateLocalData(
                                          todo.id ?? 0,
                                          todo.name,
                                          todo.mobile,
                                          todo.createdAt,
                                        );
                                      },
                                      backgroundColor: const Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: 'Edit',
                                    ),
                                  ],
                                ),
                                child: Card(
                                  child: ListTile(
                                    title: Text(
                                      todo.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          todo.mobile ?? '',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          todo.createdAt ?? '',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: InkWell(
                                      onTap: () async {
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              title: const TextWidget(
                                                title: "Delete Task",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              content: const TextWidget(
                                                title:
                                                    "Are you sure you want to delete this task?",
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const TextWidget(
                                                    title: 'Delete',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () async {
                                                    await todoDB
                                                        .delete(todo.id ?? 0);
                                                    fetchTodos();
                                                    setState(() {});
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                              );
                            },
                          );
                  } else {
                    return const Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                }
              },
            ),
    );
  }

  Future<void> _updateLocalData(
      int id, String? title, String? description, String? email) async {
    _nameController.text = title ?? '';
    _mobileController.text = description ?? '';
    _emailController.text = email ?? '';
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 30,
                bottom: 50,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextField(
                    controller: _nameController,
                    hintText: 'Name',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CommonTextField(
                    maxLength: 10,
                    textInputType: TextInputType.number,
                    controller: _mobileController,
                    hintText: 'Mobile',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CommonTextField(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const ButtonWidget(
                            titleColor: Color(0xFF7c7a95),
                            color: Color(0xFFefeff9),
                            title: "Cancel",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          final String name = _nameController.text;
                          final String mobile = _mobileController.text;
                          final String email = _emailController.text;
                          todoDB.update(
                              id: id, name: name, mobile: mobile, email: email);
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                        child: const GradientButton(
                          height: 40,
                          title: "Update",
                        ),
                      )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _createLocalData() async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return AddTaskLocal(
            onSubmit: (Map<String, String> data) async {
              final name = data['title'];
              final mobile = data['description'];
              final email = data['created_at'];
              await todoDB.create(
                name: name ?? '',
                mobile: mobile ?? '',
                email: email ?? '',
              );
              if (!mounted) return;
              fetchTodos();
              Navigator.of(context).pop();
            },
          );
        });
  }
}
