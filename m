Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xenotime.net ([66.160.160.81])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IOgug-0006cq-Mc
	for kexec@lists.infradead.org; Fri, 24 Aug 2007 17:41:58 -0400
Received: from midway.site ([96.225.192.201]) by xenotime.net for
	<kexec@lists.infradead.org>; Fri, 24 Aug 2007 14:41:48 -0700
Date: Fri, 24 Aug 2007 14:41:47 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: kexec+kdump + vmcoreinfo patch
Message-Id: <20070824144147.5e1cadc2.rdunlap@xenotime.net>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

I'm trying to use the recent vmcoreinfo patch...

a.  It appears that the latest kexec-tools-testing snapshot is from
20070330.  Do I need a more recent kexec-tools in order to use the
vmcoreinfo patch?

Is there still a kexec-tools & this kexec-tools-testing, or is
-testing the primary one now?

Could there be more frequent snapshots (tarballs), please?

b.  (using x86_64)

When I use "kexec -p /boot/bzImage", I get this output:

setup_linux_vesafb: 1024x768x16 @ b8000000 +300000

What does this mean?  Is it info only, or is it a warning or error?


c.  My 2.6.23-rc3 dump-capture kernel currently faults a few times,
then it panics.  I'll add a serial console and capture its output
to see what is going on.

Thanks.
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
