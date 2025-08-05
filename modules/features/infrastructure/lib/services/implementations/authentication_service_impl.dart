// import 'package:core/device_info/device_info.dart';
// import 'package:core/environment_configuration.dart';
// import 'package:core/logger/logger.dart';
// import 'package:dartz/dartz.dart';
// import 'package:domain/entities/authentication/user_credential.dart';
// import 'package:domain/failures/authentication/age_is_not_qualified_failure.dart';
// import 'package:domain/failures/authentication/cognito_temporary_credentials_failure.dart';
// import 'package:domain/failures/authentication/email_and_password_mismatch_failure.dart';
// import 'package:domain/failures/authentication/email_does_not_exist_failure.dart';
// import 'package:domain/failures/authentication/email_exists_failure.dart';
// import 'package:domain/failures/authentication/email_or_mobile_number_exists_failure.dart';
// import 'package:domain/failures/authentication/mobile_number_exists_failure.dart';
// import 'package:domain/failures/authentication/no_refresh_token_failure.dart';
// import 'package:domain/failures/authentication/registered_but_failed_sign_in_failure.dart';
// import 'package:domain/failures/failure.dart';
// import 'package:domain/services/auth_user_service.dart';
// import 'package:domain/services/authentication_service.dart';
// import 'package:flutter_segment/flutter_segment.dart';
// import 'package:jose/jose.dart';
// import 'package:service/data/purego_api/response_bodies/error/purego_base_error_response_body.dart';
// import 'package:service/data/purego_oms_api/features/purego_oms_customer_feature.dart';
// import 'package:service/data/purego_oms_api/request_bodies/customer/purego_oms_customer_info_request_body.dart';
// import 'package:service/data/purego_oms_api/request_bodies/customer/purego_oms_customer_refresh_token_request_body.dart';
// import 'package:service/data/purego_oms_api/request_bodies/customer/purego_oms_initiate_auth_request_body.dart';
// import 'package:service/data/purego_oms_api/request_bodies/customer/purego_oms_initiate_reset_password_request_body.dart';
// import 'package:service/data/shared_preferences/models/pref_refresh_token_model.dart';
// import 'package:service/data/shared_preferences/preferences.dart';
// import 'package:service/services/exception_converters/convert_exception.dart';
// import 'package:service/services/exception_converters/socket_exception_converter.dart';
// import 'package:service/services/user_credentials/super_user_credential.dart';
// import 'package:service/services/utils/birthdate_format.dart';
// import 'package:service/services/utils/mobile_number_format.dart';
// import 'package:service/services/utils/rsa_password_utils.dart';

// class AuthenticationServiceImpl implements AuthenticationService {
//   AuthenticationServiceImpl({
//     required Logger logger,
//     required Preferences preferences,
//     required PuregoOMSCustomerFeature puregoOMSCustomerFeature,
//     required AuthUserService authUserService,
//   })  : _logger = logger,
//         _preferences = preferences,
//         _puregoOMSCustomerFeature = puregoOMSCustomerFeature,
//         _authUserService = authUserService;

//   final Logger _logger;
//   final Preferences _preferences;
//   final PuregoOMSCustomerFeature _puregoOMSCustomerFeature;
//   final AuthUserService _authUserService;

//   /// The default access token assigned to guest users.
//   final _guestToken = 'GUEST_TOKEN';

//   /// The default guest ID assigned to guest users.
//   final _guestId = 'Guest:${deviceInfo.deviceId}';

//   @override
//   Future<Either<Failure, bool>> isEmailRegistered({
//     required String email,
//   }) async {
//     // This feature is currently on hold due to a broken implementation in the
//     // PureGo API.
//     //
//     // At the moment, email verification is done in
//     // [registerWithEmailAndPassword] which rejects any registration attempts
//     // that uses an already registered email.
//     return const Right(false);
//   }

