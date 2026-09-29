# openssl-nt219-uit
Compile the latest openssl for UIT's cryptography course for Linux under a separate library path

# How to use

```bash
$ git clone https://github.com/devobass/openssl-nt219-uit

$ sudo ./compile.sh             # for gcc

$ sudo ./compile.sh --clang     # for clang
```


Use a shell alias to compile with the separate library.
```
alias "clang++nt129"="clang++ -I$PREFIX/include -L$PREFIX/lib64 -Wl,-rpath,$PREFIX/lib64 -lssl -lcrypto"
alias "g++nt129"="g++ -I$PREFIX/include -L$PREFIX/lib64 -Wl,-rpath,$PREFIX/lib64 -lssl -lcrypto"
```
