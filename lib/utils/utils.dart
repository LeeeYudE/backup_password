
class Utils {

  //获取图片位置
  static String getImgPath(String name,
      {String format = 'png', String path = 'images'}) {
    return 'assets/$path/$name.$format';
  }

}