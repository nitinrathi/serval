#### Requirements
* [lua](https://www.lua.org)
* [luarocks](https://luarocks.org)
* [nodemon](https://www.npmjs.com/package//nodemon)
* [fennel](https://fennel-lang.org)

#### Installing deps
```bash
mkdir -p lua_modules
luarocks --tree lua_modules install lsqlite3complete
luarocks --tree lua_modules install gumbo
luarocks --tree lua_modules install Lua-cURL CURL_INCDIR=/usr/include/x86_64-linux-gnu/
```

#### Run
```bash
make run
```

#### Test
```bash
make test
```

Few Resources and References

* https://leafo.net/guides/customizing-the-luarocks-tree.html#quick-guide
* https://openresty.org/en/using-luarocks.html
* https://github.com/Egor-Skriptunoff/pure_lua_SHA
