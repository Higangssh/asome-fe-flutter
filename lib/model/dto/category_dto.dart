class CategoryDto {
  final int categoryId;
  final String boardName;

  CategoryDto({required this.categoryId, required this.boardName});

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      categoryId: json['categoryId'],
      boardName: json['boardName'],
    );
  }
}