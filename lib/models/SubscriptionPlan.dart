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


/** This is an auto generated class representing the SubscriptionPlan type in your schema. */
class SubscriptionPlan extends amplify_core.Model {
  static const classType = const _SubscriptionPlanModelType();
  final String id;
  final User? _user;
  final Plan? _plan;
  final int? _remainSX;
  final int? _remainTraining;
  final amplify_core.TemporalDateTime? _startAt;
  final PLAN_STATUS? _status;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;

  @Deprecated(
      '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;

  SubscriptionPlanModelIdentifier get modelIdentifier {
    return SubscriptionPlanModelIdentifier(
        id: id
    );
  }

  User get user {
    try {
      return _user!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
          amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
      );
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

  amplify_core.TemporalDateTime? get startAt {
    return _startAt;
  }

  PLAN_STATUS? get status {
    return _status;
  }

  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }

  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  const SubscriptionPlan._internal(
      {required this.id, required user, plan, remainSX, remainTraining, startAt, status, createdAt, updatedAt})
      : _user = user,
        _plan = plan,
        _remainSX = remainSX,
        _remainTraining = remainTraining,
        _startAt = startAt,
        _status = status,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory SubscriptionPlan(
      {String? id, required User user, Plan? plan, int? remainSX, int? remainTraining, amplify_core
          .TemporalDateTime? startAt, PLAN_STATUS? status}) {
    return SubscriptionPlan._internal(
        id: id == null ? amplify_core.UUID.getUUID() : id,
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
    buffer.write(
        "remainSX=" + (_remainSX != null ? _remainSX!.toString() : "null") +
            ", ");
    buffer.write("remainTraining=" +
        (_remainTraining != null ? _remainTraining!.toString() : "null") +
        ", ");
    buffer.write(
        "startAt=" + (_startAt != null ? _startAt!.format() : "null") + ", ");
    buffer.write("status=" +
        (_status != null ? amplify_core.enumToString(_status)! : "null") +
        ", ");
    buffer.write(
        "createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") +
            ", ");
    buffer.write(
        "updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  SubscriptionPlan copyWith(
      {User? user, Plan? plan, int? remainSX, int? remainTraining, amplify_core
          .TemporalDateTime? startAt, PLAN_STATUS? status}) {
    return SubscriptionPlan._internal(
        id: id,
        user: user ?? this.user,
        plan: plan ?? this.plan,
        remainSX: remainSX ?? this.remainSX,
        remainTraining: remainTraining ?? this.remainTraining,
        startAt: startAt ?? this.startAt,
        status: status ?? this.status);
  }

  SubscriptionPlan copyWithModelFieldValues({
    ModelFieldValue<User>? user,
    ModelFieldValue<Plan?>? plan,
    ModelFieldValue<int?>? remainSX,
    ModelFieldValue<int?>? remainTraining,
    ModelFieldValue<amplify_core.TemporalDateTime?>? startAt,
    ModelFieldValue<PLAN_STATUS?>? status
  }) {
    return SubscriptionPlan._internal(
        id: id,
        user: user == null ? this.user : user.value,
        plan: plan == null ? this.plan : plan.value,
        remainSX: remainSX == null ? this.remainSX : remainSX.value,
        remainTraining: remainTraining == null
            ? this.remainTraining
            : remainTraining.value,
        startAt: startAt == null ? this.startAt : startAt.value,
        status: status == null ? this.status : status.value
    );
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
        _startAt = json['startAt'] != null ? amplify_core.TemporalDateTime
            .fromString(json['startAt']) : null,
        _status = amplify_core.enumFromString<PLAN_STATUS>(
            json['status'], PLAN_STATUS.values),
        _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime
            .fromString(json['createdAt']) : null,
        _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime
            .fromString(json['updatedAt']) : null;

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'user': _user?.toJson(),
        'plan': _plan?.toJson(),
        'remainSX': _remainSX,
        'remainTraining': _remainTraining,
        'startAt': _startAt?.format(),
        'status': amplify_core.enumToString(_status),
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format()
      };

  Map<String, Object?> toMap() =>
      {
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

  static final amplify_core.QueryModelIdentifier<
      SubscriptionPlanModelIdentifier> MODEL_IDENTIFIER = amplify_core
      .QueryModelIdentifier<SubscriptionPlanModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final USER = amplify_core.QueryField(
      fieldName: "user",
      fieldType: amplify_core.ModelFieldType(
          amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final PLAN = amplify_core.QueryField(fieldName: "plan");
  static final REMAINSX = amplify_core.QueryField(fieldName: "remainSX");
  static final REMAINTRAINING = amplify_core.QueryField(
      fieldName: "remainTraining");
  static final STARTAT = amplify_core.QueryField(fieldName: "startAt");
  static final STATUS = amplify_core.QueryField(fieldName: "status");
  static var schema = amplify_core.Model.defineSchema(
      define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
        modelSchemaDefinition.name = "SubscriptionPlan";
        modelSchemaDefinition.pluralName = "SubscriptionPlans";

        modelSchemaDefinition.authRules = [
          amplify_core.AuthRule(
              authStrategy: amplify_core.AuthStrategy.OWNER,
              ownerField: "owner",
              identityClaim: "cognito:username",
              provider: amplify_core.AuthRuleProvider.USERPOOLS,
              operations: const [
                amplify_core.ModelOperation.CREATE,
                amplify_core.ModelOperation.UPDATE,
                amplify_core.ModelOperation.DELETE,
                amplify_core.ModelOperation.READ
              ])
        ];

        modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());

        modelSchemaDefinition.addField(
            amplify_core.ModelFieldDefinition.belongsTo(
                key: SubscriptionPlan.USER,
                isRequired: true,
                targetNames: ['userPlansId'],
                ofModelName: 'User'
            ));

        modelSchemaDefinition.addField(
            amplify_core.ModelFieldDefinition.embedded(
                fieldName: 'plan',
                isRequired: false,
                ofType: amplify_core.ModelFieldType(
                    amplify_core.ModelFieldTypeEnum.embedded,
                    ofCustomTypeName: 'Plan')
            ));

        modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
            key: SubscriptionPlan.REMAINSX,
            isRequired: false,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.int)
        ));

        modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
            key: SubscriptionPlan.REMAINTRAINING,
            isRequired: false,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.int)
        ));

        modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
            key: SubscriptionPlan.STARTAT,
            isRequired: false,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.dateTime)
        ));

        modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
            key: SubscriptionPlan.STATUS,
            isRequired: false,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.enumeration)
        ));

        modelSchemaDefinition.addField(
            amplify_core.ModelFieldDefinition.nonQueryField(
                fieldName: 'createdAt',
                isRequired: false,
                isReadOnly: true,
                ofType: amplify_core.ModelFieldType(
                    amplify_core.ModelFieldTypeEnum.dateTime)
            ));

        modelSchemaDefinition.addField(
            amplify_core.ModelFieldDefinition.nonQueryField(
                fieldName: 'updatedAt',
                isRequired: false,
                isReadOnly: true,
                ofType: amplify_core.ModelFieldType(
                    amplify_core.ModelFieldTypeEnum.dateTime)
            ));
      });
}

class _SubscriptionPlanModelType
    extends amplify_core.ModelType<SubscriptionPlan> {
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
class SubscriptionPlanModelIdentifier
    implements amplify_core.ModelIdentifier<SubscriptionPlan> {
  final String id;

  /** Create an instance of SubscriptionPlanModelIdentifier using [id] the primary key. */
  const SubscriptionPlanModelIdentifier({
    required this.id});

  @override
  Map<String, dynamic> serializeAsMap() =>
      (<String, dynamic>{
        'id': id
      });

  @override
  List<Map<String, dynamic>> serializeAsList() =>
      serializeAsMap()
          .entries
          .map((entry) => (<String, dynamic>{ entry.key: entry.value}))
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

    return other is SubscriptionPlanModelIdentifier &&
        id == other.id;
  }

  @override
  int get hashCode =>
      id.hashCode;
}