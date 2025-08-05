// import 'package:application/blocs/abstracts/runner/runner_cubit.dart';
// import 'package:dartz/dartz.dart';
// import 'package:domain/failures/failure.dart';
// import 'package:domain/services/cart_service.dart';

// /// See [CartService.removeCartItems].
// class RemoveCartItemsCubit extends RunnerCubit<RemoveCartItemsParams, void> {
//   RemoveCartItemsCubit({required CartService cartService})
//       : _cartService = cartService;

//   final CartService _cartService;

//   @override
//   Future<Either<Failure, void>> onRun({required RemoveCartItemsParams params}) =>
//       _cartService.removeCartItems(variantIds: params.cartItemVariantIds);
// }

// class RemoveCartItemsParams {
//   const RemoveCartItemsParams({required this.cartItemVariantIds});

//   final List<String> cartItemVariantIds;
// }
