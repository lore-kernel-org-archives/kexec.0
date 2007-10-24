Return-path: <kexec-bounces@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IkjFb-0000S3-Cm
	for kexec@lists.infradead.org; Wed, 24 Oct 2007 17:38:38 +0100
Message-Id: <20071024163734.204144819@strauss.suse.de>
Date: Wed, 24 Oct 2007 18:37:35 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [patch 2/2] Use BOOTMEM_EXCLUSIVE for kdump
References: <20071024163733.366829630@strauss.suse.de>
Content-Disposition: inline; filename=bootmem-alloc-use-crashkernel
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net

This patch uses the BOOTMEM_EXCLUSIVE, introduced in the previous patch,
to avoid conflicts while reserving the memory for the kdump carpture kernel
(crashkernel=).


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 arch/sh/kernel/setup.c     |   29 ++++++++++++++++++-----------
 arch/x86/kernel/setup_32.c |   28 ++++++++++++++++++----------
 arch/x86/kernel/setup_64.c |   35 +++++++++++++++++++++--------------
 3 files changed, 57 insertions(+), 35 deletions(-)

--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -140,19 +140,26 @@ static void __init reserve_crashkernel(v
 	ret = parse_crashkernel(boot_command_line, free_mem,
 			&crash_size, &crash_base);
 	if (ret == 0 && crash_size) {
-		if (crash_base > 0) {
-			printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
-					"for crashkernel (System RAM: %ldMB)\n",
-					(unsigned long)(crash_size >> 20),
-					(unsigned long)(crash_base >> 20),
-					(unsigned long)(free_mem >> 20));
-			crashk_res.start = crash_base;
-			crashk_res.end   = crash_base + crash_size - 1;
-			reserve_bootmem(crash_base, crash_size,
-					BOOTMEM_DEFAULT);
-		} else
+		if (crash_base <= 0) {
 			printk(KERN_INFO "crashkernel reservation failed - "
 					"you have to specify a base address\n");
+			return;
+		}
+
+		if (reserve_bootmem(crash_base, crash_size,
+					BOOTMEM_EXCLUSIVE) < 0) {
+			printk(KERN_INFO "crashkernel reservation failed - "
+					"memory is in use\n");
+			return;
+		}
+
+		printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
+				"for crashkernel (System RAM: %ldMB)\n",
+				(unsigned long)(crash_size >> 20),
+				(unsigned long)(crash_base >> 20),
+				(unsigned long)(free_mem >> 20));
+		crashk_res.start = crash_base;
+		crashk_res.end   = crash_base + crash_size - 1;
 	}
 }
 #else
--- a/arch/x86/kernel/setup_32.c
+++ b/arch/x86/kernel/setup_32.c
@@ -404,18 +404,26 @@ static void __init reserve_crashkernel(v
 	ret = parse_crashkernel(boot_command_line, total_mem,
 			&crash_size, &crash_base);
 	if (ret == 0 && crash_size > 0) {
-		if (crash_base > 0) {
-			printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
-					"for crashkernel (System RAM: %ldMB)\n",
-					(unsigned long)(crash_size >> 20),
-					(unsigned long)(crash_base >> 20),
-					(unsigned long)(total_mem >> 20));
-			crashk_res.start = crash_base;
-			crashk_res.end   = crash_base + crash_size - 1;
-			reserve_bootmem(crash_base, crash_size, BOOTMEM_DEFAULT);
-		} else
+		if (crash_base <= 0) {
 			printk(KERN_INFO "crashkernel reservation failed - "
 					"you have to specify a base address\n");
+			return;
+		}
+
+		if (reserve_bootmem(crash_base, crash_size,
+					BOOTMEM_EXCLUSIVE) < 0) {
+			printk(KERN_INFO "crashkernel reservation failed - "
+					"memory is in use\n");
+			return;
+		}
+
+		printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
+				"for crashkernel (System RAM: %ldMB)\n",
+				(unsigned long)(crash_size >> 20),
+				(unsigned long)(crash_base >> 20),
+				(unsigned long)(total_mem >> 20));
+		crashk_res.start = crash_base;
+		crashk_res.end   = crash_base + crash_size - 1;
 	}
 }
 #else
--- a/arch/x86/kernel/setup_64.c
+++ b/arch/x86/kernel/setup_64.c
@@ -201,28 +201,35 @@ static inline void copy_edd(void)
 #ifdef CONFIG_KEXEC
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long free_mem;
+	unsigned long long total_mem;
 	unsigned long long crash_size, crash_base;
 	int ret;
 
-	free_mem = ((unsigned long long)max_low_pfn - min_low_pfn) << PAGE_SHIFT;
+	total_mem = ((unsigned long long)max_low_pfn - min_low_pfn) << PAGE_SHIFT;
 
-	ret = parse_crashkernel(boot_command_line, free_mem,
+	ret = parse_crashkernel(boot_command_line, total_mem,
 			&crash_size, &crash_base);
 	if (ret == 0 && crash_size) {
-		if (crash_base > 0) {
-			printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
-					"for crashkernel (System RAM: %ldMB)\n",
-					(unsigned long)(crash_size >> 20),
-					(unsigned long)(crash_base >> 20),
-					(unsigned long)(free_mem >> 20));
-			crashk_res.start = crash_base;
-			crashk_res.end   = crash_base + crash_size - 1;
-			reserve_bootmem(crash_base, crash_size,
-					BOOTMEM_DEFAULT);
-		} else
+		if (crash_base <= 0) {
 			printk(KERN_INFO "crashkernel reservation failed - "
 					"you have to specify a base address\n");
+			return;
+		}
+
+		if (reserve_bootmem(crash_base, crash_size,
+					BOOTMEM_EXCLUSIVE) < 0) {
+			printk(KERN_INFO "crashkernel reservation failed - "
+					"memory is in use\n");
+			return;
+		}
+
+		printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
+				"for crashkernel (System RAM: %ldMB)\n",
+				(unsigned long)(crash_size >> 20),
+				(unsigned long)(crash_base >> 20),
+				(unsigned long)(total_mem >> 20));
+		crashk_res.start = crash_base;
+		crashk_res.end   = crash_base + crash_size - 1;
 	}
 }
 #else


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
