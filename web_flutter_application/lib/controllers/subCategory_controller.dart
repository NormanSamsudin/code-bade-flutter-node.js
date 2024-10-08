import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:web_flutter_application/global_variable.dart';
import 'package:web_flutter_application/models/subcategory.dart';
import 'package:http/http.dart' as http;
import 'package:web_flutter_application/services/manage_http_response.dart';

class SubcategoryController {
  uploadSubCategory(
      {required String categoryId,
      required String categoryName,
      required dynamic pickedImage,
      required String subCategoryName,
      required context}) async {
    try {
      final cloudinary = CloudinaryPublic("devuu2aov", "jyqzc4qz");

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage,
              identifier: 'pickedImage', folder: 'categoryImage'));

      String imageUrl = imageResponse.secureUrl;

      SubCategoryModel category = SubCategoryModel(
          categoryId: categoryId,
          categoryName: categoryName,
          image: imageUrl,
          id: '',
          subCategoryName: subCategoryName);

      http.Response response = await http.post(Uri.parse("$uri/api/subcategories"),
          body: category.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Uploaded subcategory');
          });
    } catch (e) {
      print("Error uploading to cloudinary $e");
    }
  }
}
