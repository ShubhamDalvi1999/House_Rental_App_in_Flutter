import 'package:database_curd_demo_app/models/index.dart';

class MonthlyData {
  static List<int> months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  int? month;
  int? fullrentgivenondate;
  int? partialrentgivenondate;
  String? rentgivenby;
  String? paymentmethod;

  MonthlyData({
    required this.month,
    required this.fullrentgivenondate,
    required this.partialrentgivenondate,
    required this.rentgivenby,
    required this.paymentmethod,
  });

  //converting data into map so we can upload it in firestore
  Map<String, dynamic> toMap() {
    return {
      "month": month,
      "fullrentgivenondate": fullrentgivenondate,
      "partialrentgivenondate": partialrentgivenondate,
      "rentgivenby": rentgivenby,
      "paymentmethod": paymentmethod
    };
  }
}
