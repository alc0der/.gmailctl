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

// 1-1 Meeting Calendar Notifications
local oneOnOneFilter = {
  and: [
    { from: 'calendar-notification@google.com' },
    { subject: '1-1:' },
  ],
};

local oneOnOneRules = [
  {
    filter: oneOnOneFilter,
    actions: {
      archive: true,
      labels: [googleMeetLabel.name],
    },
  },
];

// Export all meeting app rules
googleMeetRules + oneOnOneRules
