/* Copyright 2017 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.google.api.codegen.transformer.csharp;

import static com.google.common.truth.Truth.assertThat;

import com.google.api.codegen.transformer.ModelTypeNameConverterTestUtil;
import com.google.api.codegen.util.csharp.CSharpAliasMode;
import com.google.api.codegen.util.csharp.CSharpTypeTable;
import com.google.api.tools.framework.model.EnumValue;
import com.google.api.tools.framework.model.TypeRef;
import org.junit.ClassRule;
import org.junit.Test;
import org.junit.rules.TemporaryFolder;

public class CSharpModelTypeNameConverterTest {

  @ClassRule public static TemporaryFolder tempDir = new TemporaryFolder();

  @Test
  public void testGetEnumValue() {
    String packageName = "Google.Example.Library.V1";
    TypeRef type = ModelTypeNameConverterTestUtil.getTestEnumType(tempDir);
    EnumValue value = type.getEnumType().getValues().get(0);
    CSharpTypeTable typeTable = new CSharpTypeTable(packageName, CSharpAliasMode.Global);
    CSharpModelTypeNameConverter converter = new CSharpModelTypeNameConverter(typeTable);

    assertThat(converter.getEnumValue(type, value).getValueAndSaveTypeNicknameIn(typeTable))
        .isEqualTo("Book.Types.Rating.Good");
  }
}
