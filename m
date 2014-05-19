Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WmEMF-0005hf-3d
 for kexec@lists.infradead.org; Mon, 19 May 2014 03:35:24 +0000
From: Liu Hua <sdu.liu@huawei.com>
Subject: [RESEND PATCH] makedumpfile: get MAX_PHYSMEM_BITS and
 SECTION_SIZE_BITS from vmcore
Date: Mon, 19 May 2014 11:27:28 +0800
Message-ID: <1400470048-61451-1-git-send-email-sdu.liu@huawei.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: wangnan0@huawei.com, liusdu@126.com, kexec@lists.infradead.org, peifeiyue@huawei.com, Liu Hua <sdu.liu@huawei.com>

Now we define MAX_PHYSMEM_BITS and SECTION_SIZE_BITS as
macros. But for ARM32 platform, different venders may
define different SECTION_SIZE_BITS. for example:

  1 arch/arm/mach-clps711x/include/mach/memory.h
    #define SECTION_SIZE_BITS 24
  2 arch/arm/mach-exynos/include/mach/memory.h
    #define SECTION_SIZE_BITS 28
  3 arch/arm/mach-sa1100/include/mach/memory.h
    #define SECTION_SIZE_BITS 27

And if Large Physical Address extension is enabled,
MAX_PHYSMEM_BITS may also be changed.

"So makedumpfile can't get an appropriate values of the two
macros since the values are variable even if the architecture
and the kernel version are fixed (at least for arm)" --
Atsushi Kumagai

This patch makes makedumpfile get these two values from
vmcore info, which makes the makedumpfile more compatible.

Signed-off-by: Liu Hua <sdu.liu@huawei.com>
---
 makedumpfile.c | 17 +++++++++++++++++
 makedumpfile.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 8dc1181..edfe30b 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2111,6 +2111,8 @@ read_vmcoreinfo(void)
 	READ_NUMBER("PG_slab", PG_slab);
 	READ_NUMBER("PG_buddy", PG_buddy);
 	READ_NUMBER("PG_hwpoison", PG_hwpoison);
+	READ_NUMBER("SECTION_SIZE_BITS", SECTION_SIZE_BITS);
+	READ_NUMBER("MAX_PHYSMEM_BITS", MAX_PHYSMEM_BITS);
 
 	READ_SRCFILE("pud_t", pud_t);
 
@@ -2996,6 +2998,18 @@ initialize_bitmap_memory(void)
 }
 
 int
+calibrate_machdep_info(void)
+{
+	if (NUMBER(MAX_PHYSMEM_BITS) > 0)
+		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
+
+	if (NUMBER(SECTION_SIZE_BITS) > 0)
+		info->section_size_bits = NUMBER(SECTION_SIZE_BITS);
+
+	return TRUE;
+}
+
+int
 initial(void)
 {
 	off_t offset;
@@ -3212,6 +3226,9 @@ out:
 	if (debug_info && !get_machdep_info())
 		return FALSE;
 
+	if (debug_info && !calibrate_machdep_info())
+		return FALSE;
+
 	if (is_xen_memory() && !get_dom0_mapnr())
 		return FALSE;
 
diff --git a/makedumpfile.h b/makedumpfile.h
index eb03688..7acb23a 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1434,6 +1434,8 @@ struct number_table {
 	long    PG_hwpoison;
 
 	long	PAGE_BUDDY_MAPCOUNT_VALUE;
+	long	SECTION_SIZE_BITS;
+	long	MAX_PHYSMEM_BITS;
 };
 
 struct srcfile_table {
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
