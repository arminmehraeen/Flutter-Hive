class UserModel {

  final String firstName;
  final String lastName ;
  final String phoneNumber ;
  final bool selected ;
  final String createdTime ;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.createdTime,
    this.selected = false,
  });


  static List<UserModel> testUsers() => List.generate(5, (index) => testUser);
  static  UserModel get testUser => UserModel(
      firstName: "Armin",
      lastName: "Mehraein",
      phoneNumber: "+98912345678",
      selected : false,
      createdTime: DateTime.now().toString()
  ) ;



  Map<String, dynamic> toMap() => {
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'createdTime': createdTime,
    'selected': selected,
  };



  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    firstName: map['firstName'] as String,
    lastName: map['lastName'] as String,
    phoneNumber: map['phoneNumber'] as String,
    createdTime: map['createdTime'] as String,
    selected: false,
  );

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    bool? selected,
    String? createdTime,
  }) => UserModel(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    selected: selected ?? this.selected,
    createdTime: createdTime ?? this.createdTime,
  );

}