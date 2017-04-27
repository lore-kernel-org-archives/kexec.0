Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3ciz-0000Md-UU
 for kexec@lists.infradead.org; Thu, 27 Apr 2017 06:16:23 +0000
Received: by mail-pf0-f178.google.com with SMTP id v14so16583578pfd.2
 for <kexec@lists.infradead.org>; Wed, 26 Apr 2017 23:16:01 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile PATCH 2/2] x86_64: calculate page_offset in case of
 re-filtering
Date: Thu, 27 Apr 2017 11:45:16 +0530
Message-Id: <12425d1df3a66581d968084bdf231ab1a1006644.1493272570.git.panand@redhat.com>
In-Reply-To: <cover.1493272570.git.panand@redhat.com>
References: <cover.1493272570.git.panand@redhat.com>
In-Reply-To: <cover.1493272570.git.panand@redhat.com>
References: <cover.1493272570.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, keescook@chromium.org, bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org, yinghai@kernel.org, mingo@kernel.org

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
index ab5aae8f1b26..b38ba2479d3d 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -62,6 +62,7 @@ get_page_offset_x86_64(void)
 	int i;
 	unsigned long long phys_start;
 	unsigned long long virt_start;
+	unsigned long page_offset_base;
 
 	for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
 		if (virt_start < __START_KERNEL_map
@@ -71,8 +72,25 @@ get_page_offset_x86_64(void)
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
