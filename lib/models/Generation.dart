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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Generation type in your schema. */
@immutable
class Generation extends Model {
  static const classType = const _GenerationModelType();
  final String id;
  final User? _user;
  final Filter? _filter;
  final String? _process;
  final String? _providerId;
  final String? _modelId;
  final String? _data;
  final int? _number;
  final List<Image>? _images;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  GenerationModelIdentifier get modelIdentifier {
      return GenerationModelIdentifier(
        id: id
      );
  }
  
  User get user {
    try {
      return _user!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Filter get filter {
    try {
      return _filter!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get process {
    try {
      return _process!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get providerId {
    return _providerId;
  }
  
  String? get modelId {
    return _modelId;
  }
  
  String? get data {
    return _data;
  }
  
  int? get number {
    return _number;
  }
  
  List<Image>? get images {
    return _images;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Generation._internal({required this.id, required user, required filter, required process, providerId, modelId, data, number, images, createdAt, updatedAt}): _user = user, _filter = filter, _process = process, _providerId = providerId, _modelId = modelId, _data = data, _number = number, _images = images, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Generation({String? id, required User user, required Filter filter, required String process, String? providerId, String? modelId, String? data, int? number, List<Image>? images}) {
    return Generation._internal(
      id: id == null ? UUID.getUUID() : id,
      user: user,
      filter: filter,
      process: process,
      providerId: providerId,
      modelId: modelId,
      data: data,
      number: number,
      images: images != null ? List<Image>.unmodifiable(images) : images);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Generation &&
      id == other.id &&
      _user == other._user &&
      _filter == other._filter &&
      _process == other._process &&
      _providerId == other._providerId &&
      _modelId == other._modelId &&
      _data == other._data &&
      _number == other._number &&
      DeepCollectionEquality().equals(_images, other._images);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Generation {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("filter=" + (_filter != null ? _filter!.toString() : "null") + ", ");
    buffer.write("process=" + "$_process" + ", ");
    buffer.write("providerId=" + "$_providerId" + ", ");
    buffer.write("modelId=" + "$_modelId" + ", ");
    buffer.write("data=" + "$_data" + ", ");
    buffer.write("number=" + (_number != null ? _number!.toString() : "null") + ", ");
    buffer.write("images=" + (_images != null ? _images!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Generation copyWith({User? user, Filter? filter, String? process, String? providerId, String? modelId, String? data, int? number, List<Image>? images}) {
    return Generation._internal(
      id: id,
      user: user ?? this.user,
      filter: filter ?? this.filter,
      process: process ?? this.process,
      providerId: providerId ?? this.providerId,
      modelId: modelId ?? this.modelId,
      data: data ?? this.data,
      number: number ?? this.number,
      images: images ?? this.images);
  }
  
  Generation.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _filter = json['filter']?['serializedData'] != null
        ? Filter.fromJson(new Map<String, dynamic>.from(json['filter']['serializedData']))
        : null,
      _process = json['process'],
      _providerId = json['providerId'],
      _modelId = json['modelId'],
      _data = json['data'],
      _number = (json['number'] as num?)?.toInt(),
      _images = json['images'] is List
        ? (json['images'] as List)
          .where((e) => e != null)
          .map((e) => Image.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'user': _user?.toJson(), 'filter': _filter?.toJson(), 'process': _process, 'providerId': _providerId, 'modelId': _modelId, 'data': _data, 'number': _number, 'images': _images?.map((Image? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'user': _user, 'filter': _filter, 'process': _process, 'providerId': _providerId, 'modelId': _modelId, 'data': _data, 'number': _number, 'images': _images, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<GenerationModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<GenerationModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final QueryField FILTER = QueryField(
    fieldName: "filter",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Filter'));
  static final QueryField PROCESS = QueryField(fieldName: "process");
  static final QueryField PROVIDERID = QueryField(fieldName: "providerId");
  static final QueryField MODELID = QueryField(fieldName: "modelId");
  static final QueryField DATA = QueryField(fieldName: "data");
  static final QueryField NUMBER = QueryField(fieldName: "number");
  static final QueryField IMAGES = QueryField(fieldName: "images");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Generation";
    modelSchemaDefinition.pluralName = "Generations";
    
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
      key: Generation.USER,
      isRequired: true,
      targetNames: ['userGenerationsId'],
      ofModelName: 'User'
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Generation.FILTER,
      isRequired: true,
      targetNames: ['filterGenerationsId'],
      ofModelName: 'Filter'
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Generation.PROCESS,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Generation.PROVIDERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Generation.MODELID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Generation.DATA,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Generation.NUMBER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'images',
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'Image')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _GenerationModelType extends ModelType<Generation> {
  const _GenerationModelType();
  
  @override
  Generation fromJson(Map<String, dynamic> jsonData) {
    return Generation.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Generation';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Generation] in your schema.
 */
@immutable
class GenerationModelIdentifier implements ModelIdentifier<Generation> {
  final String id;

  /** Create an instance of GenerationModelIdentifier using [id] the primary key. */
  const GenerationModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'GenerationModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is GenerationModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}