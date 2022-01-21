# dargon2 plugins

This repository hosts all the dargon2 plugins:
- [dargon2]
- [dargon2_flutter]
  - Along with its dependencies:
    - [dargon2_flutter_platform_interface]
    - [dargon2_flutter_mobile]
    - [dargon2_flutter_web]
- [dargon2_core]
- [dargon2_interface]

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

[dargon2]: https://github.com/tmthecoder/dargon2/blob/main/dargon2
[dargon2_flutter]: https://github.com/tmthecoder/dargon2/blob/main/dargon2_flutter/dargon2_flutter
[dargon2_flutter_platform_interface]: https://github.com/tmthecoder/dargon2/blob/main/dargon2_flutter/dargon2_flutter_platform_interface
[dargon2_flutter_mobile]: https://github.com/tmthecoder/dargon2/blob/main/dargon2_flutter/dargon2_flutter_mobile
[dargon2_flutter_web]: https://github.com/tmthecoder/dargon2/blob/main/dargon2_flutter/dargon2_flutter_web
[dargon2_core]: https://github.com/tmthecoder/dargon2/blob/main/dargon2_core
[dargon2_interface]: https://github.com/tmthecoder/dargon2/blob/main/dargon2_interface

[MIT License]: https://github.com/tmthecoder/dargon2/blob/main/LICENSE
