Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d90X1-0002u9-88
 for kexec@lists.infradead.org; Fri, 12 May 2017 02:42:18 +0000
Received: by mail-pg0-f53.google.com with SMTP id u187so23320343pgb.0
 for <kexec@lists.infradead.org>; Thu, 11 May 2017 19:41:54 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile PATCH v2 2/2] x86_64: calculate page_offset in case of
 re-filtering
Date: Fri, 12 May 2017 08:11:38 +0530
Message-Id: <320e7fd21ca3ea2f2928395d2306f556ea3f87fb.1494556339.git.panand@redhat.com>
In-Reply-To: <cover.1494556339.git.panand@redhat.com>
References: <cover.1494556339.git.panand@redhat.com>
In-Reply-To: <cover.1494556339.git.panand@redhat.com>
References: <cover.1494556339.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com, xpang@redhat.com

we do not call get_elf_info() in case of refiltering. Therefore, we will
not have any pt_load in that case, and so we get:

get_page_offset_x86_64: Can't get any pt_load to calculate page offset.

However, we will have vmcoreinfo and vmlinux information in case of
re-filtering. So, we are able to find kaslr offset and we can get
page_offset_base address. Thus we can read the page offset as well.
However, if kaslr is not enabled then use old method to find fixed page
offset.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/x86_64.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index 3116811d7563..8a50998aa470 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -75,6 +75,7 @@ get_page_offset_x86_64(void)
 	int i;
 	unsigned long long phys_start;
 	unsigned long long virt_start;
+	unsigned long page_offset_base;
 
 	for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
 		if (virt_start < __START_KERNEL_map
@@ -84,8 +85,25 @@ get_page_offset_x86_64(void)
 		}
 	}
 
-	ERRMSG("Can't get any pt_load to calculate page offset.\n");
-	return FALSE;
+	if (!info->flag_refiltering) {
+		ERRMSG("Can't get any pt_load to calculate page offset.\n");
+		return FALSE;
+	}
+	if (info->kaslr_offset) {
+		page_offset_base = get_symbol_addr("page_offset_base");
+		page_offset_base += info->kaslr_offset;
+		if (!readmem(VADDR, page_offset_base, &info->page_offset,
+					sizeof(info->page_offset))) {
+			 ERRMSG("Can't read page_offset_base.\n");
+			 return FALSE;
+		}
+	} else if (info->kernel_version < KERNEL_VERSION(2, 6, 27)) {
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
