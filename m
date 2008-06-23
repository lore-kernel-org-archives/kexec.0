Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KAmnY-0004sB-R6
	for kexec@lists.infradead.org; Mon, 23 Jun 2008 14:13:39 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5NE8k55031673
	for <kexec@lists.infradead.org>; Mon, 23 Jun 2008 10:08:46 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5NEDEGq149014
	for <kexec@lists.infradead.org>; Mon, 23 Jun 2008 08:13:16 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5NED70w012726
	for <kexec@lists.infradead.org>; Mon, 23 Jun 2008 08:13:13 -0600
Subject: [RFC] [KDUMP] [PROPOSED WORK] kdump on Xen hypervisor and guests,
	more tests for utilities, like makedumpfile, mkdumprd, kexec etc
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 23 Jun 2008 19:42:50 +0530
Message-Id: <1214230370.4719.53.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Reply-To: subrata@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: "poornima.nayak" <poornima.nayak@in.ibm.com>, sachinp <sachinp@linux.vnet.ibm.com>, Mike Frysinger <vapier@gentoo.org>, "iranna.ankad" <iranna.ankad@in.ibm.com>, Cai Qian <qcai@redhat.com>, kexec@lists.infradead.org, Masatake YAMATO <yamato@redhat.com>, maknayak <maknayak@in.ibm.com>, risrajak <risrajak@in.ibm.com>, hbabu@us.ibm.com, Patrick Kirsch <pkirsch@suse.de>, vgoyal@redhat.com, Jeff Burke <jburke@redhat.com>, inddurai <inddurai@in.ibm.com>, risrajak <risrajak@linux.vnet.ibm.com>

Hi,

Cai has proposed to work on the above LTP-KDUMP test cases
enrichment/enhancements. Please let us know about your views on the
same. We encourage people to review his proposal and the corresponding
upcoming test cases. I am going to put this soon on the LTP-KDUMP plan
document.

http://ltp.cvs.sourceforge.net/ltp/ltp/testcases/kdump/doc/TEST_PLAN.txt,

Regards--
Subrata

..................................

Here is my first draft plan of Kexec/Kdump tests enhancement sorted by
priorities. I would like to add them as many as possible.

== filtered vmcore utilities ==
- in different compressed levels, verify the vmcore with the correct
  layout. 
- verify it in flat file or ELF formats from a network host.

== analyse vmcore utilities ==
- GDB
- crash with better error detecting.
- crash to analyse Hypervisor and Dom0 Kernel.

== test scripts ==
- timestamp information for crash was triggered, vmcore was generated,
  and vmcore was verified.
- aim to 100% automation, and reduce manual setup.
- tidy up scripts.

== crash scenarios ==
- SDINT switch for ia64 if possible.
- Hypervisor crash for Virtualization.
- crashes on full- and para-virt guests.

== fix bugs in existing tests ==
- printk LKDTM module can hang the second Kernel.

== kdump configurations and init script ==
- capture vmcore after init runs.
- rpm pre- and post-scripts
- kdump_pre and kdump_post directives

== increase coverages for new kexec/kdump development efforts ==
- new reserved region syntax in Kernel.

CaiQian


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
