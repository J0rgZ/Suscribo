// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historial_pago.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHistorialPagoCollection on Isar {
  IsarCollection<HistorialPago> get historialPagos => this.collection();
}

const HistorialPagoSchema = CollectionSchema(
  name: r'HistorialPago',
  id: -9035938580071355694,
  properties: {
    r'cicloPago': PropertySchema(
      id: 0,
      name: r'cicloPago',
      type: IsarType.string,
      enumMap: _HistorialPagocicloPagoEnumValueMap,
    ),
    r'fechaRegistro': PropertySchema(
      id: 1,
      name: r'fechaRegistro',
      type: IsarType.dateTime,
    ),
    r'metodoPago': PropertySchema(
      id: 2,
      name: r'metodoPago',
      type: IsarType.string,
    ),
    r'montoPagado': PropertySchema(
      id: 3,
      name: r'montoPagado',
      type: IsarType.double,
    ),
    r'nombre': PropertySchema(
      id: 4,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'numeroOperacion': PropertySchema(
      id: 5,
      name: r'numeroOperacion',
      type: IsarType.string,
    ),
    r'pagoId': PropertySchema(
      id: 6,
      name: r'pagoId',
      type: IsarType.long,
    ),
    r'rutaComprobante': PropertySchema(
      id: 7,
      name: r'rutaComprobante',
      type: IsarType.string,
    ),
    r'tipoPago': PropertySchema(
      id: 8,
      name: r'tipoPago',
      type: IsarType.string,
      enumMap: _HistorialPagotipoPagoEnumValueMap,
    )
  },
  estimateSize: _historialPagoEstimateSize,
  serialize: _historialPagoSerialize,
  deserialize: _historialPagoDeserialize,
  deserializeProp: _historialPagoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _historialPagoGetId,
  getLinks: _historialPagoGetLinks,
  attach: _historialPagoAttach,
  version: '3.1.0+1',
);

int _historialPagoEstimateSize(
  HistorialPago object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cicloPago.name.length * 3;
  {
    final value = object.metodoPago;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.nombre.length * 3;
  {
    final value = object.numeroOperacion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.rutaComprobante;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.tipoPago.name.length * 3;
  return bytesCount;
}

void _historialPagoSerialize(
  HistorialPago object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cicloPago.name);
  writer.writeDateTime(offsets[1], object.fechaRegistro);
  writer.writeString(offsets[2], object.metodoPago);
  writer.writeDouble(offsets[3], object.montoPagado);
  writer.writeString(offsets[4], object.nombre);
  writer.writeString(offsets[5], object.numeroOperacion);
  writer.writeLong(offsets[6], object.pagoId);
  writer.writeString(offsets[7], object.rutaComprobante);
  writer.writeString(offsets[8], object.tipoPago.name);
}

HistorialPago _historialPagoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HistorialPago(
    cicloPago: _HistorialPagocicloPagoValueEnumMap[
            reader.readStringOrNull(offsets[0])] ??
        CicloPago.SEMANAL,
    fechaRegistro: reader.readDateTime(offsets[1]),
    metodoPago: reader.readStringOrNull(offsets[2]),
    montoPagado: reader.readDouble(offsets[3]),
    nombre: reader.readString(offsets[4]),
    numeroOperacion: reader.readStringOrNull(offsets[5]),
    pagoId: reader.readLong(offsets[6]),
    rutaComprobante: reader.readStringOrNull(offsets[7]),
    tipoPago: _HistorialPagotipoPagoValueEnumMap[
            reader.readStringOrNull(offsets[8])] ??
        TipoPago.SUSCRIPCION,
  );
  object.id = id;
  return object;
}

P _historialPagoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_HistorialPagocicloPagoValueEnumMap[
              reader.readStringOrNull(offset)] ??
          CicloPago.SEMANAL) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (_HistorialPagotipoPagoValueEnumMap[
              reader.readStringOrNull(offset)] ??
          TipoPago.SUSCRIPCION) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _HistorialPagocicloPagoEnumValueMap = {
  r'SEMANAL': r'SEMANAL',
  r'MENSUAL': r'MENSUAL',
  r'TRIMESTRAL': r'TRIMESTRAL',
  r'ANUAL': r'ANUAL',
};
const _HistorialPagocicloPagoValueEnumMap = {
  r'SEMANAL': CicloPago.SEMANAL,
  r'MENSUAL': CicloPago.MENSUAL,
  r'TRIMESTRAL': CicloPago.TRIMESTRAL,
  r'ANUAL': CicloPago.ANUAL,
};
const _HistorialPagotipoPagoEnumValueMap = {
  r'SUSCRIPCION': r'SUSCRIPCION',
  r'SERVICIO': r'SERVICIO',
};
const _HistorialPagotipoPagoValueEnumMap = {
  r'SUSCRIPCION': TipoPago.SUSCRIPCION,
  r'SERVICIO': TipoPago.SERVICIO,
};

