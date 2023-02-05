class UserModel {
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? sId;
  int? iV;

  UserModel(
      {this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.sId,
      this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
