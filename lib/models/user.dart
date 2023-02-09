class UserModel {
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? sId;
  String? profileimage;
  int? iV;

  UserModel(
      {this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.sId,
      this.profileimage,
      this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    sId = json['_id'];
    profileimage = json['profileimage'];
    iV = json['__v'];
  }
}
