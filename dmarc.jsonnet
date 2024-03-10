local h = import 'helpers.libsonnet';

local dmarc = importstr 'dmarc.txt';
local dmarcGroup = importstr 'dmarc-group.txt';

local dmarcAction = {
  archive: true,
  labels: ['DMARC'],
};

[
  {
    filter: {
      or: h.fromArray(dmarc),
    },
    actions: dmarcAction,
  },
  {
    filter: {
      or: h.replyToArray(dmarcGroup),
    },
    actions: dmarcAction,
  },
]
