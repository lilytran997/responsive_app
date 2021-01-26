import 'package:demo_desktop/utilities/check_platform.dart';
import 'package:demo_desktop/utilities/image_picker/image_picker.dart';
import 'package:demo_desktop/utilities/network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _platform;
  ApplicationResult image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (ApplicationPlatform.isAndroid) {
      _platform = "Mobisale";
    } else if (ApplicationPlatform.isIOS) {
      _platform = "Mobisale";
    } else if (ApplicationPlatform.isLinux) {
      _platform = "Appsale";
    } else if (ApplicationPlatform.isMacOS) {
      _platform = "Appsale";
    } else if (ApplicationPlatform.isWindows) {
      _platform = "Appsale";
    } else if (ApplicationPlatform.isWeb) {
      _platform = "Websale";
    } else {
      _platform = "undefined platform";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title??""),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _platform??"",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ApplicationNetworkImage(
                  url:
                  "https://images.pexels.com/photos/414102/pexels-photo-414102.jpeg",
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.7,
                child: image != null
                    ? ApplicationPlatform.isWeb
                    ? image.image
                    : Image.file(image.file)
                    : Container(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          image = await ApplicationImagePicker.pickImage(context,
              source: ImageSource.gallery);
          setState(() {});
        },
        tooltip: 'PickImage',
        child: Icon(Icons.photo),
      ),
    );
  }
}