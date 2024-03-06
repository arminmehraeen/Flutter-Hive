class UserModel {

  final String firstName;
  final String lastName ;
  final String phoneNumber ;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  static UserModel testUser() {
    return const UserModel(
      firstName: "Armin",
      lastName: "Mehraein",
      phoneNumber: "+98912345678"
    ) ;
  }

  static List<UserModel> testUsers() => List.generate(10, (index) => testUser());


  @override
  String toString() {
    return 'UserModel{firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber}';
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

}