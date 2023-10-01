class ContactListModel {
  List<ContactModel>? results;

  ContactListModel({this.results});

  ContactListModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ContactModel>[];
      json['results'].forEach((v) {
        results!.add(ContactModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactModel {
  String? objectId;
  String? name;
  String? surname;
  String? initial;
  String? phone;
  String? email;
  String? company;
  String? photoUrl;
  bool? favorite;
  String? createdAt;
  String? updatedAt;

  ContactModel({
    this.objectId,
    this.name,
    this.surname,
    this.initial,
    this.phone,
    this.email,
    this.company,
    this.photoUrl,
    this.favorite,
    this.createdAt,
    this.updatedAt,
  });

  ContactModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    name = json['name'];
    surname = json['surname'];
    initial = json['initial'];
    phone = json['phone'];
    email = json['email'];
    company = json['company'];
    photoUrl = json['photo_url'];
    favorite = json['favorite'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['name'] = name;
    data['surname'] = surname;
    data['initial'] = initial;
    data['phone'] = phone;
    data['email'] = email;
    data['company'] = company;
    data['photo_url'] = photoUrl;
    data['favorite'] = favorite;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['initial'] = initial;
    data['phone'] = phone;
    data['email'] = email;
    data['company'] = company;
    data['photo_url'] = photoUrl;
    data['favorite'] = favorite;
    return data;
  }
}
