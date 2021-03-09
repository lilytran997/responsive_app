import 'package:demo_desktop/utilities/check_platform.dart';
import 'package:demo_desktop/utilities/globals.dart';
import 'package:demo_desktop/utilities/image_picker/image_picker.dart';
import 'package:demo_desktop/utilities/network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProfilePage> {
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
    Globals().init(context: context);
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _platform ?? "",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  right: Globals.maxPadding,
                  left: Globals.maxPadding,
                  bottom: Globals.minPadding),
              child: ApplicationNetworkImage(
                url:
                    "https://images.pexels.com/photos/414102/pexels-photo-414102.jpeg",
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  right: Globals.maxPadding,
                  left: Globals.maxPadding,
                  bottom: Globals.minPadding),
              child: image != null
                  ? ApplicationPlatform.isWeb
                      ? image.image
                      : Image.file(image.file)
                  : Container(),
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
