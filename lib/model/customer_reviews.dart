class CustomerReviews {
  CustomerReviews({
    this.name,
    this.review,
    this.date,
  });

  final String name;
  final String review;
  final String date;

  factory CustomerReviews.fromJson(Map<String, dynamic> json) => CustomerReviews(
    name: json["name"],
    review: json["review"],
    date: json["date"],
  );
}