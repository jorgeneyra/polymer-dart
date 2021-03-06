Polymer.dart
============

Polymer.dart is a set of comprehensive UI and utility components
for building web applications.
With Polymer.dart's custom elements, templating, data binding,
and other features,
you can quickly build structured, encapsulated, client-side web apps.

Polymer.dart is a Dart port of
[Polymer][polymer] created and maintained by the Dart team.
The Dart team is collaborating with the Polymer team to ensure that polymer.dart
elements and polyfills are fully compatible with Polymer.

Polymer.dart replaces Web UI, which has been deprecated.


Learn More
----------

* The [Polymer.dart][home_page] homepage
contains a list of features, project status,
installation instructions, tips for upgrading from Web UI,
and links to other documentation.

* See our [TodoMVC][] example by opening up the Dart Editor's Welcome Page and
selecting "TodoMVC".

* For more information about Dart, see <https://www.dartlang.org/>.

* When you use this package,
you automatically get the
[polymer_expressions][] package,
which provides an expressive syntax for use with templates.


Try It Now
-----------
Add the polymer.dart package to your pubspec.yaml file:

```yaml
dependencies:
  polymer: ">=0.16.0 <0.17.0"
```

Instead of using `any`, we recommend using version ranges to avoid getting your
project broken on each release. Using a version range lets you upgrade your
package at your own pace. You can find the latest version number at
<https://pub.dartlang.org/packages/polymer>.


Building and Deploying
----------------------

To build a deployable version of your app, add the polymer transformers to your
pubspec.yaml file:

```yaml
transformers:
- polymer
```

Then, run `pub build`.  The polymer transformers assume all files under `web`
are possible entry points, this can be adjusted with arguments in your
pubspec.yaml file. For example, you can say only `web/index.html` is an entry
point as follows:

```yaml
transformers:
- polymer:
    entry_points: web/index.html
```

Here is a list of arguments used by the polymer transformers:
* js: whether to load JS code directly. By default polymer converts your app's
  html file to load the compiled JS code directly. Setting this parameter to
  false will keep a dart script tag and the `dart.js` script tag on the page.

* csp: whether to load a Content Security Policy (CSP) compliant JS file.
  Dart2js generates two JS files, one that is not CSP compilant and one that is.
  By default, polymer uses the former becuase it's likely more efficient, but
  you can choose the latter by setting this flag.

* entry_points: can be a list of entry points or, for convenience, a single
  entry point as shown above.

For example, this specification includes 2 entrypoints and chooses the CSP
compliant JS file:

```yaml
transformers:
- polymer:
    entry_points:
    - web/index.html
    - web/index2.html
    csp: true
```

Testing
-------

Polymer elements can be tested using either the original `unittest` or new `test` packages. In both cases the easiest way to create a test is by using the default main from `polymer/init.dart` and then defining all your tests inside of a method marked with an `@whenPolymerReady` annotation.

```dart
import 'package:polymer/polymer.dart';
export 'package:polymer/init.dart';

@whenPolymerReady
void runTests() {
  // Define your tests here.
}
```

You will also need to define a custom html file for your test (see the README for the testing package you are using for more information on this).

**Note**: If you are using the new `test` package, it is important that you add the `test` transformer after the polymer transformer, so it should look roughly like this:

```yaml
transformer:
- polymer:
    entry_points:
      - test/my_test.html
- test/pub_serve:
    $include: test/**_test{.*,}.dart
```

Contacting Us
-------------

Please file issues in our [Issue Tracker][issues] or contact us on the
[Dart Web mailing list][mailinglist].

We also have a [Dart Slack Channel][devlist] for discussions about
internals of the code, code reviews, etc.

[wc]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/explainer/index.html
[pub]: http://www.dartlang.org/docs/pub-package-manager/
[cs]: http://www.chromium.org/developers/testing/webkit-layout-tests
[cs_lucid]: http://gsdview.appspot.com/dartium-archive/continuous/drt-lucid64.zip
[cs_mac]: http://gsdview.appspot.com/dartium-archive/continuous/drt-mac.zip
[cs_win]: http://gsdview.appspot.com/dartium-archive/continuous/drt-win.zip
[dartium_src]: https://github.com/dart-lang/sdk
[TodoMVC]: http://todomvc.com/
[issues]: https://github.com/dart-lang/polymer-dart/issues/new
[mailinglist]: https://groups.google.com/a/dartlang.org/forum/?fromgroups#!forum/web
[devlist]: https://dartlang-slack.herokuapp.com/
[overview]: http://www.dartlang.org/articles/dart-web-components/
[tools]: https://www.dartlang.org/articles/dart-web-components/tools.html
[spec]: https://www.dartlang.org/articles/dart-web-components/spec.html
[features]: https://www.dartlang.org/articles/dart-web-components/summary.html
[home_page]: https://www.dartlang.org/polymer-dart/
[polymer_expressions]: https://pub.dartlang.org/packages/polymer_expressions
[polymer]: https://www.polymer-project.org/
