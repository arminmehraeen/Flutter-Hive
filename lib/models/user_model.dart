class UserModel {

  final String firstName;
  final String lastName ;
  final String phoneNumber ;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  static  UserModel get testUser => const UserModel(
      firstName: "Armin",
      lastName: "Mehraein",
      phoneNumber: "+98912345678"
  ) ;

  static List<UserModel> testUsers() => List.generate(10, (index) => testUser);


  @override
  String toString() => 'UserModel{firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber}';

  Map<String, dynamic> toMap() => {
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
  };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    firstName: map['firstName'] as String,
    lastName: map['lastName'] as String,
    phoneNumber: map['phoneNumber'] as String,
  );

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) => UserModel(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
  );

}