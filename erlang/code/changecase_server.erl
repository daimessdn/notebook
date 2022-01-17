-module(changecase_server).
-export([start/0, loop/0]).

% init'd server
start() ->
    % spawn bertujuan untuk inisiasi proses
    spawn(changecase_server, loop, []).

% loop server
loop() ->
    receive
        % pattern matching
        {Client, {Str, uppercase}} ->
            Client ! {self(), string:to_upper(Str)}; % send to client args: process id, string to return

        {Client, {Str, lowercase}} -> 
            Client ! {self(), string:to_lower(Str)}  % send to client
    end,

    loop(). % recursion tail