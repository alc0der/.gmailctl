# Directory Overview

This directory contains the configuration for `gmailctl`, a tool for managing Gmail filters as code. The setup is designed to be reusable and to make it easy to add new email addresses to blocklists.

# Key Files

*   `gmailctl.libsonnet`: A library of functions for creating Gmail filter rules.
*   `helpers.libsonnet`: Contains helper functions for reading and parsing lists of email addresses from text files.
*   `coldCallers.jsonnet`, `dmarc.jsonnet`, `unsolicited-applicants.jsonnet`, `unsubscribed.jsonnet`: These files define the filter rules for different categories of emails. They import email addresses from the corresponding `.txt` files.
*   `coldcallers.txt`, `dmarc.txt`, `dmarc-group.txt`, `unsolicited-applicants.txt`, `unsubscribed.txt`: These files contain lists of email addresses, one per line.

# Usage

The primary use of this directory is to manage Gmail filters.

## Adding a new email address to a blocklist

To add a new email address to a list, append it to the corresponding `.txt` file. For example, to add a new cold caller:

```shell
echo "new.cold.caller@example.com" >> coldcallers.txt
```

## Applying the filters

To apply the filters to your Gmail account, you would typically run `gmailctl` and point it to your main configuration file. The `README.md` suggests that the main configuration file is not included in this repository for security reasons, but it would look something like this:

```jsonnet
{
  rules: originalRules + dmarcRules + coldCallingRules
}
```

Where `dmarcRules` and `coldCallingRules` are imported from the `.jsonnet` files in this directory.
