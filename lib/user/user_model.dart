class UserModel {

  final String firstName;
  final String lastName ;

  const UserModel({
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }


}