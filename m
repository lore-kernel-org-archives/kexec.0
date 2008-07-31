Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KON08-0007Uq-HK
	for kexec@lists.infradead.org; Thu, 31 Jul 2008 01:30:45 +0000
Message-Id: <20080731012927.266000791@vergenet.net>
References: <20080731012208.115225969@vergenet.net>
Date: Thu, 31 Jul 2008 11:22:10 +1000
From: Simon Horman <horms@verge.net.au>
Subject: [patch 2/6] kdump: sh: parse elfcorehdr command line argument
Content-Disposition: inline; filename=sh-parse_elfcorehdr.patch
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Paul Mundt <lethal@linux-sh.org>, Vivek Goyal <vgoyal@redhat.com>

A quick cut and paste from other architectures to allow SH
to parse the elfcorehdr command line argument which is required
for both is_kdump_kernel() and vmcore to function.
(the former is as yet unused on SH).

Tested compilation only

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 
Andrew, Paul Mundt has aggreed to apply this patch

Index: linux-2.6/arch/sh/kernel/setup.c
===================================================================
--- linux-2.6.orig/arch/sh/kernel/setup.c	2008-07-30 09:33:45.000000000 +1000
+++ linux-2.6/arch/sh/kernel/setup.c	2008-07-30 09:37:45.000000000 +1000
@@ -25,6 +25,7 @@
 #include <linux/smp.h>
 #include <linux/err.h>
 #include <linux/debugfs.h>
+#include <linux/crash_dump.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/page.h>
@@ -286,6 +287,25 @@ static void __init setup_memory(void)
 extern void __init setup_memory(void);
 #endif
 
+/*
+ * Note: elfcorehdr_addr is not just limited to vmcore. It is also used by
+ * is_kdump_kernel() to determine if we are booting after a panic. Hence
+ * ifdef it under CONFIG_CRASH_DUMP and not CONFIG_PROC_VMCORE.
+ */
+#ifdef CONFIG_CRASH_DUMP
+/* elfcorehdr= specifies the location of elf core header
+ * stored by the crashed kernel.
+ */
+static int __init parse_elfcorehdr(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+	elfcorehdr_addr = memparse(arg, &arg);
+	return 0;
+}
+early_param("elfcorehdr", parse_elfcorehdr);
+#endif
+
 void __init setup_arch(char **cmdline_p)
 {
 	enable_mmu();

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
