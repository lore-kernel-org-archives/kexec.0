Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yif0s-00037y-RG
 for kexec@lists.infradead.org; Thu, 16 Apr 2015 08:19:07 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id t3G8IjTi002431
 for <kexec@lists.infradead.org>; Thu, 16 Apr 2015 17:18:45 +0900 (JST)
Received: from mailsv4.nec.co.jp (imss63.nec.co.jp [10.7.69.158]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id t3G8Ii704732 for <kexec@lists.infradead.org>;
 Thu, 16 Apr 2015 17:18:44 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id t3G8IiYX016768
 for <kexec@lists.infradead.org>; Thu, 16 Apr 2015 17:18:44 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH] makedumpfile: Correct vmap_area_list support for i386 and
 ppc32.
Date: Thu, 16 Apr 2015 08:13:57 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DA4CB0@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

When vmap_area_list was exported instead of vmlist in linux 3.10,
we fixed makedumpfile to refer to both of them, but I found that
the fix is incomplete. This bug will be fixed in v1.5.9.


Thanks,
Atsushi Kumagai


From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Date: Tue, 14 Apr 2015 09:14:47 +0900
Subject: [PATCH] Correct vmap_area_list support for i386 and ppc32.

This fix is for cee64e3d8b and 8145e413ab.
vaddr_to_paddr() should allow to refer to vmalloc_start if
either vmlist or vmap_area_list is exported from the kernel
since vmalloc_start can be gotten from them.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 arch/ppc.c |    7 +++++--
 arch/x86.c |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/ppc.c b/arch/ppc.c
index a3e1a12..37c6a3b 100644
--- a/arch/ppc.c
+++ b/arch/ppc.c
@@ -101,8 +101,11 @@ vaddr_to_paddr_ppc(unsigned long vaddr)
 	if (paddr != NOT_PADDR)
 		return paddr;
 
-	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
-	    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
+	if (((SYMBOL(vmap_area_list) == NOT_FOUND_SYMBOL)
+	     || (OFFSET(vmap_area.va_start) == NOT_FOUND_STRUCTURE)
+	     || (OFFSET(vmap_area.list) == NOT_FOUND_STRUCTURE))
+	    && ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
+		|| (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE))) {
 		ERRMSG("Can't get necessary information for vmalloc translation.\n");
 		return NOT_PADDR;
 	}
diff --git a/arch/x86.c b/arch/x86.c
index e397905..1b4d2b6 100644
--- a/arch/x86.c
+++ b/arch/x86.c
@@ -239,8 +239,11 @@ vaddr_to_paddr_x86(unsigned long vaddr)
 	if ((paddr = vaddr_to_paddr_general(vaddr)) != NOT_PADDR)
 		return paddr;
 
-	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
-	    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
+	if (((SYMBOL(vmap_area_list) == NOT_FOUND_SYMBOL)
+	     || (OFFSET(vmap_area.va_start) == NOT_FOUND_STRUCTURE)
+	     || (OFFSET(vmap_area.list) == NOT_FOUND_STRUCTURE))
+	    && ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
+		|| (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE))) {
 		ERRMSG("Can't get necessary information for vmalloc translation.\n");
 		return NOT_PADDR;
 	}
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
