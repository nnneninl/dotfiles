local map = function(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

-- buffer
map("n", "[b", "<CMD>bprevious<CR>", "Go to previous buffer.")
map("n", "]b", "<CMD>bnext<CR>", "Go to next buffer.")
map("n", "<LEADER>bd", "<CMD>bdelete<CR>", "Delete current buffer.")

-- quickfix
map("n", "[c", "<CMD>cprevious<CR>", "Go to previous quickfix item.")
map("n", "]c", "<CMD>cnext<CR>", "Go to next quickfix item.")
map("n", "<LEADER>co", "<CMD>copen<CR>", "Open quickfix window.")

-- text manipulation
map("n", "x", '"_x', "Delete character into void register.")
map("n", "<S-j>", "mzJ`z", "Concatenate with line below.")
map("v", "<S-j>", ":m '>+1<CR>gv=gv", "Move selection down and autoindent.")
map("v", "<S-k>", ":m '<-2<CR>gv=gv", "Move selection up and autoindent.")
map("v", "<LEADER>y", '"+y', "Yank selected text to system clipboard.")
map("n", "<LEADER>p", '"+p', "Paste after cursor from system clipboard.")
map("n", "<LEADER><S-p>", '"+<S-p>', "Paste before cursor from system clipboard.")
map("n", "<S-s>", ":%s/", "Search and replace.")

-- navigation
map("n", "<C-d>", "<C-d>zz", "Half page down and center screen.")
map("n", "<C-u>", "<C-u>zz", "Half page up and center screen.")
map("n", "n", "nzzzv", "Move to next search result and center screen.")
map("n", "<S-n>", "<S-n>zzzv", "Move to previous search result and center screen.")

-- other
--map("n", "<LEADER>e", "<CMD>Explore<CR>", "Open NetRW.")
map("n", "<LEADER>s", "<CMD>lua vim.o.spell = not vim.o.spell<CR>", "Toggle spellcheck.")
