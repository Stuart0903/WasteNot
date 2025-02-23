// Map<String, String> parseQRData(String data) {
//   Map<String, String> result = {};
//   List<String> parts = data.split(', ');
//   for (String part in parts) {
//     List<String> keyValue = part.split(': ');
//     if (keyValue.length == 2) {
//       result[keyValue[0]] = keyValue[1];
//     }
//   }
//   return result;
// }

import 'dart:convert';

Map<String, dynamic> parseQRData(String jsonData) {
  return json.decode(jsonData);
}
