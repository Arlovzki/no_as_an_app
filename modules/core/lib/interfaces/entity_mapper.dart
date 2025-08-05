/// An interface that mandates its inheritors to have a mapper to an entity [T].
abstract class EntityMapper<T> {
  /// Abstract function that returns [T].
  T toEntity();
}
