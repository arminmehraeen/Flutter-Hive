class UserModel {

  final String firstName;
  final String lastName ;
  final String phoneNumber ;
  final bool selected ;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.selected = false,
  });

  static  UserModel get testUser => const UserModel(
      firstName: "Armin",
      lastName: "Mehraein",
      phoneNumber: "+98912345678",
      selected : false
  ) ;


  @override
  String toString() {
    return 'UserModel{firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, selected: $selected}';
  }

  static List<UserModel> testUsers() => List.generate(10, (index) => testUser);

  Map<String, dynamic> toMap() => {
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'selected': selected,
  };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    firstName: map['firstName'] as String,
    lastName: map['lastName'] as String,
    phoneNumber: map['phoneNumber'] as String,
    selected: false,
  );

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    bool? selected,
  }) => UserModel(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    selected: selected ?? this.selected,
  );

}