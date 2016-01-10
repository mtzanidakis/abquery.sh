#!/bin/sh
#
# abquery.sh: a tiny script for querying OSX's Address Book (Contacts)
#             from the Mutt email client.
#
# Copyright (c) 2016 Manolis Tzanidakis <mtzanidakis [at] gmail [dot] com>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
# WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
# DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
# PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
# TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

# the addressbook database filename (OSX 10.10+)
# should need a version bump on future OSX releases
_abook=AddressBook-v22.abcddb

# the sql query to run
_query="SELECT ZABCDEMAILADDRESS.ZADDRESS AS 'email',
	(IFNULL(ZABCDRECORD.ZFIRSTNAME, '') || ' '
		|| IFNULL(ZABCDRECORD.ZLASTNAME, '')
	) AS 'name'
	FROM ZABCDEMAILADDRESS, ZABCDRECORD
	WHERE (ZABCDEMAILADDRESS.ZADDRESS LIKE '%${@}%'
		OR ZABCDRECORD.ZSORTINGLASTNAME LIKE '%${@}%')
		AND ZABCDEMAILADDRESS.ZOWNER=ZABCDRECORD.Z_PK
	ORDER BY ZABCDRECORD.ZSORTINGLASTNAME"

# header (somehow required by mutt for auto-completion)
echo "email\tname"

# run the query on all available address book databases and print the result
# in a mutt-friendly format (tab-separated email and name columns)
find ${HOME}/Library/Application\ Support/AddressBook -name ${_abook} -print0 |
	xargs -0 -I {} sqlite3 -separator $'\t' {} "${_query}"
