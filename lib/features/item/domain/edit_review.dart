class EditReview{
  String description;
  String rating;

  EditReview({required this.description, required this.rating});
  Map<String, dynamic> toJson() =>
      {"textFeedback": description, "rating": rating};
}