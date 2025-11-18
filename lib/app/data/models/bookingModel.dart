class BookingModel {
  final String tripId;
  final String organizerId;
  final String customerName;
  final String customerPhone;
  final int adults;
  final int children;

  final String status;

  BookingModel({
    required this.tripId,
    required this.organizerId,
    required this.customerName,
    required this.customerPhone,
    required this.adults,
    required this.children,
    this.status = 'pending',
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      tripId: json['trip_id'],
      organizerId: json['organizer_id'],
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      adults: json['adults'],
      children: json['children'],
      status: json['status'],
    );
  }
}
