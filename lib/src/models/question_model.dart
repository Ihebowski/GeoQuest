class QuestionModel {
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  final String? imageUrl;

  QuestionModel({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    this.imageUrl,
  });

  bool isCorrect(String answer) {
    return answer == correctAnswer;
  }
}
