## Setup

It is necessary to have Erlang installed in (tested with v18) order to run this application.

Fetch dependencies:
```
./rebar get-deps

```
Compile
```
./rebar compile
```
Start shell/application
```
./rebar shell
```
In the Erlang shell, switch to the htdocs folder and start the web server:
```
1> cd("htdocs").
2> mapview:start(8080).
```
The link http://localhost:8080/index1.html shows some dwells and a few points.

Moving either end of the slider control in the top right of the screen should change the number of displayed dwellsand associated points.

