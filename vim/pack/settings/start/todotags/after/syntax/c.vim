" Highlight TODO_CLEANUP etc. in addition to TODO
syn match   TodoTags         '\(TODO\|NOTE\|FIXME\|BOZO\)_\w\+'
syn cluster cCommentGroup    add=TodoTags
hi def link TodoTags         Todo
