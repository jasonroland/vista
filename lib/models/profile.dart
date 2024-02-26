class Profile {
  String name;
  String jobOrSchool;
  int age;
  String instagram;
  String gender;
  String profileImageLink;

  // Constructor
  Profile({
    required this.name,
    required this.jobOrSchool,
    required this.age,
    required this.instagram,
    required this.gender,
    required this.profileImageLink,
  });

  // Named constructor for creating a Profile object from a Map
  Profile.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        jobOrSchool = map['jobOrSchool'],
        age = map['age'],
        instagram = map['instagram'],
        gender = map['gender'],
        profileImageLink = map['profileImageLink'];

  // Method to convert Profile object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'jobOrSchool': jobOrSchool,
      'age': age,
      'instagram': instagram,
      'gender': gender,
      'profileImageLink': profileImageLink,
    };
  }
}
