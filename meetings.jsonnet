local env = import 'env.libsonnet';

// Automated Meeting Apps Rules
// Archives meeting-related emails and adds appropriate labels for easy retrieval

local googleMeetLabel = {
  name: 'Google Meet',
};

// Google Meet
local googleMeetFilter = {
  from: 'meetings-noreply@google.com',
};

local googleMeetRules = [
  {
    filter: googleMeetFilter,
    actions: {
      archive: true,
      labels: [googleMeetLabel.name],
    },
  },
];

// Export all meeting app rules
googleMeetRules
