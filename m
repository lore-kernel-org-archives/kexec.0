Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MOnq4-0006nq-GI
	for kexec@lists.infradead.org; Thu, 09 Jul 2009 07:14:47 +0000
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n697Ediu016600 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Thu, 9 Jul 2009 16:14:39 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id E95E045DE50
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2009 16:14:38 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id BE3EF45DE4F
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2009 16:14:38 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id A41D11DB803A
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2009 16:14:38 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4AB04E08001
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2009 16:14:38 +0900 (JST)
Message-ID: <4A5598D4.3060001@jp.fujitsu.com>
Date: Thu, 09 Jul 2009 16:14:28 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v2 4/7] ia64, kdump: Don't return APs to SAL from kdump
References: <4A39E247.4030908@jp.fujitsu.com> <4A5595F3.2050609@jp.fujitsu.com>
In-Reply-To: <4A5595F3.2050609@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Haren Myneni <hbabu@us.ibm.com>, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "Yu,
	Fenghua" <fenghua.yu@intel.com>

Summary:

  Asserting INIT on cpu going to be offline will result in unexpected
  behavior.  It will be a real problem in kdump cases where INIT might
  be asserted to unstable APs going to be offline by returning to SAL.

Description:

  Since psr.mc is cleared when bits in psr are set to SAL_PSR_BITS_TO_SET
  in ia64_jump_to_sal(), there is a small window (~few msecs) that the
  cpu can receive INIT even if the cpu enter there via INIT handler.
  In this window we do restore of registers for SAL, so INIT asserted
  here will not work properly.

  It is hard to remove this window by masking INIT (i.e. setting psr.mc)
  because we have to unmask it later in OS, because we have to use branch
  instruction (br.ret, not rfi) to return SAL, due to OS_BOOT_RENDEZ to
  SAL return convention.

  I suppose this window will not be a real problem on cpu offline if we
  can educate people not to push INIT button during hotplug operation.
  However, only exception is a race in kdump and INIT.  Now kdump returns
  APs to SAL before processing dump, but the kernel might receive INIT at
  that point in time.  Such INIT might be asserted by kdump itself if an
  AP doesn't react IPI soon and kdump decided to use INIT to stop the AP.
  Or it might be asserted by operator or an external agent to start dump
  on the unstable system.

  Such panic+INIT or INIT+INIT cases should be rare, but it will be happy
  if we can retrieve crashdump even in such cases.

How to reproduce:

  panic+INIT or INIT+INIT, with kdump configured

Expected results:

  crashdump is retrieved anyway

Actual results:

  panic, hang etc. (unexpected)

Proposed fix

  To avoid the window on the way to SAL, this patch stops returning APs
  to SAL in case of kdump.  In other words, this patch makes APs spin
  in OS instead of spinning in SAL.

  (* Note: What impact would be there?  If a cpu is spinning in SAL,
   the cpu is in BOOT_RENDEZ loop, as same as offlined cpu.
   In theory if an INIT is asserted there, cpus in the BOOT_RENDEZ loop
   should not invoke OS_INIT on it.  So in either way, no matter where
   the cpu is spinning actually in, once cpu starts spin and act as
   "frozen," INIT on the cpu have no effects.
   From another point of view, all debug information on the cpu should
   have stored to memory before the cpu start to be frozen.  So no more
   action on the cpu is required.)

  I confirmed that the kdump sometime hangs by concurrent INITs (another
  INIT after an INIT), and it doesn't hang after applying this patch.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Haren Myneni <hbabu@us.ibm.com>
Cc: kexec@lists.infradead.org
---
 arch/ia64/kernel/crash.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
index 3f3a579..b2a8b3d 100644
--- a/arch/ia64/kernel/crash.c
+++ b/arch/ia64/kernel/crash.c
@@ -140,10 +140,6 @@ kdump_cpu_freeze(struct unw_frame_info *info, void *arg)
 	atomic_inc(&kdump_cpu_frozen);
 	kdump_status[cpuid] = 1;
 	mb();
-#ifdef CONFIG_HOTPLUG_CPU
-	if (cpuid != 0)
-		ia64_jump_to_sal(&sal_boot_rendez_state[cpuid]);
-#endif
 	for (;;)
 		cpu_relax();
 }
-- 
1.6.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
