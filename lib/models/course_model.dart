class CourseModel {

  final String name ;
  final int size ;
  final bool selected ;
  final String createdTime ;

  const CourseModel({
    required this.name,
    required this.size,
    required this.createdTime,
    this.selected = false,
  });

  static List<CourseModel> testCourses() => List.generate(5, (index) => testCourse);
  static CourseModel get testCourse => CourseModel(
      size: 3,
      name: "Math",
      selected : false,
      createdTime: DateTime.now().toString()
  ) ;




  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'size': this.size,
      'selected': this.selected,
      'createdTime': this.createdTime,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      name: map['name'] as String,
      size: map['size'] as int,
      selected: map['selected'] as bool,
      createdTime: map['createdTime'] as String,
    );
  }

  CourseModel copyWith({
    String? name,
    int? size,
    bool? selected,
    String? createdTime,
  }) {
    return CourseModel(
      name: name ?? this.name,
      size: size ?? this.size,
      selected: selected ?? this.selected,
      createdTime: createdTime ?? this.createdTime,
    );
  }
}