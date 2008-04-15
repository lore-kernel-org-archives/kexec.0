Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jlhxw-0007Hq-ME
	for kexec@lists.infradead.org; Tue, 15 Apr 2008 10:00:41 +0000
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [PATCH] ia64 kdump: Add crash_save_vmcoreinfo for INIT
Date: Tue, 15 Apr 2008 05:59:54 -0400
MIME-Version: 1.0
Message-Id: <F5C89EDF745860indou.takao@jp.fujitsu.com>
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
To: linux-ia64@vger.kernel.org, kexec@lists.infradead.org

Hi,

This patch fixes the problem that kdump by INIT does not work if we use
makedumpfile. The problem is that after INIT is issued, 2nd kernel
starts and makedumpfile fails with the following error message.

/proc/vmcore doesn't contain vmcoreinfo.
'-x' or '-i' must be specified.

makedumpfile Failed.

The cause of this problem is that kernel does not call
crash_save_vmcoreinfo. When kdump starts by panic or sysrq-trigger,
crash_save_vmcoreinfo is called by crash_kexec. But this function is not
called when kdump starts by INIT. The Attached patch fixes this.

This patch just adds crash_save_vmcoreinfo into machine_kdump_on_init so
that crash_save_vmcoreinfo can be called when kdump starts by INIT.
I tested this patch with linux-2.6.25-rc9 and I confirmed it worked.

Thanks,
Takao Indoh

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>

---
 arch/ia64/kernel/crash.c |    1 +
 1 file changed, 1 insertion(+)

diff -Nurp linux-2.6.25-rc9.org/arch/ia64/kernel/crash.c linux-2.6.25-rc9/arch/ia64/kernel/crash.c
--- linux-2.6.25-rc9.org/arch/ia64/kernel/crash.c	2008-04-14 18:23:13.000000000 -0400
+++ linux-2.6.25-rc9/arch/ia64/kernel/crash.c	2008-04-14 18:25:46.000000000 -0400
@@ -118,6 +118,7 @@ machine_crash_shutdown(struct pt_regs *p
 static void
 machine_kdump_on_init(void)
 {
+	crash_save_vmcoreinfo();
 	local_irq_disable();
 	kexec_disable_iosapic();
 	machine_kexec(ia64_kimage);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
