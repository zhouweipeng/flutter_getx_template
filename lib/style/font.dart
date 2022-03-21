part of style;

/// 统一字体
class Font {
  static final xs = 10.sp;
  static final sm = 12.sp;
  static final md = 14.sp;
  static final lg = 16.sp;
  static final xl = 18.sp;
  static final xxl = 20.sp;
  static final xxxl = 24.sp;

  static final Map<String, double> levels = {
    'xs': xs,
    'sm': sm,
    'md': md,
    'lg': lg,
    'xl': xl,
    'xxl': xxl,
    'xxxl': xxxl
  };

  static double getSize(String key) => levels[key] ?? 0;
}
