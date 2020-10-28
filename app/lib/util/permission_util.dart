/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-11 15:53:59
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-11 16:29:45
 */
import 'package:permission_handler/permission_handler.dart';

///
/// Permission Util
///---------------
/// permission-handler - https://github.com/Baseflow/flutter-permission-handler
/*
How to use
There are a number of Permissions. You can get a Permission's status, which is either undetermined, granted, denied, restricted or permanentlyDenied.

var status = await Permission.camera.status;
if (status.isUndetermined) {
  // We didn't ask for permission yet.
}

// You can can also directly ask the permission about its status.
if (await Permission.location.isRestricted) {
  // The OS restricts access, for example because of parental controls.
}
Call request() on a Permission to request it. If it has already been granted before, nothing happens.
request() returns the new status of the Permission.

if (await Permission.contacts.request().isGranted) {
  // Either the permission was already granted before or the user just granted it.
}

// You can request multiple permissions at once.
Map<Permission, PermissionStatus> statuses = await [
  Permission.location,
  Permission.storage,
].request();
print(statuses[Permission.location]);
Some permissions, for example location or acceleration sensor permissions, have an associated service, which can be enabled or disabled.

if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
  // Use location.
}
You can also open the app settings:

if (await Permission.speech.isPermanentlyDenied) {
  // The user opted to never again see the permission request dialog for this
  // app. The only way to change the permission's status now is to let the
  // user manually enable it in the system settings.
  openAppSettings();
}
On Android, you can show a rationale for using a permission:

bool isShown = await Permission.contacts.shouldShowRequestRationale;
*/
class PermissionUtil {
  ///
  /// open app setting
  ///
  static void openAppSetting() {
    openAppSettings();
  }

  ///
  /// check permission status
  ///
  static Future<PermissionStatus> checkStatus(Permission permission) async {
    return await permission.status;
  }

  ///
  /// request single permissions
  ///
  static Future<PermissionStatus> request(Permission permission) async {
    return await permission.request();
  }

  ///
  /// request multiple permissions at once
  ///
  static Future<Map<Permission, PermissionStatus>> requestAll(
      List<Permission> permissions) async {
    return permissions.request();
  }
}
