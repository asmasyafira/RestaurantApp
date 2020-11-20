class PostCustomerReview {
  PostCustomerReview({
    this.id,
    this.name,
    this.review,
  });

  final String id;
  final String name;
  final String review;

  factory PostCustomerReview.fromJson(Map<String, dynamic> json) => PostCustomerReview(
    id: json["id"],
    name: json["name"],
    review: json["review"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "review": review,
  };
}