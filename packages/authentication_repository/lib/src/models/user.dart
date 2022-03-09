import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'user.g.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}

@JsonSerializable()
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.phoneNumber,
    this.emailIsVerified = false,
    this.balance,
    this.pin = '',
    this.favoriteVendor,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Url for the current user's mobile number.
  final String? phoneNumber;

  /// List of user's favorite vendors.
  final bool emailIsVerified;

  /// Balance of user's wallet.
  final String? balance;

  /// Balance of user's wallet.
  final String pin;

  /// List of user's favorite vendors.
  final List<dynamic>? favoriteVendor;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  //bool get emailIsVerified => emailVerified == true;

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  /// Convenience getter to determine whether the current user is empty.
  bool get hasPIN => pin != '';

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromFirestore(DocumentSnapshot snapshot) {
    return User.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  List<Object?> get props => [
        email,
        id,
        name,
        photo,
        phoneNumber,
        emailIsVerified,
        balance,
        favoriteVendor
      ];
}
