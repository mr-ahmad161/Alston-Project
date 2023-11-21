class PrestartResponseSTEP2 {
  int success;
  String message;
  QuestionData data;

  PrestartResponseSTEP2({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PrestartResponseSTEP2.fromJson(Map<String, dynamic> json) {
    return PrestartResponseSTEP2(
      success: json['success'],
      message: json['message'],
      data: QuestionData.fromJson(json['data']),
    );
  }
}

class QuestionData {
  String questionId;

  QuestionData({
    required this.questionId,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      questionId: json['question_id'],
    );
  }
}
