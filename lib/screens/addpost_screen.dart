import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/utils/color.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/models/user.dart' as model;

class AddpostScreen extends StatefulWidget {
  const AddpostScreen({super.key});

  @override
  State<AddpostScreen> createState() => _AddpostScreenState();
}

class _AddpostScreenState extends State<AddpostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a Post"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take a photo"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Choose from gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final model.User? user = userProvider.getUser;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return _file == null
        ? Center(
          child: IconButton(
            onPressed: () => _selectImage(context),
            icon: Icon(Icons.upload),
          ),
        )
        : Scaffold(
          appBar: AppBar(
            backgroundColor: mobileBackgroundColor,
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
            title: const Text('Post to'),
            centerTitle: false,
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(user.photoUrl)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Write a caption...',
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: AspectRatio(
                      aspectRatio: 457 / 451,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topLeft,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ],
          ),
        );
  }
}
