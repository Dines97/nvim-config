local function config()
  local builtin = require("statuscol.builtin")
  local cfg = {
    separator              = false, -- separator between line number and buffer text ("│" or extra " " padding)
    -- Builtin line number string options for ScLn() segment
    thousands              = false, -- or line number thousands separator string ("." / ",")
    relculright            = false, -- whether to right-align the cursor line number with 'relativenumber' set
    -- Custom line number string options for ScLn() segment
    lnumfunc               = nil, -- custom function called by ScLn(), should return a string
    reeval                 = false, -- whether or not the string returned by lnumfunc should be reevaluated
    -- Builtin 'statuscolumn' options
    setopt                 = true, -- whether to set the 'statuscolumn', providing builtin click actions
    order                  = "FSNs", -- order of the fold, sign, line number and separator segments
    -- Click actions
    Lnum                   = builtin.lnum_click,
    FoldPlus               = builtin.foldplus_click,
    FoldMinus              = builtin.foldminus_click,
    FoldEmpty              = builtin.foldempty_click,
    DapBreakpointRejected  = builtin.toggle_breakpoint,
    DapBreakpoint          = builtin.toggle_breakpoint,
    DapBreakpointCondition = builtin.toggle_breakpoint,
    DiagnosticSignError    = builtin.diagnostic_click,
    DiagnosticSignHint     = builtin.diagnostic_click,
    DiagnosticSignInfo     = builtin.diagnostic_click,
    DiagnosticSignWarn     = builtin.diagnostic_click,
    GitSignsTopdelete      = builtin.gitsigns_click,
    GitSignsUntracked      = builtin.gitsigns_click,
    GitSignsAdd            = builtin.gitsigns_click,
    GitSignsChangedelete   = builtin.gitsigns_click,
    GitSignsDelete         = builtin.gitsigns_click,
  }
  require("statuscol").setup(cfg)


end

return { "luukvbaal/statuscol.nvim", config = config }
