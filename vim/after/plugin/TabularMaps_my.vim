if !exists(':Tabularize') || get(g:, 'no_default_tabular_maps', 0)
  finish " Tabular.vim wasn't loaded or the default maps are unwanted
endif

AddTabularPattern! files    /.\{-\}:.\{-\}:\zs/
AddTabularPattern! comments /\/\//

