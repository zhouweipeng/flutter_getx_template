part of style;

/// 统一边距
class Distance {
  static final xs = 4.w;
  static final sm = 8.w;
  static final md = 12.w;
  static final lg = 16.w;
  static final xl = 20.w;
  static final xxl = 24.w;

  static final Map<String, double> levels = {
    'xs': xs,
    'sm': sm,
    'md': md,
    'lg': lg,
    'xl': xl,
    'xxl': xxl
  };

  static double getSize(String key) => levels[key] ?? 0;

  // 无边距
  static get zero => EdgeInsets.zero;

  // 四个方向统一边距
  static EdgeInsets all(String size) => EdgeInsets.all(getSize(size));

  // 根据左上右下的顺序设置
  static EdgeInsets fromLTRB(
      String left, String top, String right, String bottom) =>
      EdgeInsets.fromLTRB(
          getSize(left), getSize(top), getSize(right), getSize(bottom));

  // 单独对每个方向进行设置
  static EdgeInsets only(
      {String left = '',
        String top = '',
        String right = '',
        String bottom = ''}) =>
      EdgeInsets.only(
          left: getSize(left),
          top: getSize(top),
          right: getSize(right),
          bottom: getSize(bottom));

  // 单独对横纵轴进行设置
  static EdgeInsets symmetric({String horizontal = '', String vertical = ''}) =>
      EdgeInsets.symmetric(
          horizontal: getSize(horizontal), vertical: getSize(vertical));
}
