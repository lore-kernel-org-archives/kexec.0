Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vw0-f49.google.com ([209.85.212.49])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O4zBx-00081t-L1
	for kexec@lists.infradead.org; Thu, 22 Apr 2010 16:23:54 +0000
Received: by mail-vw0-f49.google.com with SMTP id 3so1969792vws.36
	for <kexec@lists.infradead.org>; Thu, 22 Apr 2010 09:23:53 -0700 (PDT)
From: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Subject: [PATCH 4/5] x86: use second memory region for dump-capture kernel
Date: Thu, 22 Apr 2010 18:23:11 +0200
Message-Id: <1271953392-6324-5-git-send-email-v.mayatskih@gmail.com>
In-Reply-To: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
References: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <amwang@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

This patch adds second memory region support for kexec on x86
platform.

Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
---
 arch/x86/kernel/setup.c |   56 +++++++++++++++++++++++++++++-----------------
 1 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c4851ef..9b395bb 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -501,19 +501,11 @@ static inline unsigned long long get_total_mem(void)
 	return total << PAGE_SHIFT;
 }
 
-static void __init reserve_crashkernel(void)
+static int __init reserve_crashkernel_region(char *region_name,
+					     struct resource *crashk,
+					     unsigned long long crash_size,
+					     unsigned long long crash_base)
 {
-	unsigned long long total_mem;
-	unsigned long long crash_size, crash_base;
-	int ret;
-
-	total_mem = get_total_mem();
-
-	ret = parse_crashkernel(boot_command_line, total_mem,
-			&crash_size, &crash_base);
-	if (ret != 0 || crash_size <= 0)
-		return;
-
 	/* 0 means: find the address automatically */
 	if (crash_base <= 0) {
 		const unsigned long long alignment = 16<<20;	/* 16M */
@@ -522,7 +514,7 @@ static void __init reserve_crashkernel(void)
 				 alignment);
 		if (crash_base == -1ULL) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
-			return;
+			return -EINVAL;
 		}
 	} else {
 		unsigned long long start;
@@ -531,20 +523,42 @@ static void __init reserve_crashkernel(void)
 				 1<<20);
 		if (start != crash_base) {
 			pr_info("crashkernel reservation failed - memory is in use.\n");
-			return;
+			return -EINVAL;
 		}
 	}
-	reserve_early(crash_base, crash_base + crash_size, "CRASH KERNEL");
+	reserve_early(crash_base, crash_base + crash_size, region_name);
 
 	printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
-			"for crashkernel (System RAM: %ldMB)\n",
+			"for crashkernel\n",
 			(unsigned long)(crash_size >> 20),
-			(unsigned long)(crash_base >> 20),
-			(unsigned long)(total_mem >> 20));
+			(unsigned long)(crash_base >> 20));
+
+	crashk->start = crash_base;
+	crashk->end   = crash_base + crash_size - 1;
+	insert_resource(&iomem_resource, crashk);
+	return 0;
+}
+
+static void __init reserve_crashkernel(void)
+{
+	unsigned long long total_mem;
+	unsigned long long crash_size, crash_base;
+	unsigned long long crash_size_hi, crash_base_hi;
+	int ret;
+
+	total_mem = get_total_mem();
+
+	ret = parse_crashkernel_ext(boot_command_line, total_mem,
+				    &crash_size, &crash_base,
+				    &crash_size_hi, &crash_base_hi);
+	if (ret != 0 || crash_size <= 0)
+		return;
 
-	crashk_res.start = crash_base;
-	crashk_res.end   = crash_base + crash_size - 1;
-	insert_resource(&iomem_resource, &crashk_res);
+	ret = reserve_crashkernel_region("CRASH KERNEL", &crashk_res,
+					 crash_size, crash_base);
+	if (ret == 0 && crash_size_hi > 0)
+		reserve_crashkernel_region("CRASH HIMEM", &crashk_res_hi,
+					   crash_size_hi, crash_base_hi);
 }
 #else
 static void __init reserve_crashkernel(void)
-- 
1.7.0.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
