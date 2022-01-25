# dargon2 plugins

![dargon2](https://github.com/tmthecoder/dargon2/workflows/dargon2/badge.svg)
[![dargon2_flutter](https://github.com/tmthecoder/dargon2/actions/workflows/dargon2_flutter_tests.yml/badge.svg?branch=main)](https://github.com/tmthecoder/dargon2/actions/workflows/dargon2_flutter_tests.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

This repository hosts all the dargon2 plugins:

| Plugin              | Pub                                                                                                              |
|---------------------|------------------------------------------------------------------------------------------------------------------|
| [dargon2]           | [![pub package](https://img.shields.io/pub/v/dargon2.svg)](https://pub.dev/packages/dargon2)                     |
| [dargon2_flutter]   | [![pub package](https://img.shields.io/pub/v/dargon2_flutter.svg)](https://pub.dev/packages/dargon2_flutter)     |
| [dargon2_core]      | [![pub package](https://img.shields.io/pub/v/dargon2_core.svg)](https://pub.dev/packages/dargon2_core)           |
| [dargon2_interface] | [![pub package](https://img.shields.io/pub/v/dargon2_interface.svg)](https://pub.dev/packages/dargon2_interface) |

As well as [dargon2_flutter]'s federated-plugin dependencies:
- [dargon2_flutter_platform_interface]
- [dargon2_flutter_mobile]
- [dargon2_flutter_web]
- [dargon2_flutter_desktop]

Each plugin has its own functionality, but at their core, they provide some functionality necessary to implement argon2 password hashing in Dart or Flutter applications.

## Single Repo

If you've used any of these plugins before, you may have noticed many of these plugins spread across GitHub Repositories

I decided it's best to migrate to this single repository structure since each plugin is often developed while referencing another. As such, I figure its best to store the plugins in the same manner I'm often working on them and reduce inter-repository navigation

Also, in the case of issue tracking and pull-requests, I can easily view individual changes to a single plugin in context of the whole structure, which is especially important when changes come to `dargon2_flutter_platform_interface`, `dargon2_core`, or `dargon2_interface` as those plugins can carry a cascading affect

This single repository migration brings NO breaking changes or plugin functionality changes. While future functionality changes may be announced as they are ready, this repository change comes with ZERO changes.

## Features and Bugs

Please file feature requests and bugs at the [issue tracker].

If possible, please mark issues with the specific plugin it relates to by prepending `[plugin_name]` to the issue title 

[issue tracker]: https://github.com/tmthecoder/dargon2/issues

## Licensing

All dargon2 projects are licensed under the [MIT License], found on either within each plugin's directory or here.

[dargon2]: ./dargon2 
[dargon2_flutter]: ./dargon2_flutter/dargon2_flutter 
[dargon2_flutter_platform_interface]: ./dargon2_flutter/dargon2_flutter_platform_interface 
[dargon2_flutter_mobile]: ./dargon2_flutter/dargon2_flutter_mobile
[dargon2_flutter_web]: ./dargon2_flutter/dargon2_flutter_web
[dargon2_flutter_desktop]: ./dargon2_flutter/dargon2_flutter_desktop
[dargon2_core]: ./dargon2_core
[dargon2_interface]: ./dargon2_interface

[MIT License]: ./LICENSE
