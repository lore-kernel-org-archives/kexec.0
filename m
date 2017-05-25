Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dDhvW-0005bQ-3I
 for kexec@lists.infradead.org; Thu, 25 May 2017 01:51:00 +0000
Received: by mail-pf0-f179.google.com with SMTP id n23so152031545pfb.2
 for <kexec@lists.infradead.org>; Wed, 24 May 2017 18:50:40 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile PATCH v3 2/2] x86_64: calculate page_offset in case of
 re-filtering/sadump/virsh dump
Date: Thu, 25 May 2017 07:20:29 +0530
Message-Id: <e13807fc6391bf71e7822d39cdb084d3bf481818.1495619809.git.panand@redhat.com>
In-Reply-To: <cover.1495619809.git.panand@redhat.com>
References: <cover.1495619809.git.panand@redhat.com>
In-Reply-To: <cover.1495619809.git.panand@redhat.com>
References: <cover.1495619809.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, bhe@redhat.com, kexec@lists.infradead.org, xlpang@redhat.com, d.hatayama@jp.fujitsu.com, dyoung@redhat.com

we do not call get_elf_info() in case of refiltering and sadump.
Therefore, we will not have any pt_load in that case, and so we get:

get_page_offset_x86_64: Can't get any pt_load to calculate page offset.

However, we will have vmcoreinfo and vmlinux information in case of
re-filtering. So, we are able to find kaslr offset and we can get
page_offset_base address. Thus we can read the page offset as well.

If kaslr is not enabled and also we do not have valid PT_LOAD to
calculate page offset  then use old method to find fixed page
offset.

In case of virsh dump virtual addresses in PT_LOAD are 0. Ignore such
addresses for the page_offset calculation.

Suggested-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/x86_64.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index fd2e8ac154d6..18384a8dd684 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -75,17 +75,39 @@ get_page_offset_x86_64(void)
 	int i;
 	unsigned long long phys_start;
 	unsigned long long virt_start;
+	unsigned long page_offset_base;
+
+	if (info->kaslr_offset) {
+		page_offset_base = get_symbol_addr("page_offset_base");
+		page_offset_base += info->kaslr_offset;
+		if (!readmem(VADDR, page_offset_base, &info->page_offset,
+					sizeof(info->page_offset))) {
+			 ERRMSG("Can't read page_offset_base.\n");
+			 return FALSE;
+		}
+		return TRUE;
+	}
 
-	for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
-		if (virt_start < __START_KERNEL_map
-				&& phys_start != NOT_PADDR) {
-			info->page_offset = virt_start - phys_start;
-			return TRUE;
+	if (get_num_pt_loads()) {
+		for (i = 0;
+			get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
+			i++) {
+			if (virt_start != NOT_KV_ADDR
+					&& virt_start < __START_KERNEL_map
+					&& phys_start != NOT_PADDR) {
+				info->page_offset = virt_start - phys_start;
+				return TRUE;
+			}
 		}
 	}
 
-	ERRMSG("Can't get any pt_load to calculate page offset.\n");
-	return FALSE;
+	if (info->kernel_version < KERNEL_VERSION(2, 6, 27)) {
+		info->page_offset = __PAGE_OFFSET_ORIG;
+	} else {
+		info->page_offset = __PAGE_OFFSET_2_6_27;
+	}
+
+	return TRUE;
 }
 
 int
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
