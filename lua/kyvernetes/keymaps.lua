local map = vim.keymap.set

map("n", "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true, silent = true })
map("n", "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true, silent = true })

map("n", "<C-h>", "<C-w>h", { desc = "Go to the left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to the window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to the above window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to the right window" })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window breadth" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window breadth" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<leader>x", [[:%s/\V<C-r>///g<left><left>]], { desc = "Replace text searched" })
map("v", "<leader>x", [[:s/\V<C-r>///g<left><left>]], { desc = "Replace text searched" })

map({ "n", "x" }, "c", [["_c]])
map("n", "cc", [["_cc]])
map("n", "x", [["_x]])
map("n", "<leader>ss", "<cmd>silent %y+<cr>", { silent = true })

map("v", ">", ">gv")
map("v", "<", "<gv")

map("t", "<esc>", [[<C-\><C-n>]])
map("t", "<C-h>", "<cmd>wincmd h<cr>")
map("t", "<C-j>", "<cmd>wincmd j<cr>")
map("t", "<C-k>", "<cmd>wincmd k<cr>")
map("t", "<C-l>", "<cmd>wincmd l<cr>")
map("t", "<C-w>", [[<C-\><C-n><C-w>]])
