return {
  'rmagatti/auto-session',
  lazy = false,
  config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/projects", "~/downloads", "/"},
        auto_session_create_enabled = true,
        auto_session_enable_last_session = false,
        auto_restore_enabled=false,  -- Doesn't automatically restore with `nvim`. Needs to use :SessionRestore
      }
  end
}
