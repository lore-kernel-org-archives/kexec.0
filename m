Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137])
	by canuck.infradead.org with smtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PFNJo-0002I5-5O
	for kexec@lists.infradead.org; Mon, 08 Nov 2010 08:43:13 +0000
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.80.115])
	by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id 583FB145
	for <kexec@lists.infradead.org>; Mon,  8 Nov 2010 08:42:51 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
	by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id ABE36257
	for <kexec@lists.infradead.org>; Mon,  8 Nov 2010 08:42:50 +0000 (GMT)
Received: from exdcvycastm003.EQ1STM.local (alteon-source-exch [10.230.100.61])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "exdcvycastm003", Issuer "exdcvycastm003" (not verified))
	by relay2.stm.gmessaging.net (Postfix) with ESMTPS id 1F8A1A8096
	for <kexec@lists.infradead.org>; Mon,  8 Nov 2010 09:42:47 +0100 (CET)
From: Per Fransson <per.xx.fransson@stericsson.com>
Subject: [RFC 0/2] Selective MMU identity mapping for kexec
Date: Mon, 8 Nov 2010 09:42:35 +0100
Message-ID: <1289205757-14620-1-git-send-email-per.xx.fransson@stericsson.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Per Fransson <per.xx.fransson@stericsson.com>

Hi,

I would appreciate your input on some kexec related changes.

When restarting using the kernel kexec functionality the MMU needs to be turned off.
Any code which does this needs to use identity mapped addresses to get
reliable results. In the ARM kexec case this identity mapping is done:

- using the page table of the current task

- for all addresses normally used by user space, i.e. 0x00000000-PAGE_OFFSET

If kexec is used at a kernel crash to collect a core dump this means that we lose important information.

This is what these patches do:

* Actually turn off the MMU, which has been omitted by mistake, see this post:

    http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/019631.html

* Set up a more selective identity mapping

* Restore the old mapping once the MMU is off


The patch was generated from a linux-next 20101028 with these additional related patches which are in the pipeline:

http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=commit;h=ae360a78f41164e7f9c4cf846696b5b6d8dae5c8
http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=commit;h=2fd8658931193599c867fd6974fa184ec34af16c
http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=commit;h=ae6948048c417d429b8a0f85fad13e483f7cc1a3


Regards,
Per


Per Fransson (2):
  Turn off MMU in cpu_v7_reset
  Selective MMU identity mapping for kexec

 arch/arm/kernel/machine_kexec.c   |   27 +++++++++++++++++++++-
 arch/arm/kernel/relocate_kernel.S |   23 +++++++++++++++++++
 arch/arm/mm/mmu.c                 |   44 +++++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-v7.S             |    4 +++
 4 files changed, 97 insertions(+), 1 deletions(-)

-- 
1.7.2.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
