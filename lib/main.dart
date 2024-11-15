import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyAppp());
}

//     <!-- Storage permissions for Android 8 to Android 15 -->
//     <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
//     <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="29" />
//     <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />

//     <application
//         android:requestLegacyExternalStorage="true"  <!-- Bypass scoped storage on Android 10 only -->
//         ... >
//         ...
//     </application>

class MyAppp extends StatelessWidget {
  const MyAppp({super.key});

  Future<void> checkPermission(
      Permission permission, BuildContext context) async {
    final status = await permission.request();
    if (status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Permission Granted"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Permission not Granted"),
        ),
      );
    }
  }

  // Android Version check
  Future<bool> requPermission(Permission permission) async {
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    if (build.version.sdkInt >= 30) {
      final status = await permission.request();
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      if (await permission.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: const Text('Permission Handler'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              requPermission(Permission.manageExternalStorage);
            },
            child: Text("Get Permission"),
          ),
        ),
      ),
    );
  }
}
