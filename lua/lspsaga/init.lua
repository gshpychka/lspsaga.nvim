local saga = {}

saga.config_values = {
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  dianostic_header_icon = '   ',
  -- code action title icon
  code_action_icon = ' ',
  finder_definition_icon = '  ',
  finder_reference_icon = '  ',
  max_preview_lines = 10,
  finder_action_keys = {
    open = 'o', vsplit = 's',split = 'i',quit = 'q',
    scroll_down = '<C-f>',scroll_up = '<C-b>'
  },
  code_action_keys = {
    quit = 'q',exec = '<CR>'
  },
  rename_action_keys = {
    quit = '<C-c>',exec = '<CR>'
  },
  definition_preview_icon = '  ',
  -- 1: thin border | 2: rounded border | 3: thick border
  border_style = 1,
  rename_prompt_prefix = '➤',
  server_filetype_map = {},
  -- hoverdoc float window size, relative to window width
  max_hoverdoc_width = 0.5
  max_hoverdoc_height = 0.5
}

local extend_config = function(opts)
  opts = opts or {}
  if next(opts) == nil then return  end
  for key,value in pairs(opts) do
    if saga.config_values[key] == nil then
      error(string.format('[LspSaga] Key %s not exist in config values',key))
      return
    end
    if type(saga.config_values[key]) == 'table' then
      for k,v in pairs(value) do
        saga.config_values[key][k] = v
      end
    else
      saga.config_values[key] = value
    end
  end
end

function saga.init_lsp_saga(opts)
  extend_config(opts)
  local diagnostic = require 'lspsaga.diagnostic'

  if saga.config_values.use_saga_diagnostic_sign then
    diagnostic.lsp_diagnostic_sign(saga.config_values)
  end
end

return saga
