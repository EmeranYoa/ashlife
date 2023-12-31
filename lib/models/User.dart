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


/** This is an auto generated class representing the User type in your schema. */
class User extends amplify_core.Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _phone;
  final String? _name;
  final String? _email;
  final List<Generation>? _generations;
  final List<SubscriptionPlan>? _plans;
  final List<Image>? _images;
  final List<Image>? _favorites;
  final Image? _avatar;
  final List<UserModel>? _models;
  final String? _datasetId;
  final String? _modelObject;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserModelIdentifier get modelIdentifier {
      return UserModelIdentifier(
        id: id
      );
  }
  
  String? get phone {
    return _phone;
  }
  
  String? get name {
    return _name;
  }
  
  String? get email {
    return _email;
  }
  
  List<Generation>? get generations {
    return _generations;
  }
  
  List<SubscriptionPlan>? get plans {
    return _plans;
  }
  
  List<Image>? get images {
    return _images;
  }
  
  List<Image>? get favorites {
    return _favorites;
  }
  
  Image? get avatar {
    return _avatar;
  }
  
  List<UserModel>? get models {
    return _models;
  }
  
  String? get datasetId {
    return _datasetId;
  }
  
  String? get modelObject {
    return _modelObject;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, phone, name, email, generations, plans, images, favorites, avatar, models, datasetId, modelObject, createdAt, updatedAt}): _phone = phone, _name = name, _email = email, _generations = generations, _plans = plans, _images = images, _favorites = favorites, _avatar = avatar, _models = models, _datasetId = datasetId, _modelObject = modelObject, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, String? phone, String? name, String? email, List<Generation>? generations, List<SubscriptionPlan>? plans, List<Image>? images, List<Image>? favorites, Image? avatar, List<UserModel>? models, String? datasetId, String? modelObject}) {
    return User._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      phone: phone,
      name: name,
      email: email,
      generations: generations != null ? List<Generation>.unmodifiable(generations) : generations,
      plans: plans != null ? List<SubscriptionPlan>.unmodifiable(plans) : plans,
      images: images != null ? List<Image>.unmodifiable(images) : images,
      favorites: favorites != null ? List<Image>.unmodifiable(favorites) : favorites,
      avatar: avatar,
      models: models != null ? List<UserModel>.unmodifiable(models) : models,
      datasetId: datasetId,
      modelObject: modelObject);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _phone == other._phone &&
      _name == other._name &&
      _email == other._email &&
      DeepCollectionEquality().equals(_generations, other._generations) &&
      DeepCollectionEquality().equals(_plans, other._plans) &&
      DeepCollectionEquality().equals(_images, other._images) &&
      DeepCollectionEquality().equals(_favorites, other._favorites) &&
      _avatar == other._avatar &&
      DeepCollectionEquality().equals(_models, other._models) &&
      _datasetId == other._datasetId &&
      _modelObject == other._modelObject;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("images=" + (_images != null ? _images!.toString() : "null") + ", ");
    buffer.write("favorites=" + (_favorites != null ? _favorites!.toString() : "null") + ", ");
    buffer.write("avatar=" + (_avatar != null ? _avatar!.toString() : "null") + ", ");
    buffer.write("models=" + (_models != null ? _models!.toString() : "null") + ", ");
    buffer.write("datasetId=" + "$_datasetId" + ", ");
    buffer.write("modelObject=" + "$_modelObject" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? phone, String? name, String? email, List<Generation>? generations, List<SubscriptionPlan>? plans, List<Image>? images, List<Image>? favorites, Image? avatar, List<UserModel>? models, String? datasetId, String? modelObject}) {
    return User._internal(
      id: id,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      email: email ?? this.email,
      generations: generations ?? this.generations,
      plans: plans ?? this.plans,
      images: images ?? this.images,
      favorites: favorites ?? this.favorites,
      avatar: avatar ?? this.avatar,
      models: models ?? this.models,
      datasetId: datasetId ?? this.datasetId,
      modelObject: modelObject ?? this.modelObject);
  }
  
  User copyWithModelFieldValues({
    ModelFieldValue<String?>? phone,
    ModelFieldValue<String?>? name,
    ModelFieldValue<String?>? email,
    ModelFieldValue<List<Generation>?>? generations,
    ModelFieldValue<List<SubscriptionPlan>?>? plans,
    ModelFieldValue<List<Image>?>? images,
    ModelFieldValue<List<Image>?>? favorites,
    ModelFieldValue<Image?>? avatar,
    ModelFieldValue<List<UserModel>?>? models,
    ModelFieldValue<String?>? datasetId,
    ModelFieldValue<String?>? modelObject
  }) {
    return User._internal(
      id: id,
      phone: phone == null ? this.phone : phone.value,
      name: name == null ? this.name : name.value,
      email: email == null ? this.email : email.value,
      generations: generations == null ? this.generations : generations.value,
      plans: plans == null ? this.plans : plans.value,
      images: images == null ? this.images : images.value,
      favorites: favorites == null ? this.favorites : favorites.value,
      avatar: avatar == null ? this.avatar : avatar.value,
      models: models == null ? this.models : models.value,
      datasetId: datasetId == null ? this.datasetId : datasetId.value,
      modelObject: modelObject == null ? this.modelObject : modelObject.value
    );
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _phone = json['phone'],
      _name = json['name'],
      _email = json['email'],
      _generations = json['generations'] is List
        ? (json['generations'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Generation.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _plans = json['plans'] is List
        ? (json['plans'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => SubscriptionPlan.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _images = json['images'] is List
        ? (json['images'] as List)
          .where((e) => e != null)
          .map((e) => Image.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _favorites = json['favorites'] is List
        ? (json['favorites'] as List)
          .where((e) => e != null)
          .map((e) => Image.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _avatar = json['avatar']?['serializedData'] != null
        ? Image.fromJson(new Map<String, dynamic>.from(json['avatar']['serializedData']))
        : null,
      _models = json['models'] is List
        ? (json['models'] as List)
          .where((e) => e != null)
          .map((e) => UserModel.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _datasetId = json['datasetId'],
      _modelObject = json['modelObject'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'phone': _phone, 'name': _name, 'email': _email, 'generations': _generations?.map((Generation? e) => e?.toJson()).toList(), 'plans': _plans?.map((SubscriptionPlan? e) => e?.toJson()).toList(), 'images': _images?.map((Image? e) => e?.toJson()).toList(), 'favorites': _favorites?.map((Image? e) => e?.toJson()).toList(), 'avatar': _avatar?.toJson(), 'models': _models?.map((UserModel? e) => e?.toJson()).toList(), 'datasetId': _datasetId, 'modelObject': _modelObject, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'phone': _phone,
    'name': _name,
    'email': _email,
    'generations': _generations,
    'plans': _plans,
    'images': _images,
    'favorites': _favorites,
    'avatar': _avatar,
    'models': _models,
    'datasetId': _datasetId,
    'modelObject': _modelObject,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<UserModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UserModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final PHONE = amplify_core.QueryField(fieldName: "phone");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final EMAIL = amplify_core.QueryField(fieldName: "email");
  static final GENERATIONS = amplify_core.QueryField(
    fieldName: "generations",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Generation'));
  static final PLANS = amplify_core.QueryField(
    fieldName: "plans",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'SubscriptionPlan'));
  static final IMAGES = amplify_core.QueryField(fieldName: "images");
  static final FAVORITES = amplify_core.QueryField(fieldName: "favorites");
  static final AVATAR = amplify_core.QueryField(fieldName: "avatar");
  static final MODELS = amplify_core.QueryField(fieldName: "models");
  static final DATASETID = amplify_core.QueryField(fieldName: "datasetId");
  static final MODELOBJECT = amplify_core.QueryField(fieldName: "modelObject");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
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
      key: User.PHONE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.NAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.GENERATIONS,
      isRequired: false,
      ofModelName: 'Generation',
      associatedKey: Generation.USER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.PLANS,
      isRequired: false,
      ofModelName: 'SubscriptionPlan',
      associatedKey: SubscriptionPlan.USER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'images',
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'Image')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'favorites',
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'Image')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'avatar',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Image')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'models',
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'UserModel')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.DATASETID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.MODELOBJECT,
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

class _UserModelType extends amplify_core.ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'User';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [User] in your schema.
 */
class UserModelIdentifier implements amplify_core.ModelIdentifier<User> {
  final String id;

  /** Create an instance of UserModelIdentifier using [id] the primary key. */
  const UserModelIdentifier({
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
  String toString() => 'UserModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}