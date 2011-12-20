Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rcx3X-0003om-8t
 for kexec@lists.infradead.org; Tue, 20 Dec 2011 10:36:24 +0000
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 20 Dec 2011 11:29:24 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBKAWBOZ2297862
 for <kexec@lists.infradead.org>; Tue, 20 Dec 2011 21:32:11 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBKAa3bC026368
 for <kexec@lists.infradead.org>; Tue, 20 Dec 2011 21:36:04 +1100
Subject: [PATCH] makedumpfile: s390x: Auto-detect the correct MAX_PHYSMEM_BITS
 used in vmcore being analyzed.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 20 Dec 2011 16:06:01 +0530
Message-ID: <20111220101459.26622.49407.stgit@mars.in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Kexec-ml <kexec@lists.infradead.org>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, Ananth Narayan <ananth@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

Hi Tachibana,

As part of the s390 patch to add support for > 4TB system memory (present in
linux-next tree), the newer s390 kernel will bump the MAX_PHYSMEM_BITS from
42 to 46. Once that patch makes into umpstream kernel, this change will need
to go into makedumpfile.  For now, I am posting this patch for a review.

Reference: http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commit;h=8980036860565a6d2a4f95bb097927e832fa3d1a

Thanks,
-Mahesh.


From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

So far s390x kernel was using 42 bits for MAX_PHYSMEM_BITS that use to
support maximum of 4TB of memory. In order to support bigger systems,
the newer s390x kernel will now use 46 bits for MAX_PHYSMEM_BITS to support
maximum of 64TB of memory.

This patch auto-detects the correct value to use for MAX_PHYSMEM_BITS by
examining the mem_section array size from the vmcore being analyzed.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/s390x.c   |   27 ++++++++++++++++++++++++++-
 makedumpfile.h |    3 ++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/s390x.c b/arch/s390x.c
index 9237eaa..c73220a 100644
--- a/arch/s390x.c
+++ b/arch/s390x.c
@@ -60,6 +60,28 @@
 #define pte_offset(x)		(pte_index(x) * sizeof(unsigned long))
 
 int
+set_s390x_max_physmem_bits(void)
+{
+	long array_len = ARRAY_LENGTH(mem_section);
+	/*
+	 * The older s390x kernels uses _MAX_PHYSMEM_BITS as 42 and the
+	 * newer kernels uses 46 bits.
+	 */
+
+	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_OLD;
+	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+		return TRUE;
+
+	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_NEW;
+	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+		return TRUE;
+
+	return FALSE;
+}
+
+int
 get_machdep_info_s390x(void)
 {
 	unsigned long vmalloc_start;
@@ -70,7 +92,10 @@ get_machdep_info_s390x(void)
 		flag_ignore_r_char = 1;
 
 	info->section_size_bits = _SECTION_SIZE_BITS;
-	info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
+	if (!set_s390x_max_physmem_bits()) {
+		ERRMSG("Can't detect max_physmem_bits.\n");
+		return FALSE;
+	}
 	info->page_offset = __PAGE_OFFSET;
 
 	if (SYMBOL(_stext) == NOT_FOUND_SYMBOL) {
diff --git a/makedumpfile.h b/makedumpfile.h
index b3de521..a95d132 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -531,7 +531,8 @@ do { \
 #define KERNELBASE		(0)
 #define KVBASE			KERNELBASE
 #define _SECTION_SIZE_BITS	(28)
-#define _MAX_PHYSMEM_BITS	(42)
+#define _MAX_PHYSMEM_BITS_OLD	(42)
+#define _MAX_PHYSMEM_BITS_NEW	(46)
 
 /* Bits in the segment/region table address-space-control-element */
 #define _ASCE_TYPE_MASK		0x0c


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
