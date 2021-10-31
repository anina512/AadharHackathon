import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Future getData(url, XFile? image) async {

  //Response response = await get(url);
  //return response.body;
  var req = http.MultipartRequest('POST', url);
  req.files.add(await http.MultipartFile.fromPath('image', image!.path));
  var res = await req.send();
  //return res.reasonPhrase;

  //http.MultipartFile.fromPath(
    //  'picture',
      //image!.path
  //);
  var response = await http.Response.fromStream(res);
  return response.body;
}