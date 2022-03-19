import 'package:database_curd_demo_app/models/index.dart';

class MonthlyData {
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
