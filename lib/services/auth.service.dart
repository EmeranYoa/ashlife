import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:get/get.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AuthService extends GetxService {
  Future<bool> checkAuthenticateUser() async {
    try {
      await Amplify.Auth.getCurrentUser();
      return true;
    } on AuthException {
      return false;
    }
  }

  Future<AuthUser?> getCurrentUser() async {
    try {
      return await Amplify.Auth.getCurrentUser();
    } on AuthException {
      return null;
    }
  }

  Future<bool> resendVerificationCode(String username) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: username);
      return true;
    } on AuthException {
      return false;
    }
  }

  Future<bool> sendRecoveryRequest(String username) async {
    try {
      await Amplify.Auth.resetPassword(username: username);
      print('*' * 100);
      print('reset password sms send');
      return true;
    } on AuthException {
      return false;
    }
  }

  Future<void> signIn(String username, String password) async {
    try {
      await Amplify.Auth.signIn(username: username, password: password);
    } on AuthException catch (e) {
      Get.snackbar('Error', e.message);
    }
  }

  Future<void> signUp(String username, String password,
      Map<CognitoUserAttributeKey, String> attribute) async {
    try {
      await Amplify.Auth.signUp(
          username: username,
          password: password,
          options: CognitoSignUpOptions(userAttributes: attribute));
    } on AuthException catch (e) {
      Get.snackbar('Error', e.message);
    }
  }

  Future<bool> signOutCurrentUser() async {
    try {
      await Amplify.Auth.signOut();
      return true;
    } on AuthException catch (e) {
      Get.snackbar('Error', e.message);
      return false;
    }
  }

  Future<bool> editUserInfo(String name, String email) async {
    try {
      final attributes = [
        AuthUserAttribute(
          userAttributeKey: CognitoUserAttributeKey.email,
          value: email,
        ),
        AuthUserAttribute(
          userAttributeKey: CognitoUserAttributeKey.name,
          value: name,
        )
      ];

      final result =
          await Amplify.Auth.updateUserAttributes(attributes: attributes);
      result.forEach((key, value) {
        if (value.nextStep.updateAttributeStep ==
            'CONFIRM_ATTRIBUTE_WITH_CODE') {
          final destination = value.nextStep.codeDeliveryDetails?.destination;
          print('Confirmation code sent to $destination for $key');
        } else {
          print('Update completed for $key');
        }
      });
      return true;
    } on AmplifyException catch (e) {
      Get.snackbar('Error', e.message);
      return false;
    }
  }

  Future<bool> changePassword(String newPassword, String oldPassword) async {
    try {
      await Amplify.Auth.updatePassword(
          newPassword: newPassword, oldPassword: oldPassword);
      return true;
    } on AuthException catch (e) {
      Get.snackbar('Error', e.message);
      return false;
    }
  }
}
