// import 'package:application/blocs/abstracts/runner/runner_cubit.dart';
// import 'package:dartz/dartz.dart';
// import 'package:domain/entities/cart/cart_check_result.dart';
// import 'package:domain/entities/order/order_item.dart';
// import 'package:domain/failures/failure.dart';
// import 'package:domain/services/cart_service.dart';

// /// See [CartService.setCartItems].
// class SetCartItemsCubit
//     extends RunnerCubit<SetCartItemsParams, CartCheckResult> {
//   SetCartItemsCubit({required CartService cartService})
//       : _cartService = cartService;

//   final CartService _cartService;

//   @override
//   Future<Either<Failure, CartCheckResult>> onRun({
//     required SetCartItemsParams params,
//   }) =>
//       _cartService.setCartItems(
//         cartItems: params.cartItems,
//         overwrite: params.overwrite,
//       );
// }

// class SetCartItemsParams {
//   const SetCartItemsParams({
//     required this.cartItems,
//     this.overwrite = true,
//   });

//   final List<OrderItem> cartItems;
//   final bool overwrite;
// }
