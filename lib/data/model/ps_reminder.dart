class PSReminders {
  final String? status;
  final DateTime followUpDate;
  final String? name;
  final String? userId;
  final DateTime? lastDate;

  const PSReminders({
    required this.followUpDate,
    this.lastDate,
    this.name,
    this.status,
    this.userId,
  });

  factory PSReminders.fromMap(Map data) {
    return PSReminders(
      followUpDate: data['follow_up_date'],
      lastDate: data['last_date'],
      name: data['name'],
      userId: data['uid'],
      status: data['status'],
    );
  }

  factory PSReminders.fromDS(String id, Map<String, dynamic> data) {
    return PSReminders(
      followUpDate: data['follow_up_date'],
      lastDate: data['last_date'],
      name: data['name'],
      userId: data['uid'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'follow_up_date': followUpDate,
      'name': name,
      'uid': userId,
      'last_date': lastDate,
      'status': status,
    };
  }
}
