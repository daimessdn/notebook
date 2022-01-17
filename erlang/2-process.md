# Process

- satuan unit dari ***concurrency***.
- dapat berkomunikasi dengan proses lainnya.
- bersifat **ringan** (*lightweight*) karena tidak menggunakan memori (bisa dibilang seperti VM yang tidak menggunakan memori).
- bisa menerima (**statement receive**) dan mengirim pesan(**tanda seru**) (seperti komunikasi client dan server).

## Server

di `changecase_server.erl`:

```erlang
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
            Client ! {self(), string:to_upper(Str)}; % send to client

        {Client, {Str, lowercase}} -> 
            Client ! {self(), string:to_lower(Str)}  % send to client
    end,

    loop(). % recursion tail
```

### Testing di Terminal

1. Compile `changecase_server.erl`

   ```erlang
   1> c(changecase_server).
   {ok,changecase_server}
   ```

2. Inisiasi mulai server

   ```erlang
   2> ChangeCaseServer = changecase_server:start().
   <0.88.0>
   ```

3. Kirim perintah untuk membuat huruf kapital (`uppercase`)

   ```erlang
   3> ChangeCaseServer ! {self(), {"hello", uppercase}}.
   {<0.80.0>,{"hello",uppercase}}
   ```

4. Menerima respon

   ```erlang
   4> receive X -> X end.
   {<0.88.0>,"HELLO"}
   ```

## Client

```erlang
-module(changecase_client).
-export([changecase/3]).

changecase(Server, Str, Command) ->
    Server ! {self(), {Str, Command}},
    
    receive
        {Server, ResultString} ->
            ResultString
    end.
```

### Testing di terminal

1. Compile client dan server

   ```erlang
   1> c(changecase_server).
   {ok,changecase_server}
   2> c(changecase_client).
   {ok,changecase_client}
   ```

2. Inisiasi server sebagai variabel

   ```erlang
   3> ChangeCaseServer = changecase_server:start().
   <0.92.0>
   ```

3. Proses kirim dan terima pesan

   ```erlang
   4> changecase_client:changecase(ChangeCaseServer, "hello", uppercase).
   "HELLO"
   5> changecase_client:changecase(ChangeCaseServer, "HELLO", lowercase).
   "hello"
   ```

   