//   @override
//   Future<Either<Failure, UserCredential>> registerWithEmailAndPassword({
//     required String email,
//     required String password,
//     required String firstName,
//     required String lastName,
//     required String mobileNumber,
//     required String gender,
//     required String birthDate,
//     required bool acceptsMarketing,
//   }) async {
//     final convertedBirthdate = convertToBackendDateFormat(birthDate);

//     final encryptedPassword = await encryptRSAPassword(password);

//     final messageLog = MessageLog(
//       id: 'authentication-service-register-with-email-and-password',
//       data: {
//         'email': email,
//         'password': encryptedPassword,
//         'firstName': firstName,
//         'lastName': lastName,
//         'mobileNumber': mobileNumber,
//         'gender': gender,
//         'birthDate': convertedBirthdate,
//         'acceptsMarketing': acceptsMarketing,
//       },
//     );

//     return convertExceptionIfThrown<UserCredential>(
//       logger: _logger,
//       messageLog: messageLog,
//       exceptionConverters: [const SocketExceptionConverter()],
//       action: () async {
//         final registerResult = await _puregoOMSCustomerFeature.customerRegister(
//           customerBearerToken: omsNonExpiringToken,
//           body: PuregoOMSCustomerInfoRequestBody(
//             first_name: firstName,
//             last_name: lastName,
//             gender: gender,
//             mobile_phone: format63MobileNumber(mobileNumber),
//             email: email,
//             birthdate: convertedBirthdate,
//             password: encryptedPassword,
//             accepts_marketing: acceptsMarketing,
//           ),
//         );

//         if (!registerResult.isSuccessful) {
//           final errorResponse =
//               registerResult.error! as PuregoBaseErrorResponseBody;

//           final error = errorResponse.error;

//           messageLog.data['error'] = error.toJson();

//           switch (error.status) {
//             case 'DUPLICATE_DATA':
//               _logger.warn(
//                 messageLog..message = 'Email or mobile number exists',
//               );
//               return const Left(EmailOrMobileNumberExistsFailure());
//             case 'EMAIL_EXIST_FAILURE':
//               _logger.warn(messageLog..message = 'Duplicate email error');
//               return const Left(
//                 EmailExistsFailure(),
//               );
//             case 'MOBILE_NUMBER_EXIST_FAILURE':
//               _logger
//                   .warn(messageLog..message = 'Duplicate mobile number error');
//               return const Left(
//                 MobileNumberExistsFailure(),
//               );
//             case 'AGE_NOT_QUALIFIED':
//               _logger.warn(
//                 messageLog
//                   ..message = 'Minimum age is 13 years old to register.',
//               );
//               return const Left(AgeIsNotQualifiedFailure());

//             default:
//               _logger.error(messageLog..message = 'Unhandled response');
//               return const Left(Failure());
//           }
//         }

//         _logger.info(messageLog..message = 'Success');

//         //Segment tracking for registration
//         await Segment.track(
//           eventName: 'Customer Registered',
//           properties: {
//             'birthday': convertedBirthdate,
//             'email': email,
//             'first_name': firstName,
//             'last_name': lastName,
//             'gender': gender,
//             'phone': mobileNumber,
//             'customerType': 'organic' // static
//           },
//         );

//         // Sign in after registration
//         final signInWithUsernameAndPasswordResult =
//             await signInWithUserNameAndPassword(
//           username: email,
//           password: password,
//         );

//         return signInWithUsernameAndPasswordResult.fold(
//           (l) async => const Left(RegisteredButFailedSignInFailure()),
//           (r) => signInWithUsernameAndPasswordResult,
//         );
//       },
//     );
//   }

//   @override
//   Future<Either<Failure, void>> sendPasswordResetLink({
//     required String username,
//   }) async {
//     final messageLog = MessageLog(
//       id: 'authentication-service-send-password-reset-link',
//       data: {'username': username},
//     );

