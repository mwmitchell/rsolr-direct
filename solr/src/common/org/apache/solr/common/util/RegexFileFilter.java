/**
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.solr.common.util;

import java.io.File;
import java.io.FileFilter;
import java.util.regex.*;

/**
 * Accepts any file whose name matches the pattern
 * @version $Id: RegexFileFilter.java 824364 2009-10-12 14:41:51Z yonik $
 */
public final class RegexFileFilter implements FileFilter {

  final Pattern pattern;
  public RegexFileFilter(String regex) {
    this(Pattern.compile(regex));
  }
  public RegexFileFilter(Pattern regex) {
    pattern = regex;
  }
  public boolean accept(File f) {
    return pattern.matcher(f.getName()).matches();
  }
  public String toString() {
    return "regex:" + pattern.toString();
  }
}
