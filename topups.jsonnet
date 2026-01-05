// Top-up and funding notification rules

local topUpLabel = { name: 'Account Top-ups' };

local openAITopUp = {
  filter: {
    and: [
      { from: 'billing@tm1.openai.com' },
      { subject: 'Your OpenAI API account has been funded' },
    ],
  },
  actions: {
    archive: true,
    markImportant: false,
    labels: [topUpLabel.name],
  },
};

local twilioTopUp = {
  filter: {
    and: [
      { from: 'no-reply@twilio.com' },
      { subject: 'Your Twilio account has been recharged' },
    ],
  },
  actions: {
    archive: true,
    markImportant: false,
    labels: [topUpLabel.name],
  },
};

// Export rules array
[
  openAITopUp,
  twilioTopUp,
]
