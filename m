Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cpqVR-0002Y8-KZ
 for kexec@lists.infradead.org; Mon, 20 Mar 2017 06:09:27 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [RFC PATCH] x86_64/mm/boot: Fix kernel_ident_mapping_init() failure
 for kexec
Date: Mon, 20 Mar 2017 14:11:31 +0800
Message-Id: <1489990291-2252-1-git-send-email-xlpang@redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Ingo Molnar <mingo@redhat.com>, Xunlei Pang <xlpang@redhat.com>, x86@kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

I found that the kdump is broken on linux-4.11.0-rc2+, probably
due to the 5level-paging feature that "#define p4d_present(p4d) 1",
as a result in ident_p4d_init(), it will go into ident_pud_init()
directly without allocating the new pud.

Looks like this patch can make it work again.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 arch/x86/mm/ident_map.c            | 22 ++++++++++------------
 include/asm-generic/5level-fixup.h |  6 +++---
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 04210a2..d14bb52 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -97,22 +97,20 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 			continue;
 		}
 
-		p4d = (p4d_t *)info->alloc_pgt_page(info->context);
-		if (!p4d)
-			return -ENOMEM;
+		if (IS_ENABLED(CONFIG_X86_5LEVEL)) {
+			p4d = (p4d_t *)info->alloc_pgt_page(info->context);
+			if (!p4d)
+				return -ENOMEM;
+		} else {
+			p4d = pgd;
+		}
+
 		result = ident_p4d_init(info, p4d, addr, next);
 		if (result)
 			return result;
-		if (IS_ENABLED(CONFIG_X86_5LEVEL)) {
+
+		if (IS_ENABLED(CONFIG_X86_5LEVEL))
 			set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
-		} else {
-			/*
-			 * With p4d folded, pgd is equal to p4d.
-			 * The pgd entry has to point to the pud page table in this case.
-			 */
-			pud_t *pud = pud_offset(p4d, 0);
-			set_pgd(pgd, __pgd(__pa(pud) | _KERNPG_TABLE));
-		}
 	}
 
 	return 0;
diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index b5ca82d..3131ada 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -17,9 +17,9 @@
 
 #define p4d_alloc(mm, pgd, address)	(pgd)
 #define p4d_offset(pgd, start)		(pgd)
-#define p4d_none(p4d)			0
-#define p4d_bad(p4d)			0
-#define p4d_present(p4d)		1
+#define p4d_none(p4d)			pgd_none(p4d)
+#define p4d_bad(p4d)			pgd_bad(p4d)
+#define p4d_present(p4d)		pgd_present(p4d)
 #define p4d_ERROR(p4d)			do { } while (0)
 #define p4d_clear(p4d)			pgd_clear(p4d)
 #define p4d_val(p4d)			pgd_val(p4d)
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
