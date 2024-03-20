local h = import 'helpers.libsonnet';

local unsolicitedApplicants = importstr 'unsolicited-applicants.txt';

local unsolicitedApplicantsAction = {
  archive: true,
  labels: ['Unsolicited Applicants'],
};

[
  {
    filter: {
      or: h.fromArray(unsolicitedApplicants),
    },
    actions: unsolicitedApplicantsAction,
  },
]