Id _historialPagoGetId(HistorialPago object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _historialPagoGetLinks(HistorialPago object) {
  return [];
}

void _historialPagoAttach(
    IsarCollection<dynamic> col, Id id, HistorialPago object) {
  object.id = id;
}

extension HistorialPagoQueryWhereSort
    on QueryBuilder<HistorialPago, HistorialPago, QWhere> {
  QueryBuilder<HistorialPago, HistorialPago, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HistorialPagoQueryWhere
    on QueryBuilder<HistorialPago, HistorialPago, QWhereClause> {
  QueryBuilder<HistorialPago, HistorialPago, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterWhereClause> idBetween(
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

extension HistorialPagoQueryFilter
    on QueryBuilder<HistorialPago, HistorialPago, QFilterCondition> {
  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      cicloPagoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cicloPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      cicloPagoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cicloPago',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      cicloPagoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cicloPago',
        value: '',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      cicloPagoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cicloPago',
        value: '',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      fechaRegistroEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      fechaRegistroGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      fechaRegistroLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      fechaRegistroBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaRegistro',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition> idBetween(
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      metodoPagoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'metodoPago',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      metodoPagoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'metodoPago',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      metodoPagoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metodoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      metodoPagoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'metodoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      metodoPagoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'metodoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      metodoPagoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'metodoPago',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      metodoPagoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'metodoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      metodoPagoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'metodoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      metodoPagoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'metodoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      metodoPagoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'metodoPago',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      metodoPagoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metodoPago',
        value: '',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      metodoPagoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'metodoPago',
        value: '',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      montoPagadoEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'montoPagado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      montoPagadoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'montoPagado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      montoPagadoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'montoPagado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      montoPagadoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'montoPagado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      nombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      numeroOperacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numeroOperacion',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      numeroOperacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numeroOperacion',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      numeroOperacionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroOperacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      numeroOperacionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numeroOperacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      numeroOperacionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numeroOperacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      numeroOperacionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numeroOperacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      numeroOperacionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'numeroOperacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      numeroOperacionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'numeroOperacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      numeroOperacionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'numeroOperacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      numeroOperacionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'numeroOperacion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      numeroOperacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numeroOperacion',
        value: '',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      numeroOperacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'numeroOperacion',
        value: '',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      pagoIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pagoId',
        value: value,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      pagoIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pagoId',
        value: value,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      pagoIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pagoId',
        value: value,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      pagoIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pagoId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      rutaComprobanteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rutaComprobante',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      rutaComprobanteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rutaComprobante',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      rutaComprobanteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rutaComprobante',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      rutaComprobanteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rutaComprobante',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      rutaComprobanteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rutaComprobante',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      rutaComprobanteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rutaComprobante',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      rutaComprobanteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rutaComprobante',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      rutaComprobanteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rutaComprobante',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      rutaComprobanteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rutaComprobante',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      rutaComprobanteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rutaComprobante',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      rutaComprobanteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rutaComprobante',
        value: '',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      rutaComprobanteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rutaComprobante',
        value: '',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
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

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      tipoPagoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoPago',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      tipoPagoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoPago',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      tipoPagoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoPago',
        value: '',
      ));
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterFilterCondition>
      tipoPagoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoPago',
        value: '',
      ));
    });
  }
}

