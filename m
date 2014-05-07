Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wi20A-0005tk-Fh
 for kexec@lists.infradead.org; Wed, 07 May 2014 13:35:15 +0000
From: Liu Hua <sdu.liu@huawei.com>
Subject: [RFC PATCH 2/2] makedumpfile: get additional information from vmcore
Date: Wed, 7 May 2014 21:27:14 +0800
Message-ID: <1399469234-54925-3-git-send-email-sdu.liu@huawei.com>
In-Reply-To: <1399469234-54925-1-git-send-email-sdu.liu@huawei.com>
References: <1399469234-54925-1-git-send-email-sdu.liu@huawei.com>
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
To: linux@arm.linux.org.uk, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: wangnan0@huawei.com, peifeiyue@huawei.com, sdu.liu@huawei.com, will.deacon@arm.com, liusdu@126.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Now we define MAX_PHYSMEM_BITS and SECTION_SIZE_BITS as
macros. So if we deal with vmcores with different values
of these two macros. We have to recompile makedumpfile.

This patch makes makedumpfile get these two values from
vmcore info, if existing. It makes the makedumpfile more
compatible to vmcores with different section size.

Signed-off-by: Liu Hua <sdu.liu@huawei.com>
---
 makedumpfile.c | 17 +++++++++++++++++
 makedumpfile.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 6cf6e24..3cdf323 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2111,6 +2111,8 @@ read_vmcoreinfo(void)
 	READ_NUMBER("PG_slab", PG_slab);
 	READ_NUMBER("PG_buddy", PG_buddy);
 	READ_NUMBER("PG_hwpoison", PG_hwpoison);
+	READ_NUMBER("SECTION_SIZE_BITS", SECTION_SIZE_BITS);
+	READ_NUMBER("MAX_PHYSMEM_BITS", MAX_PHYSMEM_BITS);
 
 	READ_SRCFILE("pud_t", pud_t);
 
@@ -2998,6 +3000,18 @@ initialize_bitmap_memory(void)
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
@@ -3214,6 +3228,9 @@ out:
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
