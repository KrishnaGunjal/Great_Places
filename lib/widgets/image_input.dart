import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

class ImageInput extends StatefulWidget {
  // Function onSelectImage;
  // ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var _storedImage;
  final _titleController = TextEditingController();

  Future<void> _takePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final tempImage = File(image.path);
      setState(() => _storedImage = tempImage);

      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(image.path);
      // final savedImage = await image.saveTo('${appDir.path}/${fileName}');

      //add provider here
      // widget.onSelectImage = () => savedImage;
      if (_titleController.text.isEmpty || _storedImage == null) {
        return;
      }
      Provider.of<GreatPlaces>(context, listen: false)
          .addPlace(_titleController.text, _storedImage!);
    } on PlatformException catch (e) {
      print('Failed to pick image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Container(
              width: 100,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: _storedImage != null
                  ? Column(
                      children: [
                        Image.file(
                          _storedImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Text(
                          'No Image Taken',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
              alignment: Alignment.center,
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
