return {
    "mfussenegger/nvim-dap-python",
    config = function()
        require("dap-python").setup("./.venv/bin/python")
      end
}
