/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;

/** This is an auto generated class representing the Plan type in your schema. */
class Plan {
  final String id;
  final PLAN_TYPE? _name;
  final int? _limit;
  final int? _nbTraining;
  final int? _size;
  final double? _price;
  final CURRENCY? _currency;
  final int? _duration;

  PLAN_TYPE get name {
    try {
      return _name!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  int? get limit {
    return _limit;
  }

  int? get nbTraining {
    return _nbTraining;
  }

  int? get size {
    return _size;
  }

  double? get price {
    return _price;
  }

  CURRENCY? get currency {
    return _currency;
  }

  int? get duration {
    return _duration;
  }

  const Plan._internal(
      {required this.id,
      required name,
      limit,
      nbTraining,
      size,
      price,
      currency,
      duration})
      : _name = name,
        _limit = limit,
        _nbTraining = nbTraining,
        _size = size,
        _price = price,
        _currency = currency,
        _duration = duration;

  factory Plan(
      {String? id,
      required PLAN_TYPE name,
      int? limit,
      int? nbTraining,
      int? size,
      double? price,
      CURRENCY? currency,
      int? duration}) {
    return Plan._internal(
        id: id == null ? amplify_core.UUID.getUUID() : id,
        name: name,
        limit: limit,
        nbTraining: nbTraining,
        size: size,
        price: price,
        currency: currency,
        duration: duration);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Plan &&
        id == other.id &&
        _name == other._name &&
        _limit == other._limit &&
        _nbTraining == other._nbTraining &&
        _size == other._size &&
        _price == other._price &&
        _currency == other._currency &&
        _duration == other._duration;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Plan {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" +
        (_name != null ? amplify_core.enumToString(_name)! : "null") +
        ", ");
    buffer.write(
        "limit=" + (_limit != null ? _limit!.toString() : "null") + ", ");
    buffer.write("nbTraining=" +
        (_nbTraining != null ? _nbTraining!.toString() : "null") +
        ", ");
    buffer.write("size=" + (_size != null ? _size!.toString() : "null") + ", ");
    buffer.write(
        "price=" + (_price != null ? _price!.toString() : "null") + ", ");
    buffer.write("currency=" +
        (_currency != null ? amplify_core.enumToString(_currency)! : "null") +
        ", ");
    buffer.write(
        "duration=" + (_duration != null ? _duration!.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Plan copyWith(
      {String? id,
      PLAN_TYPE? name,
      int? limit,
      int? nbTraining,
      int? size,
      double? price,
      CURRENCY? currency,
      int? duration}) {
    return Plan._internal(
        id: id ?? this.id,
        name: name ?? this.name,
        limit: limit ?? this.limit,
        nbTraining: nbTraining ?? this.nbTraining,
        size: size ?? this.size,
        price: price ?? this.price,
        currency: currency ?? this.currency,
        duration: duration ?? this.duration);
  }

  Plan copyWithModelFieldValues(
      {ModelFieldValue<String>? id,
      ModelFieldValue<PLAN_TYPE>? name,
      ModelFieldValue<int?>? limit,
      ModelFieldValue<int?>? nbTraining,
      ModelFieldValue<int?>? size,
      ModelFieldValue<double?>? price,
      ModelFieldValue<CURRENCY?>? currency,
      ModelFieldValue<int?>? duration}) {
    return Plan._internal(
        id: id == null ? this.id : id.value,
        name: name == null ? this.name : name.value,
        limit: limit == null ? this.limit : limit.value,
        nbTraining: nbTraining == null ? this.nbTraining : nbTraining.value,
        size: size == null ? this.size : size.value,
        price: price == null ? this.price : price.value,
        currency: currency == null ? this.currency : currency.value,
        duration: duration == null ? this.duration : duration.value);
  }

  Plan.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _name = amplify_core.enumFromString<PLAN_TYPE>(
            json['name'], PLAN_TYPE.values),
        _limit = (json['limit'] as num?)?.toInt(),
        _nbTraining = (json['nbTraining'] as num?)?.toInt(),
        _size = (json['size'] as num?)?.toInt(),
        _price = (json['price'] as num?)?.toDouble(),
        _currency = amplify_core.enumFromString<CURRENCY>(
            json['currency'], CURRENCY.values),
        _duration = (json['duration'] as num?)?.toInt();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': amplify_core.enumToString(_name),
        'limit': _limit,
        'nbTraining': _nbTraining,
        'size': _size,
        'price': _price,
        'currency': amplify_core.enumToString(_currency),
        'duration': _duration
      };

  Map<String, Object?> toMap() => {
        'id': id,
        'name': _name,
        'limit': _limit,
        'nbTraining': _nbTraining,
        'size': _size,
        'price': _price,
        'currency': _currency,
        'duration': _duration
      };

  static var schema = amplify_core.Model.defineSchema(
      define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Plan";
    modelSchemaDefinition.pluralName = "Plans";

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.customTypeField(
            fieldName: 'id',
            isRequired: true,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.customTypeField(
            fieldName: 'name',
            isRequired: true,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.customTypeField(
            fieldName: 'limit',
            isRequired: false,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.customTypeField(
            fieldName: 'nbTraining',
            isRequired: false,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.customTypeField(
            fieldName: 'size',
            isRequired: false,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.customTypeField(
            fieldName: 'price',
            isRequired: false,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.customTypeField(
            fieldName: 'currency',
            isRequired: false,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.customTypeField(
            fieldName: 'duration',
            isRequired: false,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.int)));
  });
}
