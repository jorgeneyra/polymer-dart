// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library polymer.src.common.polymer_js_proxy;

import 'dart:html';
import 'dart:js';

import '../micro/properties.dart';

final JsObject _polymerDart = context['Polymer']['Dart'];
final JsObject _polymerDartBasePrototype = _polymerDart['Base']['prototype'];

final _customJsConstructorsByType = <Type, JsFunction>{};

/// Basic api for re-using the polymer js prototypes.
abstract class PolymerJsProxy {
  JsObject _jsThis;
  JsObject get jsThis {
    if (_jsThis == null) {
      _jsThis = new JsObject(_customJsConstructorsByType[this.runtimeType]);
      _jsThis['__proxy__'] = _jsThis['__data__']['__proxy__'] =
          new JsObject.fromBrowserObject(this);
    }
    return _jsThis;
  }

  void set(String path, value) =>
    jsThis.callMethod('set', [path, _jsValue(value)]);

  // TODO(jakemac): This doesn't really work, because we set properties on the
  // __data__ object to be getters and setters that read/write directly the
  // dart value.
  void notifyPath(String path, value) =>
    jsThis.callMethod('notifyPath', [path, _jsValue(value)]);

  // TODO(jakemac): investigate wrapping this object in something that
  // implements map, see
  // https://chromiumcodereview.appspot.com/23291005/patch/25001/26002 for an
  // example of this.
  JsObject get $ => jsThis[r'$'];

  dynamic _jsValue(value) =>
      (value is Iterable || value is Map) ? new JsObject.jsify(value) : value;
}

/// Creates a [JsFunction] constructor and prototype for a dart [Type].
JsFunction createJsConstructorFor(
    Type type, String tagName, Map<String, dynamic> hostAttributes) {
  JsFunction constructor = _polymerDart.callMethod('functionFactory', []);
  JsObject prototype = context['Object'].callMethod(
      'create', [_polymerDartBasePrototype]);
//  setupProperties(type, prototype);
  if (hostAttributes != null) {
    prototype['hostAttributes'] = new JsObject.jsify(hostAttributes);
  }
  prototype['is'] = tagName;

  constructor['prototype'] = prototype;
  _customJsConstructorsByType[type] = constructor;
  return constructor;
}