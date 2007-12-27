Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xenotime.net ([66.160.160.81])
	by bombadil.infradead.org with smtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J7iOg-0006lx-P6
	for kexec@lists.infradead.org; Thu, 27 Dec 2007 02:23:06 +0000
Received: from midway.site ([71.117.233.180]) by xenotime.net for
	<kexec@lists.infradead.org>; Wed, 26 Dec 2007 18:15:41 -0800
Date: Wed, 26 Dec 2007 18:15:41 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Fw: [Bugme-new] [Bug 9641] New: kexec userspace utilities cannot
	handle a kernel command line longer than 256 chars
Message-Id: <20071226181541.ef35531b.rdunlap@xenotime.net>
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


Begin forwarded message:

Date: Wed, 26 Dec 2007 16:26:36 -0800 (PST)
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 9641] New: kexec userspace utilities cannot handle a kernel command line longer than 256 chars


http://bugzilla.kernel.org/show_bug.cgi?id=9641

           Summary: kexec userspace utilities cannot handle a kernel command
                    line longer than 256 chars
           Product: Other
           Version: 2.5
     KernelVersion: 2.6.23
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
        AssignedTo: other_other@kernel-bugs.osdl.org
        ReportedBy: bluebird@mnet-online.de


This doesn't affect the kernel but the userspace utilities from
http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/

Since 2.6.21 the maximum length of the kernel command line is 2048 for x86 and
x86_64 but the kexec-tools still assume it's 256 therefore a command line
longer than 256 chars is truncated upon kexec-reboot.

Steps to reproduce:
- Boot kernel with a command line longer than 256 chars
- cat /proc/cmdline | wc -c
- kexec-reboot
- cat /proc/cmdline | wc -c


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