//     return convertExceptionIfThrown<void>(
//       logger: _logger,
//       messageLog: messageLog,
//       exceptionConverters: [const SocketExceptionConverter()],
//       action: () async {
//         final initiateResetPassResult =
//             await _puregoOMSCustomerFeature.initiateResetPassword(
//           customerBearerToken: omsNonExpiringToken,
//           body: PuregoOMSInitiateResetPasswordRequestBody(
//             username: username,
//           ),
//         );

//         if (!initiateResetPassResult.isSuccessful) {
//           final errorResponse =
//               initiateResetPassResult.error! as PuregoBaseErrorResponseBody;

//           final error = errorResponse.error;

//           messageLog.data['error'] = error.toJson();

//           switch (error.status) {
//             case 'CUSTOMER_NOT_FOUND':
//               _logger.warn(messageLog..message = 'User does not exist');
//               return const Left(EmailDoesNotExistFailure());
//             default:
//               _logger.error(messageLog..message = 'Unhandled response');
//               return const Left(Failure());
//           }
//         }

//         _logger.info(messageLog..message = 'Success');

//         return const Right(null);
//       },
//     );
//   }

//   @override
//   Future<Either<Failure, UserCredential>> signInWithUserNameAndPassword({
//     required String username,
//     required String password,
//   }) async {
//     final messageLog = MessageLog(
//       id: 'authentication-service-sign-in-with-username-and-password',
//     );

//     return convertExceptionIfThrown<UserCredential>(
//       logger: _logger,
//       messageLog: messageLog,
//       exceptionConverters: [const SocketExceptionConverter()],
//       action: () async {
//         final encryptedPassword = await encryptRSAPassword(password);

//         final initiateAuthResult = await _puregoOMSCustomerFeature.initiateAuth(
//           customerBearerToken: omsNonExpiringToken,
//           body: PuregoOMSInitiateAuthRequestBody(
//             username: username,
//             password: encryptedPassword,
//           ),
//         );

//         if (!initiateAuthResult.isSuccessful) {
//           final errorResponse =
//               initiateAuthResult.error! as PuregoBaseErrorResponseBody;

//           final error = errorResponse.error;

//           messageLog.data['error'] = error.toJson();

//           switch (error.status) {
//             case 'COGNITO_TEMPORARY_CREDENTIALS':
//               _logger.warn(messageLog..message = 'Cognito temporary failure');

//               return const Left(CognitoTemporaryCredentialsFailure());
//             case 'COGNITO_INVALID_CREDENTIALS':
//               _logger.warn(messageLog..message = 'Cognito user does not exist');
//               return const Left(EmailAndPasswordMismatchFailure());
//             default:
//               _logger.error(messageLog..message = 'Unhandled response');
//               return const Left(Failure());
//           }
//         }

//         final successResult = initiateAuthResult.body!.data;

//         // Save refresh token of the PureGO OMS API in local storage
//         // It will be used for fetching another access token for PureGO OMS API

//         await _preferences.setRefreshToken(
//           model: PrefRefreshTokenModel(token: successResult.refresh_token),
//         );

//         final customerId = successResult.customer_id.toString();

//         _logger.userId = customerId;

//         final userCredential = SuperUserCredential(
//           accessToken: successResult.id_token,
//           accessToken2: successResult.id_token,
//           userId: customerId,
//           isAnonymous: false,
//         );

//         _logger.info(
//           messageLog
//             ..message = 'Success'
//             ..data.addAll({'userCredential': userCredential}),
//         );

//         final signedToken =
//             JsonWebSignature.fromCompactSerialization(successResult.id_token);

//         final name =
//             signedToken.unverifiedPayload.jsonContent['name'] as String?;
//         final email =
//             signedToken.unverifiedPayload.jsonContent['email'] as String?;

//         _authUserService.refreshAuthUserInfo();

//         //Segment tracking for login
//         Segment.track(
//           eventName: 'Customer Login',
//           properties: {
//             'customerName': name,
//             'email': email,
//           },
//         );

