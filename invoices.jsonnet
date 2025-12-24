local env = import 'env.libsonnet';
// Invoices rules
local invoicesLabels = {
  name: 'Invoices',
};

local archiveInvoice = {
  archive: true,
  labels: [invoicesLabels.name],
};

local archiveAndForwardInvoice = archiveInvoice + {
    forward: env.invoice_beno_email,
};

// Cypress
local cypressFilter = { to: 'invoice+tech+cypress@beno.com' };
local cypressRules = [
  {
    filter: cypressFilter,
    actions: archiveInvoice,
  },
];

// Slack
local slackFilter = { to: 'invoice+slack@beno.com' };
local slackRules = [
  {
    filter: slackFilter,
    actions: archiveInvoice,
  },
];

// Google Workspace
local googleWorkspaceFilter = { to: 'invoice+google_workspace@beno.com' };
local googleWorkspaceRules = [
  {
    filter: googleWorkspaceFilter,
    actions: archiveInvoice,
  },
];

// Atlassian
local fromAtlassian = { from: 'no_reply@am.atlassian.com' };
local atlassianInvoicesSubject = {
  and: [
    fromAtlassian,
    { subject: 'Confirmation of your Atlassian order' },
  ],
};
local atlassianInvoiceSubject2 = {
  and: [
    fromAtlassian,
    { subject: 'Your payment has been processed for the invoice' },
  ],
};
local atlassianRules = [
    {
        filter: atlassianInvoicesSubject,
        actions: archiveAndForwardInvoice,
    },
    {
        filter: atlassianInvoiceSubject2,
        actions: archiveAndForwardInvoice,
    },
];

// PayPal
local paypalFilter = {
  and: [
    { from: 'service@intl.paypal.com' },
    { subject: 'You paid to ' },
  ],
};
local paypalRules = [
  {
    filter: paypalFilter,
    actions: archiveInvoice,
  },
];

// Slack invoices (not just renewal)
local slackInvoiceRules = [
  {
    filter: {
      and: [
        {
          from: 'feedback@slack.com',
        },
        {
          subject: "Beno, here's your monthly summary",
          isEscaped: true,
        },
      ],
    },
    actions: archiveInvoice,
  },
  {
    filter: {
      and: [
        { from: 'feedback@slack.com' },
        { subject: 'your plan has renewed' },
      ],
    },
    actions: archiveInvoice,
  },
];

// Anthropic
local anthropicInvoices = [
  {
    filter: {
      and: [
        { subject: 'Your receipt from Anthropic' },
        { query: 'has:attachment' },
      ],
    },
    actions: archiveInvoice,
  },
];

// AWS
local awsRules = [
    {
        filter: {
          and: [
            {
              from: 'no-reply-aws@amazon.com',
            },
            {
              query: 'has:attachment',
            },
          ],
        },
        actions: archiveAndForwardInvoice + {
          labels: [
            'AWS Invoices',
          ],
        },
    },
];

// Google Payments
local googlePaymentsRules = [
    {
        filter: {
          from: 'payments-noreply@google.com',
        },
        actions: archiveAndForwardInvoice,
    },
];

// Microsoft
local microsoftRules = [
    {
        filter: {
          and: [
            {
              from: 'microsoft-noreply@microsoft.com',
            },
            {
              query: 'invoice',
            },
          ],
        },
        actions: archiveInvoice,
    },
];

// APImetrics
local apimetricsRules = [
    {
        filter: {
          from: 'accounts@apimetrics.com',
        },
        actions: archiveAndForwardInvoice,
    },
];

// Auth0
local auth0Rules = [
    {
        filter: {
          or: [
            { from: 'invoice+statements@auth0.com' },
            { from: 'sales@auth0.com' },
          ],
        },
        actions: archiveAndForwardInvoice,
    },
];

// Twilio
local twilioRules = [
    {
        filter: {
          from: 'invoicing@twilio.com',
        },
        actions: archiveInvoice,
    },
];

// Opsgenie
local opsgenieRules = [
    {
        filter: {
          and: [
            {
              from: 'opsgenie@opsgenie.net',
            },
            {
              query: 'Opsgenie Payment Receipt',
            },
          ],
        },
        actions: archiveInvoice,
    },
];

// Apple
local appleRules = [
    {
        filter: {
          and: [
            {
              from: 'emea_invoicing@email.apple.com',
            },
            {
              subject: 'invoice',
            },
          ],
        },
        actions: archiveAndForwardInvoice,
    },
];


// OpenAI
local openAIRules = [
    {
        filter: {
          and: [
            {
              from: 'noreply@tm.openai.com',
            },
            { query: 'subject:(Your OpenAI API account has been funded)' },

          ],
        },
        actions: archiveInvoice,
    },
];

// Beno
local benoRules = [
    {
        filter: {
          from: env.invoice_beno_email,
        },
        actions: archiveInvoice,
    },
];

// 55 Degrees
local fiftyFiveDegreesRules = [
    {
        filter: {
          and: [
            {
              from: 'support@55degrees.se',
            },
            {
              to: 'invoice@beno.com',
            },
          ],
        },
        actions: archiveInvoice,
    },
];

// Link Wallet (Stripe)
local linkWalletRules = [
    {
        filter: {
          query: 'from:(invoice+statements*@stripe.com)',
        },
        actions: archiveAndForwardInvoice,
    },
];

// Orb
local orbRules = [
    {
        filter: {
          and: [
            {
              to: 'invoice@beno.com',
            },
            {
              query: 'from:(invoices+*@withorb.com) has:attachment',
            },
          ],
        },
        actions: archiveInvoice,
    },
];

cypressRules +
slackRules +
googleWorkspaceRules +
atlassianRules +
paypalRules +
slackInvoiceRules +
anthropicInvoices +
awsRules +
googlePaymentsRules +
microsoftRules +
apimetricsRules +
auth0Rules +
twilioRules +
opsgenieRules +
appleRules +
openAIRules +
benoRules +
fiftyFiveDegreesRules +
linkWalletRules +
orbRules
