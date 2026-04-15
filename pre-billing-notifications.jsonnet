// Pre-billing notification rules
// Matches emails warning about upcoming charges/renewals

local preBillingLabel = 'Notifications/Pre-billing';

local preBillingActions = {
  archive: true,
  markImportant: false,
  labels: [preBillingLabel],
};

// ChatGPT / OpenAI
local chatGPTRenewal = {
  filter: {
    and: [
      { from: 'noreply@tm.openai.com' },
      { subject: 'Your Business subscription renews soon' },
    ],
  },
  actions: preBillingActions,
};

// Export rules array
[
  chatGPTRenewal,
]
