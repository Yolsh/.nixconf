{
    config.vim = {
        theme = {
            enable = true;
            name = "gruvbox";
            style = "dark";
        };

        lsp.enable = true;
        languages = {
            enableFormat = true;
            enableTreesitter = true;
            
            nix.enable = true;
            markdown.enable = true;
            bash.enable = true;
            python.enable = true;

        };

        autopairs.nvim-autopairs.enable = true;
    };
}