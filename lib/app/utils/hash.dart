import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashPass(String password) {
  final key = utf8.encode("p455w0rd");
  final bytes = utf8.encode(password);

  final hmacSha256 = Hmac(sha256, key);
  final digest = hmacSha256.convert(bytes);

  return digest.toString();
}