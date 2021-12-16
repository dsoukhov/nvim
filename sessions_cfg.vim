let g:startify_session_dir = '~/.local/share/nvim/sessions'

let g:startify_lists = [
         \ { 'type': 'sessions',  'header': ['   Sessions']       },
         \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
         \ { 'type': 'files',     'header': ['   MRU ']            },
         \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
         \ ]

let g:startify_bookmarks = [
           \ { 'w': '~/workspace' },
           \ { 'c': '~/.config' },
           \ { 'b': '~/.bashrc' },
            \ ]

let g:startify_skiplist = [ 'COMMIT_EDITMSG' ]
let g:startify_session_remove_lines = []
let g:startify_session_before_save = [ 'NvimTreeClose' ]
let g:startify_session_autoload = 1
let g:startify_change_to_vcs_root = 0
let g:startify_change_to_dir = 0
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 1
let g:startify_enable_special = 0
let g:startify_session_sort = 1
