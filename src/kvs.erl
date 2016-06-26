-module(kvs).

-export([start/0, store/2, lookup/1]).

start() ->
    register(?MODULE, spawn(fun()-> loop() end)).

store(Key, Value) ->
    rpc({store, Key, Value}).

lookup(Key) ->
    rpc({lookup, Key}).

rpc(Q) ->
    ?MODULE ! {self(), Q},
    receive
        {?MODULE, Reply} ->
            Reply
    end.

loop() ->
    receive
        {From, {store, Key, Value}} ->
            put(Key, {ok, Value}),
            From ! {?MODULE, {ok, true}},
            loop();
        {From, {lookup, Key}} ->
            From ! {?MODULE, get(Key)},
            loop()
    end.
