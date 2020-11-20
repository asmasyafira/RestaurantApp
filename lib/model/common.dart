class CommonName {
  CommonName({
    this.name,
  });

  final String name;

  factory CommonName.fromJson(Map<String, dynamic> json) => CommonName(
        name: json["name"],
      );
}

class CommonResult {
  CommonResult({this.error, this.message});

  final bool error;
  final String message;

  factory CommonResult.fromJson(Map<String, dynamic> json) =>
      CommonResult(
        error: json["error"],
        message: json["message"],
      );
}
