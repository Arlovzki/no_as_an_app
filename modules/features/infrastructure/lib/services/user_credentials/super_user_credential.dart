// import 'dart:developer';

// import 'package:core/environment_configuration.dart';
// import 'package:core/service_locator.dart';
// import 'package:domain/entities/authentication/user_credential.dart';
// import 'package:jose/jose.dart';
// import 'package:service/data/purego_oms_api/features/purego_oms_customer_feature.dart';
// import 'package:service/data/purego_oms_api/request_bodies/customer/purego_oms_customer_refresh_token_request_body.dart';
// import 'package:service/data/shared_preferences/preferences.dart';
// import 'package:service/services/utils/purego_customer_token_handler.dart';

// /// A super user credential is a specialized credential for this service
// /// infrastructure.
// ///
// /// It contains [accessToken] used for accessing customer-specific features in
// /// the Shopify API.
// ///
// /// This maintains a [puregoAccessToken] for accessing customer-specific
// /// features in the PureGo API.
// class SuperUserCredential extends UserCredential {
//   SuperUserCredential({
//     required super.accessToken,
//     required super.accessToken2,
//     required super.userId,
//     required super.isAnonymous,
//   });

//   String getCustomerId() => userId;

//   /// A data holder for the generated [puregoAccessToken].
//   String? _puregoAccessToken;

//   /// A short-lived token used to access customer-specific features in the
//   /// PureGo API.
//   ///
//   /// This token is short-lived and gets automatically refreshed once it
//   /// expires.
//   Future<String> puregoAccessToken() async {
//     log('USERID: $userId');

//     if (_puregoAccessToken != null &&
//         await isCustomerTokenValid(_puregoAccessToken!, userId)) {
//       return 'Bearer $_puregoAccessToken';
//     }

//     _puregoAccessToken = createCustomerToken(userId);

//     log('ACCESSTOKEN-RAPPIT: $_puregoAccessToken');

//     return 'Bearer $_puregoAccessToken';
//   }

//   /// A data holder for the generated [puregoAccessToken2].
//   String? _puregoAccessToken2;

//   /// A short-lived token used to access customer-specific features in the
//   /// PureGo OMS API.
//   ///
//   /// This token is short-lived and gets automatically refreshed once it
//   /// expires.
//   Future<String> puregoAccessToken2() async {
//     bool isValid = true;

//     final refreshTokenModel =
//         await serviceLocator<Preferences>().fetchRefreshToken();

//     if (_puregoAccessToken2 == null) {
//       isValid = false;
//     } else {
//       final signedToken = JsonWebSignature.fromCompactSerialization(
//         _puregoAccessToken2!,
//       );

//       final expirationInSeconds =
//           // ignore: avoid_dynamic_calls
//           signedToken.unverifiedPayload.jsonContent['exp'] as int?;

//       if (expirationInSeconds == null) {
//         isValid = false;
//       } else {
//         final expirationDate =
//             DateTime.fromMillisecondsSinceEpoch(expirationInSeconds * 1000);

//         final now = DateTime.now().add(const Duration(minutes: 5));

//         if (now.isAfter(expirationDate)) {
//           isValid = false;
//         }
//       }
//     }

//     if (isValid == false) {
//       final result =
//           await serviceLocator<PuregoOMSCustomerFeature>().refreshCustomerToken(
//         customerBearerToken: omsNonExpiringToken,
//         body: PuregoOMSCustomerRefreshTokenRequestBody(
//           refresh_token: refreshTokenModel!.token,
//         ),
//       );
//       _puregoAccessToken2 = result.body!.data.id_token;

//       return 'Bearer $_puregoAccessToken2';
//     }

//     log('ACCESSTOKEN-OMS: $_puregoAccessToken2');

//     return 'Bearer $_puregoAccessToken2';
//   }

//   @override
//   List<Object?> get props => super.props
//     ..add(_puregoAccessToken)
//     ..add(_puregoAccessToken2);
// }
