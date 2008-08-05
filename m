Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KQJ9a-0003yV-6M
	for kexec@lists.infradead.org; Tue, 05 Aug 2008 09:48:31 +0000
Date: Tue, 5 Aug 2008 19:48:27 +1000
From: Simon Horman <horms@verge.net.au>
Subject: kdump, ia64: always reserve elfcore header memory in crash kernel
Message-ID: <20080805094825.GA9712@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Vivek Goyal <vgoyal@redhat.com>

elfcore header memory needs to be reserved in a crash kernel.
This means that the relevant code should be protected
by CONFIG_CRASH_DUMP rather than CONFIG_PROC_VMCORE.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 
Andrew, this patch fixes bug in the (unlikely) case where
an ia64 crashdump kernel does not have CONFIG_PROC_FS set.
I think it is worth including in 2.6.27. But breakage cases are
likely to be minimal to non-existent, so I am comfortable
with post 2.6.27 too.

This patch should be appended to the series,
"is_kdump_kernel() cleanup and related patches".

http://lists.infradead.org/pipermail/kexec/2008-July/002270.html

Index: linux-2.6/arch/ia64/kernel/efi.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/efi.c	2008-08-05 18:31:13.000000000 +1000
+++ linux-2.6/arch/ia64/kernel/efi.c	2008-08-05 18:31:21.000000000 +1000
@@ -1334,7 +1334,7 @@ kdump_find_rsvd_region (unsigned long si
 }
 #endif
 
-#ifdef CONFIG_PROC_VMCORE
+#ifdef CONFIG_CRASH_DUMP
 /* locate the size find a the descriptor at a certain address */
 unsigned long __init
 vmcore_find_descriptor_size (unsigned long address)
Index: linux-2.6/arch/ia64/kernel/setup.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/setup.c	2008-08-05 18:31:20.000000000 +1000
+++ linux-2.6/arch/ia64/kernel/setup.c	2008-08-05 18:31:21.000000000 +1000
@@ -352,7 +352,7 @@ reserve_memory (void)
 	}
 #endif
 
-#ifdef CONFIG_PROC_VMCORE
+#ifdef CONFIG_CRASH_KERNEL
 	if (reserve_elfcorehdr(&rsvd_region[n].start,
 			       &rsvd_region[n].end) == 0)
 		n++;
@@ -496,9 +496,7 @@ static int __init parse_elfcorehdr(char 
 	return 0;
 }
 early_param("elfcorehdr", parse_elfcorehdr);
-#endif
 
-#ifdef CONFIG_PROC_VMCORE
 int __init reserve_elfcorehdr(unsigned long *start, unsigned long *end)
 {
 	unsigned long length;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
