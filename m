Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat.scz.novell.com ([213.151.88.252] helo=nathan.suse.cz)
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1StHdZ-0003Z6-Tz
 for kexec@lists.infradead.org; Mon, 23 Jul 2012 12:21:23 +0000
Message-Id: <20120723113255.018179022@suse.cz>
Date: Mon, 23 Jul 2012 13:32:49 +0200
From: ptesarik@suse.cz
Subject: [PATCH 5/8] Add infrastructure for Xen PGC_xxx macros
References: <20120723113244.751777873@suse.cz>
Content-Disposition: inline; filename=makedumpfile-xen4-PGC_flags.patch
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
To: kexec@lists.infradead.org
Cc: Petr Tesarik <ptesarik@suse.cz>

The highest bits of the _count field in struct page_info contain some
page specific flags. However, since they are allocated from top to bottom,
we need some infrastructure to get their values right on all platforms,
namely a macro that defines the size of a "long" value.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 makedumpfile.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -78,6 +78,12 @@ int get_mem_type(void);
 #define LSEEKED_PDATA	(3)
 
 /*
+ * Xen page flags
+ */
+#define PG_shift(idx)	(BITS_PER_LONG - (idx))
+#define PG_mask(x, idx)	(x ## UL << PG_shift(idx))
+
+/*
  * Memory flags
  */
 #define MEMORY_PAGETABLE_4L	(1 << 0)
@@ -426,6 +432,8 @@ do { \
 #define VMEMMAP_END		(info->vmemmap_end)
 
 #ifdef __arm__
+#define BITS_PER_LONG		32
+
 #define KVBASE_MASK		(0xffff)
 #define KVBASE			(SYMBOL(_stext) & ~KVBASE_MASK)
 #define _SECTION_SIZE_BITS	(28)
@@ -443,6 +451,8 @@ do { \
 #endif /* arm */
 
 #ifdef __x86__
+#define BITS_PER_LONG		32
+
 #define __PAGE_OFFSET		(0xc0000000)
 #define __VMALLOC_RESERVE       (128 << 20)
 #define MAXMEM                  (-PAGE_OFFSET-__VMALLOC_RESERVE)
@@ -474,6 +484,8 @@ do { \
 #endif /* x86 */
 
 #ifdef __x86_64__
+#define BITS_PER_LONG		64
+
 #define __PAGE_OFFSET_ORIG	(0xffff810000000000) /* 2.6.26, or former */
 #define __PAGE_OFFSET_2_6_27	(0xffff880000000000) /* 2.6.27, or later  */
 
@@ -523,6 +535,8 @@ do { \
 #endif /* x86_64 */
 
 #ifdef __powerpc64__
+#define BITS_PER_LONG		64
+
 #define __PAGE_OFFSET		(0xc000000000000000)
 #define KERNELBASE		PAGE_OFFSET
 #define VMALLOCBASE     	(0xD000000000000000)
@@ -532,6 +546,7 @@ do { \
 #endif
 
 #ifdef __powerpc32__
+#define BITS_PER_LONG		32
 
 #define __PAGE_OFFSET		(0xc0000000)
 #define KERNELBASE		PAGE_OFFSET
@@ -543,6 +558,8 @@ do { \
 #endif
 
 #ifdef __s390x__
+#define BITS_PER_LONG		64
+
 #define __PAGE_OFFSET		(info->page_size - 1)
 #define KERNELBASE		(0)
 #define KVBASE			KERNELBASE
@@ -583,6 +600,8 @@ do { \
 #endif /* __s390x__ */
 
 #ifdef __ia64__ /* ia64 */
+#define BITS_PER_LONG		64
+
 #define REGION_SHIFT		(61)
 
 #define KERNEL_CACHED_REGION	(7)



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
