class BoardListDto {
  final int id;
  final String title;
  final String lastPostTitle;

  BoardListDto({required this.id, required this.title, required this.lastPostTitle});

  factory BoardListDto.fromJson(Map<String, dynamic> json) {
    return BoardListDto(
      id: json['id'],
      title: json['title'],
      lastPostTitle: json['lastPostTitle'],
    );
  }
}