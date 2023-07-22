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


/** This is an auto generated class representing the Image type in your schema. */
class Image {
  final int? _height;
  final int? _width;
  final String? _path;

  int? get height {
    return _height;
  }
  
  int? get width {
    return _width;
  }
  
  String get path {
    try {
      return _path!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const Image._internal({height, width, required path}): _height = height, _width = width, _path = path;
  
  factory Image({int? height, int? width, required String path}) {
    return Image._internal(
      height: height,
      width: width,
      path: path);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Image &&
      _height == other._height &&
      _width == other._width &&
      _path == other._path;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Image {");
    buffer.write("height=" + (_height != null ? _height!.toString() : "null") + ", ");
    buffer.write("width=" + (_width != null ? _width!.toString() : "null") + ", ");
    buffer.write("path=" + "$_path");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Image copyWith({int? height, int? width, String? path}) {
    return Image._internal(
      height: height ?? this.height,
      width: width ?? this.width,
      path: path ?? this.path);
  }
  
  Image copyWithModelFieldValues({
    ModelFieldValue<int?>? height,
    ModelFieldValue<int?>? width,
    ModelFieldValue<String>? path
  }) {
    return Image._internal(
      height: height == null ? this.height : height.value,
      width: width == null ? this.width : width.value,
      path: path == null ? this.path : path.value
    );
  }
  
  Image.fromJson(Map<String, dynamic> json)  
    : _height = (json['height'] as num?)?.toInt(),
      _width = (json['width'] as num?)?.toInt(),
      _path = json['path'];
  
  Map<String, dynamic> toJson() => {
    'height': _height, 'width': _width, 'path': _path
  };
  
  Map<String, Object?> toMap() => {
    'height': _height,
    'width': _width,
    'path': _path
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Image";
    modelSchemaDefinition.pluralName = "Images";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'height',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'width',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'path',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}