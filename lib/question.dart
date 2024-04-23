class Question {
  final String question;
  final bool answer;
  Question({required this.question, required this.answer});
}

List<Question> questionBank = [
  Question(
      question: 'You can lead a cow down stairs but not up stairs.',
      answer: false),
  Question(
      question: 'Approximately one quarter of human bones are in the feet.',
      answer: true),
  Question(question: 'A slug\'s blood is green.', answer: true)
];
