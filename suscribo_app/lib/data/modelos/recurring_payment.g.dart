// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_payment.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPagoRecurrenteCollection on Isar {
  IsarCollection<PagoRecurrente> get pagoRecurrentes => this.collection();
}

const PagoRecurrenteSchema = CollectionSchema(
  name: r'PagoRecurrente',
  id: -3975946500042600476,
  properties: {
    r'cicloPago': PropertySchema(
      id: 0,
      name: r'cicloPago',
      type: IsarType.string,
      enumMap: _PagoRecurrentecicloPagoEnumValueMap,
    ),
    r'diasNotificacion': PropertySchema(
      id: 1,
      name: r'diasNotificacion',
      type: IsarType.long,
    ),
    r'monto': PropertySchema(
      id: 2,
      name: r'monto',
      type: IsarType.double,
    ),
    r'nombre': PropertySchema(
      id: 3,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'proximaFechaPago': PropertySchema(
      id: 4,
      name: r'proximaFechaPago',
      type: IsarType.dateTime,
    ),
    r'tipoPago': PropertySchema(
      id: 5,
      name: r'tipoPago',
      type: IsarType.string,
      enumMap: _PagoRecurrentetipoPagoEnumValueMap,
    )
  },
  estimateSize: _pagoRecurrenteEstimateSize,
  serialize: _pagoRecurrenteSerialize,
  deserialize: _pagoRecurrenteDeserialize,
  deserializeProp: _pagoRecurrenteDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _pagoRecurrenteGetId,
  getLinks: _pagoRecurrenteGetLinks,
  attach: _pagoRecurrenteAttach,
  version: '3.1.0+1',
);

int _pagoRecurrenteEstimateSize(
  PagoRecurrente object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cicloPago.name.length * 3;
  bytesCount += 3 + object.nombre.length * 3;
  bytesCount += 3 + object.tipoPago.name.length * 3;
  return bytesCount;
}

void _pagoRecurrenteSerialize(
  PagoRecurrente object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cicloPago.name);
  writer.writeLong(offsets[1], object.diasNotificacion);
  writer.writeDouble(offsets[2], object.monto);
  writer.writeString(offsets[3], object.nombre);
  writer.writeDateTime(offsets[4], object.proximaFechaPago);
  writer.writeString(offsets[5], object.tipoPago.name);
}

PagoRecurrente _pagoRecurrenteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PagoRecurrente(
    cicloPago: _PagoRecurrentecicloPagoValueEnumMap[
            reader.readStringOrNull(offsets[0])] ??
        CicloPago.SEMANAL,
    diasNotificacion: reader.readLongOrNull(offsets[1]) ?? 3,
    monto: reader.readDouble(offsets[2]),
    nombre: reader.readString(offsets[3]),
    proximaFechaPago: reader.readDateTime(offsets[4]),
    tipoPago: _PagoRecurrentetipoPagoValueEnumMap[
            reader.readStringOrNull(offsets[5])] ??
        TipoPago.SUSCRIPCION,
  );
  object.id = id;
  return object;
}

P _pagoRecurrenteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_PagoRecurrentecicloPagoValueEnumMap[
              reader.readStringOrNull(offset)] ??
          CicloPago.SEMANAL) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 3) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (_PagoRecurrentetipoPagoValueEnumMap[
              reader.readStringOrNull(offset)] ??
          TipoPago.SUSCRIPCION) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PagoRecurrentecicloPagoEnumValueMap = {
  r'SEMANAL': r'SEMANAL',
  r'MENSUAL': r'MENSUAL',
  r'TRIMESTRAL': r'TRIMESTRAL',
  r'ANUAL': r'ANUAL',
};
const _PagoRecurrentecicloPagoValueEnumMap = {
  r'SEMANAL': CicloPago.SEMANAL,
  r'MENSUAL': CicloPago.MENSUAL,
  r'TRIMESTRAL': CicloPago.TRIMESTRAL,
  r'ANUAL': CicloPago.ANUAL,
};
const _PagoRecurrentetipoPagoEnumValueMap = {
  r'SUSCRIPCION': r'SUSCRIPCION',
  r'SERVICIO': r'SERVICIO',
};
const _PagoRecurrentetipoPagoValueEnumMap = {
  r'SUSCRIPCION': TipoPago.SUSCRIPCION,
  r'SERVICIO': TipoPago.SERVICIO,
};

