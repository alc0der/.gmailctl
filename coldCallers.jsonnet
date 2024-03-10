local h = import 'helpers.libsonnet';

local coldCallers = importstr 'coldcallers.txt';

local coldCallingAction = {
  archive: true,
  markImportant: false,
  category: 'promotions',
  labels: ['Cold Calling'],
};
[  // how to rename in vim
  {
    filter: {
      or: h.fromArray(coldCallers),
    },
    actions: coldCallingAction,
  },
]
