# Overview

Playing around with tanka and jsonnet using custom libs.

An example using https://github.com/nabadger/jsonnet-libs

Requires 
- https://github.com/grafana/tanka
- https://github.com/jsonnet-bundler/jsonnet-bundler

## Usage

```
jb install
```

```
tk show environments/dev/eu-dev1
```

## Rendering output via `make`

Finds all environments and renders the jsonnet to `./rendered` (via `tk export`)

```
make
```