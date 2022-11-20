
let s:config_path = expand('<sfile>:p:h')
set runtimepath^=$config_path

lua require("init")

