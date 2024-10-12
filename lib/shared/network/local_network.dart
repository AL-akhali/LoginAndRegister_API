import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork{
  static late SharedPreferences sharedPref;
  static Future cacheInit() async
  {
    sharedPref = await SharedPreferences.getInstance();
  }
  static Future<bool> InsertToCache({required String key,required String value})
  async{
    return await sharedPref.setString(key, value);
  }
  static String GetCacheDate({required String key})
  {
    return  sharedPref.getString(key) ?? "";
  }
  static Future<bool> DeleteCacheItem({required String key})
  async
  {
    return await sharedPref.remove(key);
  }


}