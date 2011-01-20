Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from willeweb.com ([166.70.233.13] helo=mail.willeweb.com)
	by casper.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Pg0vG-0002PV-T0
	for kexec@lists.infradead.org; Thu, 20 Jan 2011 20:15:59 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mail.willeweb.com (Postfix) with ESMTP id 88406121405C
	for <kexec@lists.infradead.org>; Thu, 20 Jan 2011 13:14:27 -0700 (MST)
From: wille <junk@willeweb.com>
Subject: kexec: Overlapping memory segments error
Date: Thu, 20 Jan 2011 13:14:27 -0700
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <201101201314.27153.junk@willeweb.com>
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

I am running a minimal system with a stripped down x86 2.6.32 Linux kernel.  
From this environment I kexec to an Ubuntu Lucid i386 2.6.32 kernel.  This 
works fine on *most* hardware, but on some machines the kexec -l fails with 
overlapping memory segments.

First I used the kexec which comes with the Lucid i386 distro (kexec-tools 
2.0.1 released 13th August 2009).  Then I built kexec from the head of the 
git tree, which includes the patch "kexec: fix /sys/firmware/memmap memory 
range overlaps".  I was hopeful this patch would fix my problem, but it 
still fails with an "Overlapping memory segments" error.

As a specific example, on a Dell Latitude E6410 (which uses an Intel i7 
processor) the kexec -l fails with the following messages:

    setup_linux_vesafb: 640x480x16 @ e1000000 +12c000
    Overlapping memory segments at 0x7ffff000

One final clue: if I do the same kexec -l, but without the --initrd option I 
don't get the "Overlapping memory segments..." message, but of course 
without an initrd the system doesn't boot.

Any ideas?

-wille

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
