class SignUpPostModel {
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String company;
  final String password;
  final String rPassword;

  SignUpPostModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.company,
    required this.password,
    required this.rPassword,
  });
}
