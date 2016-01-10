# abquery

A tiny shell script for querying OSX's Address Book (Contacts.app) from the [Mutt](http://www.mutt.org/) email client.

I wrote it because [contacts](http://www.gnufoo.org/contacts/contacts.html) was not working correctly for me.

## Installation & Mutt Configuration

Copy the script in your `~/.mutt` directory and make it executable (`chmod +x ~/.mutt/abquery.sh`). Then, add the following lines in your `~/.mutt/muttrc` (or `~/.muttrc`, if you prefer) configuration file:

```
set query_command = "~/.mutt/abquery.sh '%s'"
bind editor <Tab> complete-query
```

## Usage

Run `mutt` and press `m` to start a new message. Type the first letters of your contact's name or email address and hit 'Tab'. The same applies to all *To:*, *Cc:* and *Bcc:* prompts in Mutt.

## License

This script is licensed under the [ISC license](http://opensource.org/licenses/ISC).
