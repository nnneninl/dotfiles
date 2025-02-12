vim.keymap.set("n", "<LEADER>xe", "oif err != nil {<CR>}<ESC><S-o>return err;<ESC>", { desc = "Add error handling." })
