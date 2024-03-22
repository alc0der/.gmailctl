local h = import 'helpers.libsonnet';

local unsubscribed = importstr 'unsubscribed.txt';

local unsubscribedAction = {
  archive: true,
  labels: ['unsubscribed'],
};

[
  {
    filter: {
      or: h.fromArray(unsubscribed),
    },
    actions: unsubscribedAction,
  },
]
