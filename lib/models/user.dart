class UserModel {
  /// Creates the user class with required details.
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.lang,
    this.periodDay,
    this.ndybf,
    this.timeZone,
  });

  /// user id
  final String? id;

  /// name of an user.
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? lang;
  final int? periodDay;
  final int? ndybf;
  final String? timeZone;

  /// age of an user.

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? lang,
    int? periodDay,
    int? ndybf,
    String? timeZone,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      lang: lang ?? this.lang,
      periodDay: periodDay ?? this.periodDay,
      ndybf: ndybf ?? this.ndybf,
      timeZone: timeZone ?? this.timeZone,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      phone: data['phone'] as String,
      lang: data['lang'] as String,
      periodDay: data['periodDay'] as int,
      ndybf: data['ndybf'] as int,
      timeZone: data['dateOfBirth'] as String,
    );
  }

  /// Role of an user.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "language": lang,
      "period_day": periodDay,
      "notification_day_before": ndybf,
      "time_zone": timeZone,
    };
  }
}