//         return Right(userCredential);
//       },
//     );
//   }

//   @override
//   Future<Either<Failure, UserCredential>> signInAnonymously() async {
//     final messageLog =
//         MessageLog(id: 'authentication-service-sign-in-anonymously');

//     await _preferences.setRefreshToken(
//       model: PrefRefreshTokenModel(token: _guestToken),
//     );

//     _logger.userId = _guestId;

//     final userCredential = SuperUserCredential(
//       accessToken: _guestToken,
//       accessToken2: '',
//       userId: _guestId,
//       isAnonymous: true,
//     );

//     _logger.info(
//       messageLog
//         ..message = 'Success'
//         ..data.addAll({'userCredential': userCredential}),
//     );

//     return Right(userCredential);
//   }

//   @override
//   Future<Either<Failure, UserCredential>> signInSilently() async {
//     final messageLog =
//         MessageLog(id: 'authentication-service-sign-in-silently');

//     final refreshTokenModel = await _preferences.fetchRefreshToken();

//     if (refreshTokenModel == null) {
//       _logger.warn(messageLog..message = 'No refresh token');
//       return const Left(NoRefreshTokenFailure());
//     }

//     if (refreshTokenModel.token == _guestToken) {
//       _logger.userId = _guestId;

//       final userCredential = SuperUserCredential(
//         accessToken: "guest_token",
//         accessToken2: "guest_token",
//         userId: _guestId,
//         isAnonymous: true,
//       );

//       _logger.info(
//         messageLog
//           ..message = 'Success'
//           ..data.addAll({'userCredential': userCredential}),
//       );

//       return Right(userCredential);
//     }

//     return convertExceptionIfThrown<UserCredential>(
//       logger: _logger,
//       messageLog: messageLog,
//       exceptionConverters: [const SocketExceptionConverter()],
//       action: () async {
//         final refreshCustomerTokenResult =
//             await _puregoOMSCustomerFeature.refreshCustomerToken(
//           customerBearerToken: omsNonExpiringToken,
//           body: PuregoOMSCustomerRefreshTokenRequestBody(
//             refresh_token: refreshTokenModel.token,
//           ),
//         );

//         if (!refreshCustomerTokenResult.isSuccessful) {
//           final errorResponse =
//               refreshCustomerTokenResult.error! as PuregoBaseErrorResponseBody;

//           final error = errorResponse.error;

//           messageLog.data['error'] = error.toJson();

//           switch (error.status) {
//             default:
//               // If an error occurs, this may mean that the refresh token is
//               // invalid. Hence, remove it from the local storage
//               await _preferences.setRefreshToken(model: null);

//               _logger.error(messageLog..message = 'Unhandled response');
//               return const Left(Failure());
//           }
//         }

//         final successResult = refreshCustomerTokenResult.body!.data;

//         _logger.userId = successResult.customer_id.toString();

//         final userCredential = SuperUserCredential(
//           accessToken: successResult.id_token,
//           accessToken2: successResult.id_token,
//           userId: successResult.customer_id.toString(),
//           isAnonymous: false,
//         );

//         _logger.info(
//           messageLog
//             ..message = 'Success'
//             ..data.addAll({'userCredential': userCredential}),
//         );

//         _authUserService.refreshAuthUserInfo();

//         return Right(userCredential);
//       },
//     );
//   }

//   @override
//   Future<Either<Failure, void>> signOut() async {
//     final messageLog = MessageLog(id: 'authentication-service-sign-out');

//     final refreshTokenModel = await _preferences.fetchRefreshToken();

//     if (refreshTokenModel == null) {
//       _logger.warn(messageLog..message = 'No signed in user');
//       return const Right(null);
//     }

//     await _preferences.setRefreshToken(model: null);

//     _logger.userId = null;
//     _logger.info(messageLog..message = 'Success');

//     return const Right(null);
//   }
// }
