class TripModel {
  final String title;
  final String? id;
  final String? organizerId;
  final String? description;
  final String? governorate;
  final String? gatheringPlace;
  final DateTime startDate;
  final DateTime? endDate;
  final String? startTime;
  final String? hotel;
  final int? hotelRating;
  final bool breakfast;
  final bool lunch;
  final bool dinner;
  final List<String>? visits;
  final List<String>? activities;
  final double price;
  final bool isActive;
  final List<String>? images;

  TripModel({
    required this.title,
    this.id,
    this.organizerId,
    this.description,
    this.governorate,
    this.gatheringPlace,
    required this.startDate,
    this.endDate,
    this.startTime,
    this.hotel,
    this.hotelRating,
    this.breakfast = false,
    this.lunch = false,
    this.dinner = false,
    this.visits,
    this.activities,
    required this.price,
    this.isActive = true,
    this.images,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        title: json['title'] as String,
        id: json['id'] as String,
        organizerId:json['organizer_id'] as String,
        description: json['description'] as String?,
        governorate: json['governorate'] as String?,
        gatheringPlace: json['gathering_place'] as String?,
        startDate: DateTime.parse(json['start_date']),
        endDate: json['end_date'] != null
            ? DateTime.tryParse(json['end_date'])
            : null,
        startTime: json['start_time'] as String?,
        hotel: json['hotel'] as String?,
        hotelRating: json['hotel_rating'] as int?,
        breakfast: json['breakfast'] ?? false,
        lunch: json['lunch'] ?? false,
        dinner: json['dinner'] ?? false,
        visits: (json['visits'] as List?)?.map((e) => e.toString()).toList(),
        activities:
            (json['activities'] as List?)?.map((e) => e.toString()).toList(),
        price: (json['price'] as num).toDouble(),
        isActive: json['is_active'] ?? true,
        images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'description': description,
        'governorate': governorate,
        'gathering_place': gatheringPlace,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate?.toIso8601String(),
        'start_time': startTime,
        'hotel': hotel,
        'hotel_rating': hotelRating,
        'breakfast': breakfast,
        'lunch': lunch,
        'dinner': dinner,
        'visits': visits,
        'activities': activities,
        'price': price,
        'is_active': isActive,
        'images': images,
      };
  TripModel copyWith({
    String? title,
    String? description,
    String? governorate,
    String? gatheringPlace,
    DateTime? startDate,
    DateTime? endDate,
    String? startTime,
    String? hotel,
    int? hotelRating,
    bool? breakfast,
    bool? lunch,
    bool? dinner,
    List<String>? visits,
    List<String>? activities,
    double? price,
    bool? isActive,
    List<String>? images,
  }) {
    return TripModel(
      title: title ?? this.title,
      description: description ?? this.description,
      governorate: governorate ?? this.governorate,
      gatheringPlace: gatheringPlace ?? this.gatheringPlace,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      hotel: hotel ?? this.hotel,
      hotelRating: hotelRating ?? this.hotelRating,
      breakfast: breakfast ?? this.breakfast,
      lunch: lunch ?? this.lunch,
      dinner: dinner ?? this.dinner,
      visits: visits ?? this.visits,
      activities: activities ?? this.activities,
      images: images ?? this.images, // ✅ تقدر تحدث الصور هنا
      price: price ?? this.price,
      isActive: isActive ?? this.isActive,
    );
  }
}
