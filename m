Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bw0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RPGOh-00033h-Jj
 for kexec@lists.infradead.org; Sat, 12 Nov 2011 16:25:41 +0000
Received: by bkat2 with SMTP id t2so6274473bka.36
 for <kexec@lists.infradead.org>; Sat, 12 Nov 2011 08:25:35 -0800 (PST)
Message-ID: <4EBE9DF9.8060700@googlemail.com>
Date: Sat, 12 Nov 2011 17:25:29 +0100
From: enaut <enaut.w@googlemail.com>
MIME-Version: 1.0
Subject: kexec problems booting grub4dos with kexec.
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

I am trying to get grub4dos running from kexec. On most computers it
does work however there are some that do not work.

The symptoms are: stopping at loading Grub. and/or: the graphics are not
reset.

To get the graphics right i tried to use the --reset-graphics option,
but the resolution in grub4dos is still unchanged.
this looks like all the text is there but far too small (like 3px font)
and it is duplicated so I actually have the output twice once on the
left and once on the right.

If I prevent the linux kernel that launches kexec from changing to the
screenresolution at least the fonts are right and not duplicated.

But still i don't get nothing more than the output "loading Grub".

The hardware in this case is Gigabyte M912: with Atom N270, 1GB RAM

The other problem that I have on all systems I tested it on is that in
the grub4Dos command prompt I do not have usb support. As most Systems
have usb-keybords this means that the only possibility to interact with
the shell is to connect a ps2 keyboard. The Usb drive it was started
from is not available anymore.

It would be nice to resolve at least some of those issues. What are the
possibilities to get more output? and what would be the best steps to
continue on this issue?

My kexec tools version is: kexec-tools 2.0.1 released 13th August 2009
and the kernel version: 3.0.8

Thanks for your help

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
