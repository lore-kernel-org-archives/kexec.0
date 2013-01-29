Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U044L-0005TJ-CB
 for kexec@lists.infradead.org; Tue, 29 Jan 2013 05:49:18 +0000
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 29 Jan 2013 15:42:34 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 38CA63578023
 for <kexec@lists.infradead.org>; Tue, 29 Jan 2013 16:49:06 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0T5n4EY59310316
 for <kexec@lists.infradead.org>; Tue, 29 Jan 2013 16:49:05 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0T5n4dw015909
 for <kexec@lists.infradead.org>; Tue, 29 Jan 2013 16:49:05 +1100
Subject: [PATCH] makedumpfile: ppc64: Auto-detect the correct MAX_PHYSMEM_BITS
 used in vmcore being analyzed.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 29 Jan 2013 11:19:01 +0530
Message-ID: <20130129054831.11980.72845.stgit@mars.in.ibm.com>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Kexec-ml <kexec@lists.infradead.org>
Cc: Dave Young <dyoung@redhat.com>, Dave Anderson <anderson@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Ananth Narayan <ananth@in.ibm.com>, CAI Qian <caiqian@redhat.com>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The latest upstream kernel commit 048ee0993ec8360abb0b51bdf8f8721e9ed62ec4 adds
64TB support to ppc64 kernel and bumps the MAX_PHYSMEM_BITS from 44 to 46. This
change causes sparsemem extreme check to fail in makedumpfile.

This patch auto-detects the correct value to use for MAX_PHYSMEM_BITS by
examining the mem_section array size from the vmcore being analyzed.

This patch has been tested on upstream kernel 3.8.0-rc4 and older kernel
2.6.32.

Reported-by: Dave Anderson <anderson@redhat.com>
Reported-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/ppc64.c   |   27 ++++++++++++++++++++++++++-
 makedumpfile.h |    3 ++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 1cb69e1..afbaf55 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -25,12 +25,37 @@
 #include "../makedumpfile.h"
 
 int
+set_ppc64_max_physmem_bits(void)
+{
+	long array_len = ARRAY_LENGTH(mem_section);
+	/*
+	 * The older ppc64 kernels uses _MAX_PHYSMEM_BITS as 42 and the
+	 * newer kernels 3.7 onwards uses 46 bits.
+	 */
+
+	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG ;
+	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+		return TRUE;
+
+	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_3_7;
+	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
+		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
+		return TRUE;
+
+	return FALSE;
+}
+
+int
 get_machdep_info_ppc64(void)
 {
 	unsigned long vmlist, vmalloc_start;
 
 	info->section_size_bits = _SECTION_SIZE_BITS;
-	info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
+	if (!set_ppc64_max_physmem_bits()) {
+		ERRMSG("Can't detect max_physmem_bits.\n");
+		return FALSE;
+	}
 	info->page_offset = __PAGE_OFFSET;
 
 	if (SYMBOL(_stext) == NOT_FOUND_SYMBOL) {
diff --git a/makedumpfile.h b/makedumpfile.h
index d2bdc0c..d758a3c 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -566,7 +566,8 @@ do { \
 #define VMALLOCBASE     	(0xD000000000000000)
 #define KVBASE			(SYMBOL(_stext))
 #define _SECTION_SIZE_BITS	(24)
-#define _MAX_PHYSMEM_BITS	(44)
+#define _MAX_PHYSMEM_BITS_ORIG  (44)
+#define _MAX_PHYSMEM_BITS_3_7   (46)
 #endif
 
 #ifdef __powerpc32__


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
