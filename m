Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fBzOU-0007rn-CR
 for kexec@lists.infradead.org; Fri, 27 Apr 2018 09:10:20 +0000
Message-Id: <20180427090045.532014306@redhat.com>
Date: Fri, 27 Apr 2018 17:00:37 +0800
From: dyoung@redhat.com
Subject: [PATCH 1/2] kdump/x86: crashkernel=X try to reserve below 896M first
 then below 4G and MAXMEM
MIME-Version: 1.0
Content-Disposition: inline;
 filename=x86-kdump-crashkernel-X-try-to-reserve-below-896M-fi.patch
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: dyoung@redhat.com, akpm@linux-foundation.org, yinghai@kernel.org, vgoyal@redhat.com, bhe@redhat.com

Now crashkernel=X will fail if there's not enough memory at low region
(below 896M) when trying to reserve large memory size.  One can use
crashkernel=xM,high to reserve it at high region (>4G) but it is more
convinient to improve crashkernel=X to:

 - First try to reserve X below 896M (for being compatible with old
   kexec-tools).
 - If fails, try to reserve X below 4G (swiotlb need to stay below 4G).
 - If fails, try to reserve X from MAXMEM top down.

It's more transparent and user-friendly.

If crashkernel is large and the reserved is beyond 896M, old kexec-tools
is not compatible with new kernel because old kexec-tools can not load
kernel at high memory region, there was an old discussion below:
https://lkml.org/lkml/2013/10/15/601

But actually the behavior is consistent during my test. Suppose
old kernel fail to reserve memory at low areas, kdump does not
work because no meory reserved. With this patch, suppose new kernel
successfully reserved memory at high areas, old kexec-tools still fail
to load kdump kernel (tested 2.0.2), so it is acceptable, no need to
worry about the compatibility.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/setup.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- linux-x86.orig/arch/x86/kernel/setup.c
+++ linux-x86/arch/x86/kernel/setup.c
@@ -545,6 +545,22 @@ static void __init reserve_crashkernel(v
 						    high ? CRASH_ADDR_HIGH_MAX
 							 : CRASH_ADDR_LOW_MAX,
 						    crash_size, CRASH_ALIGN);
+#ifdef CONFIG_X86_64
+		/*
+		 * crashkernel=X reserve below 896M fails? Try below 4G
+		 */
+		if (!high && !crash_base)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						(1ULL << 32),
+						crash_size, CRASH_ALIGN);
+		/*
+		 * crashkernel=X reserve below 4G fails? Try MAXMEM
+		 */
+		if (!high && !crash_base)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						CRASH_ADDR_HIGH_MAX,
+						crash_size, CRASH_ALIGN);
+#endif
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
