import 'package:cloud_firestore/cloud_firestore.dart';

class DepositItem{
  final String? itemId;
  final String depositId;
  final String materialType;
  final int quantity;
  final double points;
  final DateTime scannedAt;

  ///Consturctor for DepositItem
  DepositItem({
    this.itemId,
    required this.depositId,
    required this.materialType,
    required this.quantity,
    required this.points,
    required this.scannedAt,
});

  ///Static function to create an empty model
  static DepositItem empty() => DepositItem(
    itemId: '',
    depositId: '',
    materialType: '',
    quantity: 0,
    points: 0,
    scannedAt: DateTime.now(),
  );

  ///Convert model to JSON for Firestore
  Map<String, dynamic> toJson(){
    return{
      'item_id': itemId,
      'deposit_id': depositId,
      'material_type': materialType,
      'quantity': quantity,
      'points': points,
      'scanned_at': scannedAt,
    };
  }

  factory DepositItem.fromSnapshot(DocumentSnapshot<Map<String, dynamic>>document){
    if(document.data()!=null){
      final data = document.data()!;
      return DepositItem(
        itemId: document.id,
        depositId: data['deposit_id'] ?? '',
        materialType: data['material_type'] ?? '',
        quantity: data['quantity'] ?? 0,
        points: data['points'] ?? 0,
        scannedAt: data['scanned_at']?.toDate() ?? DateTime.now(),
      );
    }else{
      return DepositItem.empty();
    }
  }
}