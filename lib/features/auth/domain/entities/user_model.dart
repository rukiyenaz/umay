class UserModel {
  final String id;
  final String email;
  final String name;
  final String surname;
  final int age;
  final String haftalik;
  final DateTime dogumTarihi;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
    required this.age,
    required this.haftalik,
    required this.dogumTarihi,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      age: map['age']?.toInt() ?? 0,
      haftalik: map['haftalik'] ?? '',
      dogumTarihi: DateTime.parse(map['dogumTarihi']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'surname': surname,
      'age': age,
      'haftalik': haftalik,
      'dogumTarihi': dogumTarihi.toIso8601String(),
    };
  }
}