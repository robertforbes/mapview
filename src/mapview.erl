%% Experiment with the Cowboy web server.
-module(mapview).

%% Module API.
-export([start/1, stop/0]).

%% Exports required of a dispatcher.
%%-export([init/2]).
-export([init/3, handle/2, terminate/3]).

start(Port) ->
    %ok = application:start(crypto),    
    ok = application:start(ranch),    
    ok = application:start(cowlib),
    ok = application:start(cowboy),
    
    % Number of parallel processes to accept HTTP connections.
    N_acceptors = 10,

    %Dispatch = cowboy_router:compile([
    %    {'_', [{'_', mapview, []}]}]),

    Dispatch = cowboy_router:compile([
        {'_', [{"/upload", upload_handler, []},
               {'_', mapview, []}]}]),
    
    % Start the web server.
    cowboy:start_http(
        mapview, 
        N_acceptors, 
        [{port, Port}], 
        [{env, [{dispatch, Dispatch}]}]).

stop() ->
    application:stop(cowboy),
    application:stop(cowlib),
    application:stop(ranch),
    %application:stop(crypto),
    ok.

init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    {Path, Req1} = cowboy_req:path(Req),
    io:format("Path: ~p~n", [Path]),
    Response = read_file(Path),
    {ok, Req2} = cowboy_req:reply(200, [], Response, Req1),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.

%% Internal functions.
read_file(Path) ->
    File = ["."|binary_to_list(Path)],
    case file:read_file(File) of
        {ok, Bin} -> Bin;
        _ -> ["<pre>cannot read:", File, "</pre>"]
    end.


