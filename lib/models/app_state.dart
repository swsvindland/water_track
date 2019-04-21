import 'package:firebase_auth/firebase_auth.dart';

class AppState {
  final int count;
  final bool isLoading;
  final FirebaseUser currentUser;

  AppState({this.count = 0, this.isLoading = false, this.currentUser});

  AppState copyWith({int count, bool isLoading}) {
    return new AppState(
      count: count ?? this.count,
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, count: $count, currentUser: $currentUser}';
  }
}