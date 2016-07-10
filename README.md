## Setup

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

In a web broswer, the following link should now work:
http://localhost:8080/index.html

This will produce a list of target points on the runway at East Fortune. Moving either end of the slider control in the top right of the screen should change the number of displayed points.

