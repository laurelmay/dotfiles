if not os.getenv('USER'):match('^kyle') then
  return {}
end

return {
  {
    "kylelaker/riscv.vim",
    dev = true,
    ft = "riscv",
  },
  {
    "kylelaker/cisco.vim",
    dev = true,
    ft = "cisco",
  },
  {
    "kylelaker/y86.vim",
    dev = true,
    -- ft = "y86",
    lazy = false,
  },
}
