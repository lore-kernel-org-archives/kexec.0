Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from unicom145.biz-email.net ([210.51.26.145])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTHhe-00AKAN-Gg
 for kexec@lists.infradead.org; Thu, 23 Sep 2021 05:55:29 +0000
From: Kai Song <songkai01@inspur.com>
Subject: [PATCH] kexec:Remove unused local variable in get_kernel_page_offset()
Date: Thu, 23 Sep 2021 13:32:43 +0800
Message-ID: <20210923053243.8320-1-songkai01@inspur.com>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Kai Song <songkai01@inspur.com>

In get_kernel_page_offset(),the local variable kv is unused,remove it.

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 kexec/arch/i386/crashdump-x86.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 81610dc..9826f6d 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -52,7 +52,6 @@ extern struct arch_options_t arch_options;
 static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
 				  struct crash_elf_info *elf_info)
 {
-	int kv;
 
 	if (elf_info->machine == EM_X86_64) {
 		/* get_kernel_vaddr_and_size will override this */
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
