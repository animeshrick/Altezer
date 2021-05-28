class GetQuestions {
  GetQuestions({
    required this.message,
    required this.status,
    required this.question1,
    required this.question2,
    required this.question3,
  });

  final String message;
  final String status;
  final List<Question> question1;
  final List<Question> question2;
  final List<Question> question3;

  factory GetQuestions.fromJson(Map<String, dynamic> json) => GetQuestions(
        message: json["message"],
        status: json["status"],
        question1: List<Question>.from(
            json["Question_1"].map((x) => Question.fromJson(x))),
        question2: List<Question>.from(
            json["Question_2"].map((x) => Question.fromJson(x))),
        question3: List<Question>.from(
            json["Question_3"].map((x) => Question.fromJson(x))),
      );
}

class Question {
  Question({
    required this.questionId,
    required this.question,
  });

  final int questionId;
  final String question;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json["Question_ID"],
        question: json["Question"],
      );
}
