### Installing deps
```bash
cd crawler
luarocks --tree lua_modules install lsqlite3complete
luarocks --tree lua_modules install gumbo
luarocks --tree lua_modules install Lua-cURL CURL_INCDIR=/usr/include/x86_64-linux-gnu/
```

### Run
```bash
cd crawler
fennel -l ini.fnl main.fnl
```

### Test
```bash
cd crawler
fennel -l ini.fnl test.fnl
```

Few Resources and Referances

* https://leafo.net/guides/customizing-the-luarocks-tree.html#quick-guide
* https://github.com/rxi/lume/blob/master/lume.lua
* https://openresty.org/en/using-luarocks.html
