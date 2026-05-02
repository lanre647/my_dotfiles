vim.cmd([[
  call wilder#setup({'modes': [':', '/', '?']})

  call wilder#set_option('pipeline', wilder#branch(
        \ wilder#cmdline_pipeline({'fuzzy': 1}),
        \ wilder#search_pipeline()
        \ ))

  " Ensure truecolor
  if has('termguicolors')
    set termguicolors
  endif

  " Theme integration (no conflicts)
  highlight! link WilderNormal Pmenu
  highlight! link WilderBorder FloatBorder
  highlight! link WilderAccent PmenuSel

  call wilder#set_option('renderer', wilder#popupmenu_renderer({
        \ 'border': 'rounded',
        \ 'pumblend': 10,
        \ 'highlighter': wilder#basic_highlighter(),
        \ 'left': [' ', wilder#popupmenu_devicons()],
        \ 'right': [' ', wilder#popupmenu_scrollbar()],
        \ 'highlights': {
        \   'border': 'WilderBorder',
        \   'accent': 'WilderAccent',
        \ },
        \ }))
]])
