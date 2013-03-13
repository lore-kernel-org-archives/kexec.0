Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFpPD-0005jA-GH
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 17:24:00 +0000
Received: by mail-pb0-f50.google.com with SMTP id up1so1232300pbc.23
 for <kexec@lists.infradead.org>; Wed, 13 Mar 2013 10:23:58 -0700 (PDT)
Message-ID: <5140B625.2010106@gmail.com>
Date: Thu, 14 Mar 2013 01:23:49 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 03/13] kexec: ppc: remove duplicated _ALIGN_* macros
References: <5140B511.7020109@gmail.com>
In-Reply-To: <5140B511.7020109@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

We have defined the global align macros for use, so remove the
duplicated macros here.

And in file kexec/arch/ppc/include/page.h, we directly expand the
align operation for marco PAGE_ALIGN since we have removed marco
_ALIGN in this file.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/ppc/include/page.h      |    9 +--------
 kexec/arch/ppc64/crashdump-ppc64.h |    2 --
 2 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/kexec/arch/ppc/include/page.h b/kexec/arch/ppc/include/page.h
index 14eca30..65877bc 100644
--- a/kexec/arch/ppc/include/page.h
+++ b/kexec/arch/ppc/include/page.h
@@ -21,14 +21,7 @@
 #define PAGE_SIZE	(ASM_CONST(1) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
-/* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
-
-/* align addr on a size boundary - adjust address up if needed */
-#define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
-
 /* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
+#define PAGE_ALIGN(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
 
 #endif				/* _PPC_BOOT_PAGE_H */
diff --git a/kexec/arch/ppc64/crashdump-ppc64.h b/kexec/arch/ppc64/crashdump-ppc64.h
index 739c61f..e9d28c9 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.h
+++ b/kexec/arch/ppc64/crashdump-ppc64.h
@@ -20,8 +20,6 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size);
 #define BACKUP_SRC_SIZE     (BACKUP_SRC_END - BACKUP_SRC_START + 1)
 
 #define KDUMP_BACKUP_LIMIT	BACKUP_SRC_SIZE
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
 
 #define KERNEL_RUN_AT_ZERO_MAGIC 0x72756e30	/* "run0" */
 
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
