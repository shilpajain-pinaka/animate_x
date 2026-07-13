# Security Policy

## Supported versions

Security fixes are provided for the latest published `1.x` release of
`animate_x`. Older versions are not maintained — please upgrade to the
latest version before reporting an issue.

| Version | Supported          |
| ------- | ------------------ |
| 1.x     | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a vulnerability

**Please do not report security vulnerabilities through public GitHub
issues, pull requests, or discussions.**

Instead, report them privately using one of the following:

- **GitHub Security Advisories** — open a private report via the
  ["Report a vulnerability"](https://github.com/shilpajain-pinaka/animate_x/security/advisories/new)
  button on the repository's **Security** tab (preferred), or
- **Email** — send details to the maintainer at
  `zhang@foxcomasia.com` with the subject line `[animate_x security]`.

To help us triage quickly, please include as much of the following as you
can:

- A description of the vulnerability and its potential impact.
- The `animate_x` version and Flutter/Dart SDK versions affected.
- Steps to reproduce, or a minimal proof-of-concept.
- Any known workarounds.

## What to expect

- **Acknowledgement** within 3 business days of your report.
- An initial assessment and severity estimate within 7 business days.
- Regular updates as we work on a fix.
- Coordinated disclosure: we will agree on a public disclosure date with
  you, and credit you in the release notes and advisory unless you prefer
  to remain anonymous.

## Scope

`animate_x` is a pure Dart/Flutter UI animation package. It does not make
network requests, read or write files, execute native code, or handle
credentials on its own. Reports are most relevant when they concern, for
example:

- Malicious input to a public API (e.g. `AnimateX`, `AnimationX`,
  `SwipeX`, `DragDropX`) that can crash, hang, or cause unbounded
  resource use in a host app.
- A supply-chain issue with the published package on pub.dev.

Issues in the bundled `example/` app that are specific to that demo (and
not to the published library code under `lib/`) are generally out of
scope.

Thank you for helping keep `animate_x` and its users safe.