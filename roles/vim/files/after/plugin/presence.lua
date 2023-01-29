require('presence'):setup {
  -- don't show presence information at work
  blacklist = (vim.startswith(vim.fn.hostname(), 'edc-') and { '**' }) or {},
}
