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


/** This is an auto generated class representing the UserModel type in your schema. */
class UserModel {
  final String? _modelId;
  final String? _name;
  final String? _status;
  final String? _prompt;
  final Image? _image;

  String? get modelId {
    return _modelId;
  }
  
  String? get name {
    return _name;
  }
  
  String? get status {
    return _status;
  }
  
  String? get prompt {
    return _prompt;
  }
  
  Image? get image {
    return _image;
  }
  
  const UserModel._internal({modelId, name, status, prompt, image}): _modelId = modelId, _name = name, _status = status, _prompt = prompt, _image = image;
  
  factory UserModel({String? modelId, String? name, String? status, String? prompt, Image? image}) {
    return UserModel._internal(
      modelId: modelId,
      name: name,
      status: status,
      prompt: prompt,
      image: image);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserModel &&
      _modelId == other._modelId &&
      _name == other._name &&
      _status == other._status &&
      _prompt == other._prompt &&
      _image == other._image;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserModel {");
    buffer.write("modelId=" + "$_modelId" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("status=" + "$_status" + ", ");
    buffer.write("prompt=" + "$_prompt" + ", ");
    buffer.write("image=" + (_image != null ? _image!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserModel copyWith({String? modelId, String? name, String? status, String? prompt, Image? image}) {
    return UserModel._internal(
      modelId: modelId ?? this.modelId,
      name: name ?? this.name,
      status: status ?? this.status,
      prompt: prompt ?? this.prompt,
      image: image ?? this.image);
  }
  
  UserModel copyWithModelFieldValues({
    ModelFieldValue<String?>? modelId,
    ModelFieldValue<String?>? name,
    ModelFieldValue<String?>? status,
    ModelFieldValue<String?>? prompt,
    ModelFieldValue<Image?>? image
  }) {
    return UserModel._internal(
      modelId: modelId == null ? this.modelId : modelId.value,
      name: name == null ? this.name : name.value,
      status: status == null ? this.status : status.value,
      prompt: prompt == null ? this.prompt : prompt.value,
      image: image == null ? this.image : image.value
    );
  }
  
  UserModel.fromJson(Map<String, dynamic> json)  
    : _modelId = json['modelId'],
      _name = json['name'],
      _status = json['status'],
      _prompt = json['prompt'],
      _image = json['image']?['serializedData'] != null
        ? Image.fromJson(new Map<String, dynamic>.from(json['image']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'modelId': _modelId, 'name': _name, 'status': _status, 'prompt': _prompt, 'image': _image?.toJson()
  };
  
  Map<String, Object?> toMap() => {
    'modelId': _modelId,
    'name': _name,
    'status': _status,
    'prompt': _prompt,
    'image': _image
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserModel";
    modelSchemaDefinition.pluralName = "UserModels";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'modelId',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'name',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'status',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'prompt',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'image',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Image')
    ));
  });
}