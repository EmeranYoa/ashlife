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


/** This is an auto generated class representing the Filter type in your schema. */
@immutable
class Filter extends Model {
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
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

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
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
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
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get negativePrompt {
    try {
      return _negativePrompt!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
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
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get model {
    return _model;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Filter._internal({required this.id, required name, description, required prompt, required negativePrompt, plans, generations, required image, model, createdAt, updatedAt}): _name = name, _description = description, _prompt = prompt, _negativePrompt = negativePrompt, _plans = plans, _generations = generations, _image = image, _model = model, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Filter({String? id, required String name, String? description, required String prompt, required String negativePrompt, List<Plan>? plans, List<Generation>? generations, required Image image, String? model}) {
    return Filter._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      description: description,
      prompt: prompt,
      negativePrompt: negativePrompt,
      plans: plans != null ? List<Plan>.unmodifiable(plans) : plans,
      generations: generations != null ? List<Generation>.unmodifiable(generations) : generations,
      image: image,
      model: model);
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
      _model == other._model;
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
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Filter copyWith({String? name, String? description, String? prompt, String? negativePrompt, List<Plan>? plans, List<Generation>? generations, Image? image, String? model}) {
    return Filter._internal(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      prompt: prompt ?? this.prompt,
      negativePrompt: negativePrompt ?? this.negativePrompt,
      plans: plans ?? this.plans,
      generations: generations ?? this.generations,
      image: image ?? this.image,
      model: model ?? this.model);
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
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'description': _description, 'prompt': _prompt, 'negativePrompt': _negativePrompt, 'plans': _plans?.map((Plan? e) => e?.toJson()).toList(), 'generations': _generations?.map((Generation? e) => e?.toJson()).toList(), 'image': _image?.toJson(), 'model': _model, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'name': _name, 'description': _description, 'prompt': _prompt, 'negativePrompt': _negativePrompt, 'plans': _plans, 'generations': _generations, 'image': _image, 'model': _model, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<FilterModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<FilterModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField PROMPT = QueryField(fieldName: "prompt");
  static final QueryField NEGATIVEPROMPT = QueryField(fieldName: "negativePrompt");
  static final QueryField PLANS = QueryField(fieldName: "plans");
  static final QueryField GENERATIONS = QueryField(
    fieldName: "generations",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Generation'));
  static final QueryField IMAGE = QueryField(fieldName: "image");
  static final QueryField MODEL = QueryField(fieldName: "model");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Filter";
    modelSchemaDefinition.pluralName = "Filters";
    
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Filter.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Filter.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Filter.PROMPT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Filter.NEGATIVEPROMPT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'plans',
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'Plan')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Filter.GENERATIONS,
      isRequired: false,
      ofModelName: 'Generation',
      associatedKey: Generation.FILTER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'image',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Image')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Filter.MODEL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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

class _FilterModelType extends ModelType<Filter> {
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
@immutable
class FilterModelIdentifier implements ModelIdentifier<Filter> {
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