// import 'package:flutter/material.dart';
// import 'package:wastenot/features/shop/views/testPraser.dart';
//
//
// class QRResultPage extends StatelessWidget {
//   final String qrData;
//
//   QRResultPage({required this.qrData});
//
//   @override
//   Widget build(BuildContext context) {
//     Map<String, String> data = parseQRData(qrData);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('QR Code Result'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Material of Bottles: ${data['Material']}'),
//             Text('Number of Bottles: ${data['Bottles']}'),
//             Spacer(),
//             ElevatedButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: Text('Claim Successful'),
//                     content: Text('Points have been added to your account.'),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Text('OK'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               child: Text('Claim'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class QRResultPage extends StatelessWidget {
  final Map<String, dynamic> qrData;

  QRResultPage({required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Material of Bottles: ${qrData['Material']}'),
            Text('Number of Bottles: ${qrData['Bottles']}'),
            Text('Points Awarded: ${qrData['Points']}'),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Claim Successful'),
                    content: Text('Points have been added to your account.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Claim'),
            ),
          ],
        ),
      ),
    );
  }
}
