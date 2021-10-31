import 'package:shared_preferences/shared_preferences.dart';

class DataSharedPrefrences {
  static SharedPreferences? _preferences;

  static const _keyFavTitle = 'favTitle';
  static const _keyFavPrice = 'favPrice';
  static const _keyFavImgUrl = 'favImgUrl';

  static const _keyCartTitle = 'cartTitle';
  static const _keyCartPrice = 'cartPrice';
  static const _keyCartImgUrl = 'cartImgUrl';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setFavTitle(List<String> favTitle) async =>
      await _preferences?.setStringList(_keyFavTitle, favTitle) ?? [];

  static List<String> getFavTitle() => _preferences?.getStringList(_keyFavTitle) ?? [];

  static Future setFavPrice(List<String> favPrice) async =>
      await _preferences?.setStringList(_keyFavPrice, favPrice);

  static List<String> getFavPrice() => _preferences?.getStringList(_keyFavPrice) ?? [];

  static Future setFavImgUrl(List<String> favImgUrl) async =>
      await _preferences?.setStringList(_keyFavImgUrl, favImgUrl);

  static List<String> getFavImgUrl() => _preferences?.getStringList(_keyFavImgUrl) ?? [];


  static Future setCartTitle(List<String> cartTitle) async =>
      await _preferences?.setStringList(_keyFavTitle, cartTitle);

  static List<String> getCartTitle() => _preferences?.getStringList(_keyCartTitle) ?? [];

  static Future setCartPrice(List<String> cartPrice) async =>
      await _preferences?.setStringList(_keyFavPrice, cartPrice);

  static List<String> getCartPrice() => _preferences?.getStringList(_keyCartPrice) ?? [];

  static Future setCartImgUrl(List<String> cartImgUrl) async =>
      await _preferences?.setStringList(_keyFavImgUrl, cartImgUrl);

  static List<String> getCartImgUrl() => _preferences?.getStringList(_keyCartImgUrl) ?? [];
}
