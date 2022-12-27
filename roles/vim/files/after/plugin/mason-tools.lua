require('mason-tool-installer').setup {
  ensure_installed = {
    'chrome-debug-adapter',
    'firefox-debug-adapter',
    'node-debug2-adapter',
  },
  auto_update = true,
}
