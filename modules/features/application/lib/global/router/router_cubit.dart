import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template RouterState}
/// The state of the [RouterCubit].
/// {@endtemplate}
class RouterState with EquatableMixin {
  /// {@macro RouterState}
  RouterState({
    this.isInitializing = true,
    this.isLoggedIn = false,
    this.isLoggingIn = false,
    this.isRegistering = false,
    this.isAccountUnverified = false,
    this.isCompletingProfile = false,
    this.isIncompleteProfile = false,
    this.isResettingPassword = false,
    this.hasNetworkError = false,
    this.hasUnhandledError = false,
  });

  /// Has a `true` value if the app is still initializing.
  /// `Initializing` means loading all the infrastructure services.
  final bool isInitializing;

  /// Has a `true` value if the user is logged in.
  final bool isLoggedIn;

  /// Has a `true` value if the user is logging in.
  final bool isLoggingIn;

  /// Has a `true` value if the user is signup process.
  final bool isRegistering;

  /// Has a `true` value if the user is verify account process.
  final bool isAccountUnverified;

  /// Has a `true` value if the user is complete profile process.
  final bool isCompletingProfile;

  /// Has a `true` value if the user is incomplete profile.
  final bool isIncompleteProfile;

  /// Has a `true` value if the user is reset password process.
  final bool isResettingPassword;

  /// Has a `true` value if the app has a network error.
  final bool hasNetworkError;

  /// Has a `true` value if the app has an unhandled error.
  final bool hasUnhandledError;

  // /// Identifies the current user of the app.
  // final AuthUserInfo? authUserInfo;

  /// Creates a copy of the [RouterState] with the given parameters.
  RouterState copyWith({
    bool? isInitializing,
    bool? isLoggedIn,
    bool? isLoggingIn,
    bool? isRegistering,
    bool? isAccountUnverified,
    bool? isCompletingProfile,
    bool? isIncompleteProfile,
    bool? isResettingPassword,
    bool? hasNetworkError,
    bool? hasUnhandledError,
    // AuthUserInfo? authUserInfo,
  }) {
    return RouterState(
      isInitializing: isInitializing ?? this.isInitializing,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoggingIn: isLoggingIn ?? this.isLoggingIn,
      isRegistering: isRegistering ?? this.isRegistering,
      isAccountUnverified: isAccountUnverified ?? this.isAccountUnverified,
      isIncompleteProfile: isIncompleteProfile ?? this.isIncompleteProfile,
      isCompletingProfile: isCompletingProfile ?? this.isCompletingProfile,
      isResettingPassword: isResettingPassword ?? this.isResettingPassword,
      hasNetworkError: hasNetworkError ?? this.hasNetworkError,
      hasUnhandledError: hasUnhandledError ?? this.hasUnhandledError,
      // authUserInfo: authUserInfo ?? this.authUserInfo,
    );
  }

  @override
  List<Object?> get props => [
    isInitializing,
    isLoggedIn,
    isLoggingIn,
    isRegistering,
    isAccountUnverified,
    isIncompleteProfile,
    isCompletingProfile,
    isResettingPassword,
    hasNetworkError,
    hasUnhandledError,
    // authUserInfo,
  ];

  @override
  String toString() {
    return '''
    RouterState{isInitializing: $isInitializing, isLoggedIn: $isLoggedIn, isLoggingIn: $isLoggingIn,\n
    isRegistering: $isRegistering, isAccountUnverified: $isAccountUnverified,\n
    isIncompleteProfile: $isIncompleteProfile, isCompletingProfile: $isCompletingProfile,\n
    isResettingPassword: $isResettingPassword, hasNetworkError: $hasNetworkError,\n
    hasUnhandledError: $hasUnhandledError,\n
   
     }''';
  }
}

/// {@template RouterCubit}
/// A cubit that manages the state of the [router] for facilitating the
/// redirection rules in a reactive manner.
/// {@endtemplate}
class RouterCubit extends Cubit<RouterState> {
  /// {@macro RouterCubit}
  RouterCubit() : super(RouterState());

  /// Sets the [isInitializing] state.
  void setIsInitializing({required bool isInitializing}) {
    if (state.isInitializing == isInitializing) {
      return;
    }

    emit(
      state.copyWith(
        hasNetworkError: false,
        hasUnhandledError: false,
        isInitializing: isInitializing,
      ),
    );
  }

  /// Sets the [isLoggedIn] state.
  void setIsLoggedIn({required bool isLoggedIn}) {
    if (state.isLoggedIn == isLoggedIn) {
      return;
    }

    emit(
      state.copyWith(
        isRegistering: false,
        isLoggingIn: false,
        isLoggedIn: isLoggedIn,
      ),
    );
  }

  /// Sets the [isLoggingIn] state.
  void setIsLoggingIn({required bool isLoggingIn}) {
    if (state.isLoggingIn == isLoggingIn) {
      return;
    }

    emit(state.copyWith(isLoggingIn: isLoggingIn));
  }

  /// Sets the [isRegistering] state.
  void setIsRegistering({required bool isRegistering}) {
    if (state.isRegistering == isRegistering) {
      return;
    }

    emit(state.copyWith(isRegistering: isRegistering));
  }

  /// Sets the [isAccountUnverified] state.
  void isAccountUnverified({required bool isAccountUnverified}) {
    if (state.isAccountUnverified == isAccountUnverified) {
      return;
    }

    emit(state.copyWith(isAccountUnverified: isAccountUnverified));
  }

  /// Sets the [isCompletingProfile] state.
  void isCompletingProfile({required bool isCompletingProfile}) {
    if (state.isCompletingProfile == isCompletingProfile) {
      return;
    }

    emit(
      state.copyWith(
        isIncompleteProfile: false,
        isCompletingProfile: isCompletingProfile,
      ),
    );
  }

  /// Sets the [isIncompleteProfile] state.
  void isIncompleteProfile({required bool isIncompleteProfile}) {
    if (state.isIncompleteProfile == isIncompleteProfile) {
      return;
    }

    emit(state.copyWith(isIncompleteProfile: isIncompleteProfile));
  }

  /// Sets the [isResettingPassword] state.
  void isResettingPassword({required bool isResettingPassword}) {
    if (state.isResettingPassword == isResettingPassword) {
      return;
    }

    emit(state.copyWith(isResettingPassword: isResettingPassword));
  }

  /// Sets the [hasNetworkError] state.
  void hasNetworkError({required bool hasNetworkError}) {
    if (state.hasNetworkError == hasNetworkError) {
      return;
    }

    emit(
      state.copyWith(
        isInitializing: false,
        hasUnhandledError: false,
        hasNetworkError: hasNetworkError,
      ),
    );
  }

  /// Sets the [hasUnhandledError] state.
  void hasUnhandledError({required bool hasUnhandledError}) {
    if (state.hasUnhandledError == hasUnhandledError) {
      return;
    }

    emit(
      state.copyWith(
        isInitializing: false,
        hasNetworkError: false,
        hasUnhandledError: hasUnhandledError,
      ),
    );
  }
}
