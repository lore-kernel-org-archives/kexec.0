Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1frq7k-0002VI-II
 for kexec@lists.infradead.org; Mon, 20 Aug 2018 19:46:02 +0000
Received: by mail-pg1-f196.google.com with SMTP id h8-v6so832196pgs.4
 for <kexec@lists.infradead.org>; Mon, 20 Aug 2018 12:45:49 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH] arm64: Add a generic method of determining invalid phy-addr
 for calculating 'info->page_offset'
Date: Tue, 21 Aug 2018 01:15:40 +0530
Message-Id: <1534794340-1244-1-git-send-email-bhsharma@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com, k-hagio@ab.jp.nec.com

Commit 94c97db3fe859ca14d7b38b0ae9ee0ffb83689d2 (arm64: Get
'info->page_offset' from PT_LOAD segments to support KASLR boot cases)
added a method to determine 'info->page_offset' from PT_LOAD segments
for arm64 platforms.

In this commit we hardcoded the NOT_PADDR_ARM64 macro as
0x0000000010a80000UL which was a valid value on
qualcomm-amberwing boards.

However, I was testing this change on several other arm64 boards
like apm-mustang, huawei-taishan and hp-moonshot and saw that
this value can vary on the basic of the "Kernel code" memory range
placement.

This patch determines the "Kernel code" memory range from
'/proc/iomem' listing and uses the same to determine the
NOT_PADDR_ARM64 value, which makes this calculation platform
independent and this works well on apm-mustang, huawei-taishan,
qualcomm-amberwing and hp-moonshot platforms.

Here are some logs on my huawei-taishan board with kernel version
4.18.0-rc8:

The kernel version is not supported.
The makedumpfile operation may be incomplete.

TYPE		PAGES			EXCLUDABLE	DESCRIPTION
----------------------------------------------------------------------
ZERO		83081           	yes		Pages filled with zero
NON_PRI_CACHE	6330            	yes		Cache pages without private flag
PRI_CACHE	927             	yes		Cache pages with private flag
USER		2659            	yes		User process pages
FREE		4053998         	yes		Free pages
KERN_DATA	35331           	no		Dumpable kernel data

page size:		65536
Total pages on system:	4182326
Total size on system:	274092916736     Byte

Fixes: 94c97db3fe859ca14d7b38b0ae9ee0ffb83689d2 (arm64: Get
	'info->page_offset' from PT_LOAD segments to support KASLR boot
	cases)

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64.c   | 26 ++++++++++++++++++++++++--
 makedumpfile.h |  1 -
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 362609668ea2..e0b30c812124 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -303,10 +303,25 @@ get_xen_info_arm64(void)
 	return ERROR;
 }
 
+/* We want to exclude the kernel code mem region while calculating the
+ * info->page_offset for arm64 arch
+ */
+static struct memory_range kernel_code_mem_range;
+
+static int kernel_code_resource_callback(void *data, int nr,
+					  char *str,
+					  unsigned long base,
+					  unsigned long length)
+{
+	kernel_code_mem_range.start = base;
+	kernel_code_mem_range.end   = base + length - 1;
+	return 0;
+}
+
 int
 get_versiondep_info_arm64(void)
 {
-	int i;
+	int i, ret;
 	unsigned long long phys_start;
 	unsigned long long virt_start;
 	ulong _stext;
@@ -333,6 +348,13 @@ get_versiondep_info_arm64(void)
 		return FALSE;
 	}
 
+	ret = iomem_for_each_line("Kernel code\n",
+					kernel_code_resource_callback, NULL);
+	if (ret != 1) {
+		ERRMSG("Cannot find a proper Kernel code memory range in /proc/iomem\n");
+		return FALSE;
+	}
+
 	if (get_num_pt_loads()) {
 		for (i = 0;
 		    get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
@@ -340,7 +362,7 @@ get_versiondep_info_arm64(void)
 			if (virt_start != NOT_KV_ADDR
 			    && virt_start < __START_KERNEL_map
 			    && phys_start != NOT_PADDR
-			    && phys_start != NOT_PADDR_ARM64) {
+			    && phys_start != kernel_code_mem_range.start) {
 				info->page_offset = virt_start - phys_start;
 				DEBUG_MSG("info->page_offset: %lx, VA_BITS: %d\n",
 						info->page_offset, va_bits);
diff --git a/makedumpfile.h b/makedumpfile.h
index 3244d31ae43a..9fefe150829f 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -544,7 +544,6 @@ unsigned long get_kvbase_arm64(void);
 #define KVBASE			get_kvbase_arm64()
 
 #define __START_KERNEL_map	(0xffffffff80000000UL)
-#define NOT_PADDR_ARM64		(0x0000000010a80000UL)
 
 #endif /* aarch64 */
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
