Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MHBRQ-000750-I8
	for kexec@lists.infradead.org; Thu, 18 Jun 2009 06:49:51 +0000
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n5I6ngMv019265 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Thu, 18 Jun 2009 15:49:43 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id B676845DE53
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:49:42 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 89A1445DE4E
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:49:42 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 756E2E08002
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:49:42 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2DB7C1DB803C
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:49:42 +0900 (JST)
Message-ID: <4A39E383.5060100@jp.fujitsu.com>
Date: Thu, 18 Jun 2009 15:49:39 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH 4/7] ia64, kdump: Don't offline APs
References: <4A39E247.4030908@jp.fujitsu.com>
In-Reply-To: <4A39E247.4030908@jp.fujitsu.com>
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
Cc: Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

INIT on AP going to be offline have a problem.

Since psr.mc is cleared when bits in psr are set to SAL_PSR_BITS_TO_SET
in ia64_jump_to_sal(), so there is a small window that the cpu can receive
INIT even if the cpu enter there via INIT handler.  In this window we do
restore of registers for SAL, so INIT asserted here will not work properly.

It is hard to remove this window by masking INIT (i.e. setting psr.mc)
because we have to unmask it later in OS, because we have to use branch
instruction (br.ret, not rfi) to return SAL, due to OS_BOOT_RENDEZ to SAL
return convention.

I suppose this window will not be a real problem on cpu offline if we can
educate people not to push INIT button during hotplug operation.  However
only exception is a race in kdump and INIT.  Now kdump returns APs to SAL
before processing dump, but the kernel might receive INIT at that point in
time.  Such INIT might be asserted by kdump itself if an AP doesn't react
IPI soon and kdump decided to use INIT to stop the AP.

Such panic+INIT or INIT+INIT cases should be rare, but it will be happy
if we can retrieve crashdump even in such cases.  So it will be better
to stop returning APs to SAL by kdump.

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
index 48b69fd..eacedfc 100644
--- a/arch/ia64/kernel/crash.c
+++ b/arch/ia64/kernel/crash.c
@@ -142,10 +142,6 @@ kdump_cpu_freeze(struct unw_frame_info *info, void *arg)
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
