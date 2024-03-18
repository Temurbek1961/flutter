import 'package:flutter_dotenv/flutter_dotenv.dart';
class ApiValues {
  final String? uid;
  final String? id;
  static const String baseURL = 'https://api.dostonbarber.uz';
  static const String userList = '/api/user/index?page=1';
  static const String login = '/api/auth/login';
  static const String signUp = '/api/auth/register';
  static const String user = '/api/user';

  String get userById => '/api/user/get/${uid!}';

  static const String createUser = '/api/user/create';

  String get updateUserById => '/api/user/update/${id!}';
  static Map<String, String> API_KEY_VALUE = {
    "key": dotenv.get('AUTHORIZATIONS_API_KEY_NAME'),
    "value": dotenv.get('AUTHORIZATIONS_API_KEY_VALUE'),
  };

  ApiValues({this.uid = '', this.id});
}
