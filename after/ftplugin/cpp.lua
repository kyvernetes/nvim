local cmp = require("cmp")
local cfg = cmp.get_config()
table.insert(cfg.sources, { name = "buffer-lines" })
cmp.setup(cfg)
