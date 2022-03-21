/// 检查邮箱格式
bool isEmail(String? str) {
  if (str == null || str.isEmpty) return false;
  String regexEmail = '^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$';
  return RegExp(regexEmail).hasMatch(str);
}

/// 检查字符长度
bool checkStringLength(String? str, int length) {
  if (str == null || str.isEmpty) return false;
  return str.length >= length;
}
