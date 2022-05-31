(local version (_VERSION:match "%d+%.%d+"))

(set package.path (.. :lua_modules/share/lua/ version
                      "/?.lua;lua_modules/share/lua/" version "/?/init.lua;"
                      package.path))
(set package.cpath (.. :lua_modules/lib/lua/ version "/?.so;" package.cpath))	
