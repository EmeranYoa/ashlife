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
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the SubscriptionPlan type in your schema. */
@immutable
class SubscriptionPlan extends Model {
  static const classType = const _SubscriptionPlanModelType();
  final String id;
  final User? _user;
  final Plan? _plan;
  final int? _remainSX;
  final int? _remainTraining;
  final TemporalDateTime? _startAt;
  final PLAN_STATUS? _status;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;

  @Deprecated(
      '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;

  SubscriptionPlanModelIdentifier get modelIdentifier {
    return SubscriptionPlanModelIdentifier(id: id);
  }

  User get user {
    try {
      return _user!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  Plan? get plan {
    return _plan;
  }

  int? get remainSX {
    return _remainSX;
  }

  int? get remainTraining {
    return _remainTraining;
  }

  TemporalDateTime? get startAt {
    return _startAt;
  }

  PLAN_STATUS? get status {
    return _status;
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }

  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  const SubscriptionPlan._internal(
      {required this.id,
      required user,
      plan,
      remainSX,
      remainTraining,
      startAt,
      status,
      createdAt,
      updatedAt})
      : _user = user,
        _plan = plan,
        _remainSX = remainSX,
        _remainTraining = remainTraining,
        _startAt = startAt,
        _status = status,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory SubscriptionPlan(
      {String? id,
      required User user,
      Plan? plan,
      int? remainSX,
      int? remainTraining,
      TemporalDateTime? startAt,
      PLAN_STATUS? status}) {
    return SubscriptionPlan._internal(
        id: id == null ? UUID.getUUID() : id,
        user: user,
        plan: plan,
        remainSX: remainSX,
        remainTraining: remainTraining,
        startAt: startAt,
        status: status);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscriptionPlan &&
        id == other.id &&
        _user == other._user &&
        _plan == other._plan &&
        _remainSX == other._remainSX &&
        _remainTraining == other._remainTraining &&
        _startAt == other._startAt &&
        _status == other._status;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("SubscriptionPlan {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("plan=" + (_plan != null ? _plan!.toString() : "null") + ", ");
    buffer.write("remainSX=" +
        (_remainSX != null ? _remainSX!.toString() : "null") +
        ", ");
    buffer.write("remainTraining=" +
        (_remainTraining != null ? _remainTraining!.toString() : "null") +
        ", ");
    buffer.write(
        "startAt=" + (_startAt != null ? _startAt!.format() : "null") + ", ");
    buffer.write(
        "status=" + (_status != null ? enumToString(_status)! : "null") + ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write(
        "updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  SubscriptionPlan copyWith(
      {User? user,
      Plan? plan,
      int? remainSX,
      int? remainTraining,
      TemporalDateTime? startAt,
      PLAN_STATUS? status}) {
    return SubscriptionPlan._internal(
        id: id,
        user: user ?? this.user,
        plan: plan ?? this.plan,
        remainSX: remainSX ?? this.remainSX,
        remainTraining: remainTraining ?? this.remainTraining,
        startAt: startAt ?? this.startAt,
        status: status ?? this.status);
  }

  SubscriptionPlan.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _user = json['user']?['serializedData'] != null
            ? User.fromJson(
                new Map<String, dynamic>.from(json['user']['serializedData']))
            : null,
        _plan = json['plan']?['serializedData'] != null
            ? Plan.fromJson(
                new Map<String, dynamic>.from(json['plan']['serializedData']))
            : null,
        _remainSX = (json['remainSX'] as num?)?.toInt(),
        _remainTraining = (json['remainTraining'] as num?)?.toInt(),
        _startAt = json['startAt'] != null
            ? TemporalDateTime.fromString(json['startAt'])
            : null,
        _status =
            enumFromString<PLAN_STATUS>(json['status'], PLAN_STATUS.values),
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': _user?.toJson(),
        'plan': _plan?.toJson(),
        'remainSX': _remainSX,
        'remainTraining': _remainTraining,
        'startAt': _startAt?.format(),
        'status': enumToString(_status),
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format()
      };

  Map<String, Object?> toMap() => {
        'id': id,
        'user': _user,
        'plan': _plan,
        'remainSX': _remainSX,
        'remainTraining': _remainTraining,
        'startAt': _startAt,
        'status': _status,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt
      };

  static final QueryModelIdentifier<SubscriptionPlanModelIdentifier>
      MODEL_IDENTIFIER =
      QueryModelIdentifier<SubscriptionPlanModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final QueryField PLAN = QueryField(fieldName: "plan");
  static final QueryField REMAINSX = QueryField(fieldName: "remainSX");
  static final QueryField REMAINTRAINING =
      QueryField(fieldName: "remainTraining");
  static final QueryField STARTAT = QueryField(fieldName: "startAt");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "SubscriptionPlan";
    modelSchemaDefinition.pluralName = "SubscriptionPlans";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          provider: AuthRuleProvider.USERPOOLS,
          operations: [
            ModelOperation.CREATE,
            ModelOperation.UPDATE,
            ModelOperation.DELETE,
            ModelOperation.READ
          ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: SubscriptionPlan.USER,
        isRequired: true,
        targetNames: ['userPlansId'],
        ofModelName: 'User'));

    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
        fieldName: 'plan',
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.embedded,
            ofCustomTypeName: 'Plan')));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: SubscriptionPlan.REMAINSX,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: SubscriptionPlan.REMAINTRAINING,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: SubscriptionPlan.STARTAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: SubscriptionPlan.STATUS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'createdAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'updatedAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _SubscriptionPlanModelType extends ModelType<SubscriptionPlan> {
  const _SubscriptionPlanModelType();

  @override
  SubscriptionPlan fromJson(Map<String, dynamic> jsonData) {
    return SubscriptionPlan.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'SubscriptionPlan';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [SubscriptionPlan] in your schema.
 */
@immutable
class SubscriptionPlanModelIdentifier
    implements ModelIdentifier<SubscriptionPlan> {
  final String id;

  /** Create an instance of SubscriptionPlanModelIdentifier using [id] the primary key. */
  const SubscriptionPlanModelIdentifier({required this.id});

  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{'id': id});

  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
      .entries
      .map((entry) => (<String, dynamic>{entry.key: entry.value}))
      .toList();

  @override
  String serializeAsString() => serializeAsMap().values.join('#');

  @override
  String toString() => 'SubscriptionPlanModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is SubscriptionPlanModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
