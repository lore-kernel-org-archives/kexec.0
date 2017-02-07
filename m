Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cb0ps-0004bU-9f
 for kexec@lists.infradead.org; Tue, 07 Feb 2017 08:09:20 +0000
Received: by mail-pg0-f52.google.com with SMTP id 194so36723616pgd.2
 for <kexec@lists.infradead.org>; Tue, 07 Feb 2017 00:08:51 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v32 07/13] arm64: hibernate: preserve kdump image around
 hibernation
Date: Tue,  7 Feb 2017 17:08:59 +0900
Message-Id: <20170207080904.5974-5-takahiro.akashi@linaro.org>
In-Reply-To: <20170207080601.5816-1-takahiro.akashi@linaro.org>
References: <20170207080601.5816-1-takahiro.akashi@linaro.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: catalin.marinas@arm.com, will.deacon@arm.com
Cc: mark.rutland@arm.com, geoff@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

Since arch_kexec_protect_crashkres() removes a mapping for crash dump
kernel memory, the loaded contents won't be preserved around hibernation.

In this patch, arch_kexec_(un)protect_crashkres() are additionally called
before/after hibernation so that the relevant region will be mapped again
and restored just as the other memory regions are.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/hibernate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index fe301cbcb442..111a849333ee 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -16,6 +16,7 @@
  */
 #define pr_fmt(x) "hibernate: " x
 #include <linux/cpu.h>
+#include <linux/kexec.h>
 #include <linux/kvm_host.h>
 #include <linux/mm.h>
 #include <linux/pm.h>
@@ -289,6 +290,12 @@ int swsusp_arch_suspend(void)
 	local_dbg_save(flags);
 
 	if (__cpu_suspend_enter(&state)) {
+#ifdef CONFIG_KEXEC_CORE
+		/* make the crash dump kernel region mapped */
+		if (kexec_crash_image)
+			arch_kexec_unprotect_crashkres();
+#endif
+
 		sleep_cpu = smp_processor_id();
 		ret = swsusp_save();
 	} else {
@@ -300,6 +307,12 @@ int swsusp_arch_suspend(void)
 		if (el2_reset_needed())
 			dcache_clean_range(__hyp_idmap_text_start, __hyp_idmap_text_end);
 
+#ifdef CONFIG_KEXEC_CORE
+		/* make the crash dump kernel region unmapped */
+		if (kexec_crash_image)
+			arch_kexec_protect_crashkres();
+#endif
+
 		/*
 		 * Tell the hibernation core that we've just restored
 		 * the memory
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
