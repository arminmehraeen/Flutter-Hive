class UserModel {

  final String firstName;
  final String lastName ;
  final String phoneNumber ;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });


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


}