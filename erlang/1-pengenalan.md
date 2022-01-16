# Apaan tuh Erlang?

- Functional programming language
- Dibuat untuk membuat sistem soft real-time, scalable secara masif (*massively*)

## Dokumentasi

https://www.erlang.org/docs

https://www.erlang.org/doc/

## Instalasi (di Ubuntu)

```bash
sudo apt-get install erlang
```

## Cara menjalankan Erlang console (setelah instalasi)

```bash
erl
```

```
dimaswehhh@HP-245-G7-Notebook-PC:~/Downloads$ erl
Erlang/OTP 24 [erts-12.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit]

Eshell V12.2  (abort with ^G)
1> 
```

## Aturan Dasar

### Penjumlahan (atau operasi aljabar lainnya)

```erlang
1> 2 + 2.
4
2> 

```

> 1. Ketika `erl` dimulai, sintaks **dimulai dari baris 1** (ditandai dengan `1> `)
> 2. Proses pada baris `>1 ` menunjukan penjumlahan dari 2 ditambah 2.
> 3. Tanda titik (`.`) di ujung sintaks menunjukkan **akhir *statement*** (sama seperti `;` di beberapa bahasa seperti `Java`, `PHP`,`JavaScript`, dll.)
> 4. Setelah `2 + 2.` diketikkan, akan muncul *output* di bawahnya (`4`) dan kemudian akan muncul baris `2> `, baris `3> ` (setelah baris `2>`, dst.).

### Inisiasi variabel

```erlang
2> Myvar = 12.
12
3> Myvar2 = 13.
13
4> Myvar2 = 13.
13
5> Myvar = 13. 
** exception error: no match of right hand side value 13
```

> 1. Inisiasi variabel
>    1. dimulai dengan **nama variabel**,
>    2. diikuti dengan **sama dengan** (`=`) dan **nilainya**,
>    3. serta diakhiri dengan **titik** (`.`).
> 2. Berbeda dengan berbagai bahasa lain (*imperative language*) pada umumnya, di Erlang tidak bisa mengubah nilai variabel (terlihat pada baris `5> `).

### Menulis `Hello, world!` dan menjalankannya di *console*

1. Buat file dengan nama `hello.erl`

   ```erlang
   -module(hello).
   -export([start/0]).
   
   start() ->
       io:format("Hello, world!~n").
   ```

2. Buka kembali terminal (`erl`)

   ```erlang
   1> c(hello).
   {ok,hello}
   2> c(hello1).
   {error,non_existing}
   3> hello:start().
   Hello, world!
   ok
   4> halt().
   ```

   > 1. Pada proses `1> ` : **import dari hello.erl**
   >    1. Akan muncul suatu file bernama `hello.beam`
   >    2. Respon `{ok,hello}` merupakan proses berhasil import
   > 2. Pada proses `1> ` : **import dari hello1.erl**
   >    1. Import gagal karena tidak ada file (`{error,non_existing}`)
   > 3. `3> `: Memanggil fungsi `hello:start().`
   >    1. Sebagai hasilnya, akan keluar tulisan `Hello, world!` dari fungsi start pada file `hello.erl` 
   > 4. `4>`: Keluar dari *console*.

### Compile file

```bash
erlc hello.erl
erl -noshell -s hello start -s init stop
```

> 1. `erlc` digunakan untuk meng-*compile* file `hello.erl` dengan hasil akan muncul `hello.beam`.
> 2. `erl -noshell -s hello start -s init stop` digunakan untuk menjalankan `hello.erl` yang sudah di-*compile*.