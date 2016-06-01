#!/bin/sh

#
# Copyright (c) 2015 Wi-Fi Alliance
# 
# Permission to use, copy, modify, and/or distribute this software for any 
# purpose with or without fee is hereby granted, provided that the above 
# copyright notice and this permission notice appear in all copies.
# 
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES 
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF 
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY 
# SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER 
# RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
# USE OR PERFORMANCE OF THIS SOFTWARE.
#
# 
#
# $1 is tmp file name
# $2 is the interface name

out=$1
if=$2

echo -n "dhcpcli=" > $out; echo `ps -o args ax | awk "/^(\/sbin\/)?(dhclient|udhcpc)/ && / $if( |$)/"` >> $out
echo -n "mac=" >> $out; echo `ifconfig $if | awk '/(ether|address:|laddr)/{print \$2} /HWaddr/{print \$5}'` >> $out
echo -n "ipaddr=" >> $out; echo `ifconfig $if | awk -F '[: ]'+ '/inet [1-9]/{print \$3} /inet addr:/{print \$4}'` >> $out
echo -n "bcast=" >> $out; echo `ifconfig $if | awk -F '[: ]'+ '/inet [1-9]/{print \$7} /inet addr:/{print \$6}'` >> $out
echo -n "mask=" >> $out; echo `ifconfig $if | awk -F '[: ]'+ '/inet [1-9]/{print \$5} /inet addr:/{print \$8}'` >> $out
grep nameserver /etc/resolv.conf >> $out
