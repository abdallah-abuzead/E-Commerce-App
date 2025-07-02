import 'package:appwrite/appwrite.dart';

abstract class Appwrite {
  static const String appwriteProjectId = "6863ce9f001338f2182d";
  static const String apiEndpoint = "https://nyc.cloud.appwrite.io/v1";
  static late final Account account;
  static late final Storage storage;

  static void init() {
    final Client client = Client().setEndpoint(apiEndpoint).setProject(appwriteProjectId);
    account = Account(client);
    storage = Storage(client);
  }

  static const String mediaBucketId = 'media';

  static String getDownloadURL(String bucketId, String fileId) =>
      'https://nyc.cloud.appwrite.io/v1/storage/buckets/$bucketId/files/$fileId/view?project=$appwriteProjectId';
}
