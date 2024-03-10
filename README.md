# My Gmail Config

My Gmail Settings. The repository aims to:
- Read and edit Gmail config as code
- Reuse common settings for any Gmail account. This is why it is public.
- Reduce friction with Gmailctl by quickly adding addresses to text files


Currently, I am not publishing the main `config.jsonnet` because it contains sensitive information. I am only publishing cold calling lists, and DMARC.
These two lists contains many addresses. The cold-calling list is editted frequently.


# Usage

1. Add a cold caller:
```shell
pbpaste >> ~/.gmailctl/coldcallers.txt
```

2. Add a DAMARC.
If the email is addressed to me:
```shell
pbpaste >> ~/.gmailctl/dmarc.txt
```
If the email is to Google group:
```shell
pbpaste >> ~/.gmailctl/dmarc-group.txt
```

# Configure

Add the ready made lists to `config.jsonnet`:
```jsonnet
{
  rules: originalRules + dmarcRules + coldCallingRules
}
```

> [note]
> this is a partial file

# About Cold Calling

If your email address is here, then it is yourfault for sending a promotional email without option to unsubscribe.
If you believe your email is added wrongfully then open an issue in this repo.