Id _pagoRecurrenteGetId(PagoRecurrente object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pagoRecurrenteGetLinks(PagoRecurrente object) {
  return [];
}

void _pagoRecurrenteAttach(
    IsarCollection<dynamic> col, Id id, PagoRecurrente object) {
  object.id = id;
}

extension PagoRecurrenteQueryWhereSort
    on QueryBuilder<PagoRecurrente, PagoRecurrente, QWhere> {
  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PagoRecurrenteQueryWhere
    on QueryBuilder<PagoRecurrente, PagoRecurrente, QWhereClause> {
  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PagoRecurrenteQueryFilter
    on QueryBuilder<PagoRecurrente, PagoRecurrente, QFilterCondition> {
  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      cicloPagoEqualTo(
    CicloPago value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cicloPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      cicloPagoGreaterThan(
    CicloPago value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cicloPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      cicloPagoLessThan(
    CicloPago value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cicloPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      cicloPagoBetween(
    CicloPago lower,
    CicloPago upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cicloPago',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      cicloPagoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cicloPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      cicloPagoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cicloPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      cicloPagoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cicloPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      cicloPagoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cicloPago',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      cicloPagoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cicloPago',
        value: '',
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      cicloPagoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cicloPago',
        value: '',
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      diasNotificacionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diasNotificacion',
        value: value,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      diasNotificacionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diasNotificacion',
        value: value,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      diasNotificacionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diasNotificacion',
        value: value,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      diasNotificacionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diasNotificacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      montoEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monto',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      montoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monto',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      montoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monto',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      montoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monto',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      nombreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      nombreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      nombreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      nombreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      nombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      proximaFechaPagoEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proximaFechaPago',
        value: value,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      proximaFechaPagoGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proximaFechaPago',
        value: value,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      proximaFechaPagoLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proximaFechaPago',
        value: value,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      proximaFechaPagoBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proximaFechaPago',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      tipoPagoEqualTo(
    TipoPago value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      tipoPagoGreaterThan(
    TipoPago value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      tipoPagoLessThan(
    TipoPago value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      tipoPagoBetween(
    TipoPago lower,
    TipoPago upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipoPago',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      tipoPagoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      tipoPagoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      tipoPagoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      tipoPagoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoPago',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      tipoPagoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoPago',
        value: '',
      ));
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterFilterCondition>
      tipoPagoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoPago',
        value: '',
      ));
    });
  }
}

extension PagoRecurrenteQueryObject
    on QueryBuilder<PagoRecurrente, PagoRecurrente, QFilterCondition> {}

extension PagoRecurrenteQueryLinks
    on QueryBuilder<PagoRecurrente, PagoRecurrente, QFilterCondition> {}

extension PagoRecurrenteQuerySortBy
    on QueryBuilder<PagoRecurrente, PagoRecurrente, QSortBy> {
  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy> sortByCicloPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cicloPago', Sort.asc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      sortByCicloPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cicloPago', Sort.desc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      sortByDiasNotificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diasNotificacion', Sort.asc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      sortByDiasNotificacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diasNotificacion', Sort.desc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy> sortByMonto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monto', Sort.asc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy> sortByMontoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monto', Sort.desc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      sortByProximaFechaPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximaFechaPago', Sort.asc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      sortByProximaFechaPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximaFechaPago', Sort.desc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy> sortByTipoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.asc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      sortByTipoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.desc);
    });
  }
}

extension PagoRecurrenteQuerySortThenBy
    on QueryBuilder<PagoRecurrente, PagoRecurrente, QSortThenBy> {
  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy> thenByCicloPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cicloPago', Sort.asc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      thenByCicloPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cicloPago', Sort.desc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      thenByDiasNotificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diasNotificacion', Sort.asc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      thenByDiasNotificacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diasNotificacion', Sort.desc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy> thenByMonto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monto', Sort.asc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy> thenByMontoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monto', Sort.desc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      thenByProximaFechaPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximaFechaPago', Sort.asc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      thenByProximaFechaPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximaFechaPago', Sort.desc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy> thenByTipoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.asc);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QAfterSortBy>
      thenByTipoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.desc);
    });
  }
}

extension PagoRecurrenteQueryWhereDistinct
    on QueryBuilder<PagoRecurrente, PagoRecurrente, QDistinct> {
  QueryBuilder<PagoRecurrente, PagoRecurrente, QDistinct> distinctByCicloPago(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cicloPago', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QDistinct>
      distinctByDiasNotificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diasNotificacion');
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QDistinct> distinctByMonto() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monto');
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QDistinct>
      distinctByProximaFechaPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proximaFechaPago');
    });
  }

  QueryBuilder<PagoRecurrente, PagoRecurrente, QDistinct> distinctByTipoPago(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoPago', caseSensitive: caseSensitive);
    });
  }
}

extension PagoRecurrenteQueryProperty
    on QueryBuilder<PagoRecurrente, PagoRecurrente, QQueryProperty> {
  QueryBuilder<PagoRecurrente, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PagoRecurrente, CicloPago, QQueryOperations>
      cicloPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cicloPago');
    });
  }

  QueryBuilder<PagoRecurrente, int, QQueryOperations>
      diasNotificacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diasNotificacion');
    });
  }

  QueryBuilder<PagoRecurrente, double, QQueryOperations> montoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monto');
    });
  }

  QueryBuilder<PagoRecurrente, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<PagoRecurrente, DateTime, QQueryOperations>
      proximaFechaPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proximaFechaPago');
    });
  }

  QueryBuilder<PagoRecurrente, TipoPago, QQueryOperations> tipoPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoPago');
    });
  }
}