extension HistorialPagoQueryObject
    on QueryBuilder<HistorialPago, HistorialPago, QFilterCondition> {}

extension HistorialPagoQueryLinks
    on QueryBuilder<HistorialPago, HistorialPago, QFilterCondition> {}

extension HistorialPagoQuerySortBy
    on QueryBuilder<HistorialPago, HistorialPago, QSortBy> {
  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> sortByCicloPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cicloPago', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      sortByCicloPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cicloPago', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      sortByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      sortByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> sortByMetodoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metodoPago', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      sortByMetodoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metodoPago', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> sortByMontoPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'montoPagado', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      sortByMontoPagadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'montoPagado', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      sortByNumeroOperacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroOperacion', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      sortByNumeroOperacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroOperacion', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> sortByPagoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagoId', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> sortByPagoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagoId', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      sortByRutaComprobante() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rutaComprobante', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      sortByRutaComprobanteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rutaComprobante', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> sortByTipoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      sortByTipoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.desc);
    });
  }
}

extension HistorialPagoQuerySortThenBy
    on QueryBuilder<HistorialPago, HistorialPago, QSortThenBy> {
  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> thenByCicloPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cicloPago', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      thenByCicloPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cicloPago', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      thenByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      thenByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> thenByMetodoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metodoPago', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      thenByMetodoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metodoPago', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> thenByMontoPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'montoPagado', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      thenByMontoPagadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'montoPagado', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      thenByNumeroOperacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroOperacion', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      thenByNumeroOperacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroOperacion', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> thenByPagoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagoId', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> thenByPagoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagoId', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      thenByRutaComprobante() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rutaComprobante', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      thenByRutaComprobanteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rutaComprobante', Sort.desc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy> thenByTipoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.asc);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QAfterSortBy>
      thenByTipoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoPago', Sort.desc);
    });
  }
}

extension HistorialPagoQueryWhereDistinct
    on QueryBuilder<HistorialPago, HistorialPago, QDistinct> {
  QueryBuilder<HistorialPago, HistorialPago, QDistinct> distinctByCicloPago(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cicloPago', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QDistinct>
      distinctByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaRegistro');
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QDistinct> distinctByMetodoPago(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'metodoPago', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QDistinct>
      distinctByMontoPagado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'montoPagado');
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QDistinct>
      distinctByNumeroOperacion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroOperacion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QDistinct> distinctByPagoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pagoId');
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QDistinct>
      distinctByRutaComprobante({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rutaComprobante',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HistorialPago, HistorialPago, QDistinct> distinctByTipoPago(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoPago', caseSensitive: caseSensitive);
    });
  }
}

extension HistorialPagoQueryProperty
    on QueryBuilder<HistorialPago, HistorialPago, QQueryProperty> {
  QueryBuilder<HistorialPago, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HistorialPago, CicloPago, QQueryOperations> cicloPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cicloPago');
    });
  }

  QueryBuilder<HistorialPago, DateTime, QQueryOperations>
      fechaRegistroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaRegistro');
    });
  }

  QueryBuilder<HistorialPago, String?, QQueryOperations> metodoPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'metodoPago');
    });
  }

  QueryBuilder<HistorialPago, double, QQueryOperations> montoPagadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'montoPagado');
    });
  }

  QueryBuilder<HistorialPago, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<HistorialPago, String?, QQueryOperations>
      numeroOperacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroOperacion');
    });
  }

  QueryBuilder<HistorialPago, int, QQueryOperations> pagoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pagoId');
    });
  }

  QueryBuilder<HistorialPago, String?, QQueryOperations>
      rutaComprobanteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rutaComprobante');
    });
  }

  QueryBuilder<HistorialPago, TipoPago, QQueryOperations> tipoPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoPago');
    });
  }
}
