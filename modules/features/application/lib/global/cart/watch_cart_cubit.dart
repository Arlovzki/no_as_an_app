// import 'package:application/blocs/abstracts/watcher/watcher_cubit.dart';
// import 'package:dartz/dartz.dart';
// import 'package:domain/entities/cart/cart.dart';
// import 'package:domain/failures/failure.dart';
// import 'package:domain/services/cart_service.dart';

// /// Returns a [Cart] stream.
// ///
// /// This returns the latest [Cart] value upon streaming.
// ///
// /// Empty carts are represented by [Cart.empty]. This does not emit a `null`
// /// value.
// class WatchCartCubit extends WatcherCubit<Cart> {
//   WatchCartCubit({required CartService cartService})
//       : _cartService = cartService;

//   final CartService _cartService;

//   @override
//   Future<Either<Failure, Stream<Cart>>> onWatch() => _cartService.watchCart();
// }
