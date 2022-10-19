// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      email: json['email'] as String?,
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      emailIsVerified: json['emailIsVerified'] as bool? ?? false,
      balance: json['balance'] as String?,
      pin: json['pin'] as String? ?? '',
      favoriteVendor: json['favoriteVendor'] as List<dynamic>?,
      mealPlanList: (json['mealPlanList'] as List<dynamic>?)
              ?.map((e) => MealPlan.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [MealPlan.empty],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'phoneNumber': instance.phoneNumber,
      'emailIsVerified': instance.emailIsVerified,
      'balance': instance.balance,
      'pin': instance.pin,
      'favoriteVendor': instance.favoriteVendor,
      'mealPlanList': instance.mealPlanList,
    };
