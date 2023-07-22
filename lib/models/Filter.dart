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
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Filter type in your schema. */
class Filter extends amplify_core.Model {
  static const classType = const _FilterModelType();
  final String id;
  final String? _name;
  final String? _description;
  final String? _prompt;
  final String? _negativePrompt;
  final List<Plan>? _plans;
  final List<Generation>? _generations;
  final Image? _image;
  final String? _model;
  final String? _dataSetId;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  FilterModelIdentifier get modelIdentifier {
      return FilterModelIdentifier(
        id: id
      );
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get description {
    return _description;
  }
  
  String get prompt {
    try {
      return _prompt!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get negativePrompt {
    try {
      return _negativePrompt!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<Plan>? get plans {
    return _plans;
  }
  
  List<Generation>? get generations {
    return _generations;
  }
  
  Image get image {
    try {
      return _image!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get model {
    return _model;
  }
  
  String? get dataSetId {
    return _dataSetId;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Filter._internal({required this.id, required name, description, required prompt, required negativePrompt, plans, generations, required image, model, dataSetId, createdAt, updatedAt}): _name = name, _description = description, _prompt = prompt, _negativePrompt = negativePrompt, _plans = plans, _generations = generations, _image = image, _model = model, _dataSetId = dataSetId, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Filter({String? id, required String name, String? description, required String prompt, required String negativePrompt, List<Plan>? plans, List<Generation>? generations, required Image image, String? model, String? dataSetId}) {
    return Filter._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      description: description,
      prompt: prompt,
      negativePrompt: negativePrompt,
      plans: plans != null ? List<Plan>.unmodifiable(plans) : plans,
      generations: generations != null ? List<Generation>.unmodifiable(generations) : generations,
      image: image,
      model: model,
      dataSetId: dataSetId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Filter &&
      id == other.id &&
      _name == other._name &&
      _description == other._description &&
      _prompt == other._prompt &&
      _negativePrompt == other._negativePrompt &&
      DeepCollectionEquality().equals(_plans, other._plans) &&
      DeepCollectionEquality().equals(_generations, other._generations) &&
      _image == other._image &&
      _model == other._model &&
      _dataSetId == other._dataSetId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Filter {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("prompt=" + "$_prompt" + ", ");
    buffer.write("negativePrompt=" + "$_negativePrompt" + ", ");
    buffer.write("plans=" + (_plans != null ? _plans!.toString() : "null") + ", ");
    buffer.write("image=" + (_image != null ? _image!.toString() : "null") + ", ");
    buffer.write("model=" + "$_model" + ", ");
    buffer.write("dataSetId=" + "$_dataSetId" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Filter copyWith({String? name, String? description, String? prompt, String? negativePrompt, List<Plan>? plans, List<Generation>? generations, Image? image, String? model, String? dataSetId}) {
    return Filter._internal(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      prompt: prompt ?? this.prompt,
      negativePrompt: negativePrompt ?? this.negativePrompt,
      plans: plans ?? this.plans,
      generations: generations ?? this.generations,
      image: image ?? this.image,
      model: model ?? this.model,
      dataSetId: dataSetId ?? this.dataSetId);
  }
  
  Filter copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<String?>? description,
    ModelFieldValue<String>? prompt,
    ModelFieldValue<String>? negativePrompt,
    ModelFieldValue<List<Plan>>? plans,
    ModelFieldValue<List<Generation>?>? generations,
    ModelFieldValue<Image>? image,
    ModelFieldValue<String?>? model,
    ModelFieldValue<String?>? dataSetId
  }) {
    return Filter._internal(
      id: id,
      name: name == null ? this.name : name.value,
      description: description == null ? this.description : description.value,
      prompt: prompt == null ? this.prompt : prompt.value,
      negativePrompt: negativePrompt == null ? this.negativePrompt : negativePrompt.value,
      plans: plans == null ? this.plans : plans.value,
      generations: generations == null ? this.generations : generations.value,
      image: image == null ? this.image : image.value,
      model: model == null ? this.model : model.value,
      dataSetId: dataSetId == null ? this.dataSetId : dataSetId.value
    );
  }
  
  Filter.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _description = json['description'],
      _prompt = json['prompt'],
      _negativePrompt = json['negativePrompt'],
      _plans = json['plans'] is List
        ? (json['plans'] as List)
          .where((e) => e != null)
          .map((e) => Plan.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _generations = json['generations'] is List
        ? (json['generations'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Generation.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _image = json['image']?['serializedData'] != null
        ? Image.fromJson(new Map<String, dynamic>.from(json['image']['serializedData']))
        : null,
      _model = json['model'],
      _dataSetId = json['dataSetId'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'description': _description, 'prompt': _prompt, 'negativePrompt': _negativePrompt, 'plans': _plans?.map((Plan? e) => e?.toJson()).toList(), 'generations': _generations?.map((Generation? e) => e?.toJson()).toList(), 'image': _image?.toJson(), 'model': _model, 'dataSetId': _dataSetId, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'description': _description,
    'prompt': _prompt,
    'negativePrompt': _negativePrompt,
    'plans': _plans,
    'generations': _generations,
    'image': _image,
    'model': _model,
    'dataSetId': _dataSetId,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<FilterModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<FilterModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final DESCRIPTION = amplify_core.QueryField(fieldName: "description");
  static final PROMPT = amplify_core.QueryField(fieldName: "prompt");
  static final NEGATIVEPROMPT = amplify_core.QueryField(fieldName: "negativePrompt");
  static final PLANS = amplify_core.QueryField(fieldName: "plans");
  static final GENERATIONS = amplify_core.QueryField(
    fieldName: "generations",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Generation'));
  static final IMAGE = amplify_core.QueryField(fieldName: "image");
  static final MODEL = amplify_core.QueryField(fieldName: "model");
  static final DATASETID = amplify_core.QueryField(fieldName: "dataSetId");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Filter";
    modelSchemaDefinition.pluralName = "Filters";
    
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Filter.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Filter.DESCRIPTION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Filter.PROMPT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Filter.NEGATIVEPROMPT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'plans',
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'Plan')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Filter.GENERATIONS,
      isRequired: false,
      ofModelName: 'Generation',
      associatedKey: Generation.FILTER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'image',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Image')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Filter.MODEL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Filter.DATASETID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _FilterModelType extends amplify_core.ModelType<Filter> {
  const _FilterModelType();
  
  @override
  Filter fromJson(Map<String, dynamic> jsonData) {
    return Filter.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Filter';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Filter] in your schema.
 */
class FilterModelIdentifier implements amplify_core.ModelIdentifier<Filter> {
  final String id;

  /** Create an instance of FilterModelIdentifier using [id] the primary key. */
  const FilterModelIdentifier({
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
  String toString() => 'FilterModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is FilterModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}