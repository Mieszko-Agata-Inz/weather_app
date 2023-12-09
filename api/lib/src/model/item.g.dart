// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Item extends Item {
  @override
  final BuiltList<num> title;

  factory _$Item([void Function(ItemBuilder)? updates]) =>
      (new ItemBuilder()..update(updates))._build();

  _$Item._({required this.title}) : super._() {
    BuiltValueNullFieldError.checkNotNull(title, r'Item', 'title');
  }

  @override
  Item rebuild(void Function(ItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ItemBuilder toBuilder() => new ItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Item && title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Item')..add('title', title))
        .toString();
  }
}

class ItemBuilder implements Builder<Item, ItemBuilder> {
  _$Item? _$v;

  ListBuilder<num>? _title;
  ListBuilder<num> get title => _$this._title ??= new ListBuilder<num>();
  set title(ListBuilder<num>? title) => _$this._title = title;

  ItemBuilder() {
    Item._defaults(this);
  }

  ItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Item other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Item;
  }

  @override
  void update(void Function(ItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Item build() => _build();

  _$Item _build() {
    _$Item _$result;
    try {
      _$result = _$v ?? new _$Item._(title: title.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'title';
        title.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Item', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
