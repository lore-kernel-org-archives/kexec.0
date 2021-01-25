Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l47Oi-00077h-PG
 for kexec@lists.infradead.org; Mon, 25 Jan 2021 19:19:52 +0000
Received: by mail-qt1-x82d.google.com with SMTP id o18so10495482qtp.10
 for <kexec@lists.infradead.org>; Mon, 25 Jan 2021 11:19:36 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v10 06/18] arm64: trans_pgd: pass NULL instead of init_mm to
 *_populate functions
Date: Mon, 25 Jan 2021 14:19:11 -0500
Message-Id: <20210125191923.1060122-7-pasha.tatashin@soleen.com>
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, tyhicks@linux.microsoft.com

trans_pgd_* should be independent from mm context because the tables that
are created by this code are used when there are no mm context around, as
it is between kernels. Simply replace mm_init's with NULL.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/arm64/mm/trans_pgd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 47b6b7029907..ded8e2ba0308 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -67,7 +67,7 @@ static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
 	dst_ptep = trans_alloc(info);
 	if (!dst_ptep)
 		return -ENOMEM;
-	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
+	pmd_populate_kernel(NULL, dst_pmdp, dst_ptep);
 	dst_ptep = pte_offset_kernel(dst_pmdp, start);
 
 	src_ptep = pte_offset_kernel(src_pmdp, start);
@@ -90,7 +90,7 @@ static int copy_pmd(struct trans_pgd_info *info, pud_t *dst_pudp,
 		dst_pmdp = trans_alloc(info);
 		if (!dst_pmdp)
 			return -ENOMEM;
-		pud_populate(&init_mm, dst_pudp, dst_pmdp);
+		pud_populate(NULL, dst_pudp, dst_pmdp);
 	}
 	dst_pmdp = pmd_offset(dst_pudp, start);
 
@@ -126,7 +126,7 @@ static int copy_pud(struct trans_pgd_info *info, p4d_t *dst_p4dp,
 		dst_pudp = trans_alloc(info);
 		if (!dst_pudp)
 			return -ENOMEM;
-		p4d_populate(&init_mm, dst_p4dp, dst_pudp);
+		p4d_populate(NULL, dst_p4dp, dst_pudp);
 	}
 	dst_pudp = pud_offset(dst_p4dp, start);
 
@@ -241,7 +241,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		p4dp = trans_alloc(info);
 		if (!pgdp)
 			return -ENOMEM;
-		pgd_populate(&init_mm, pgdp, p4dp);
+		pgd_populate(NULL, pgdp, p4dp);
 	}
 
 	p4dp = p4d_offset(pgdp, dst_addr);
@@ -249,7 +249,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		pudp = trans_alloc(info);
 		if (!pudp)
 			return -ENOMEM;
-		p4d_populate(&init_mm, p4dp, pudp);
+		p4d_populate(NULL, p4dp, pudp);
 	}
 
 	pudp = pud_offset(p4dp, dst_addr);
@@ -257,7 +257,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		pmdp = trans_alloc(info);
 		if (!pmdp)
 			return -ENOMEM;
-		pud_populate(&init_mm, pudp, pmdp);
+		pud_populate(NULL, pudp, pmdp);
 	}
 
 	pmdp = pmd_offset(pudp, dst_addr);
@@ -265,7 +265,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		ptep = trans_alloc(info);
 		if (!ptep)
 			return -ENOMEM;
-		pmd_populate_kernel(&init_mm, pmdp, ptep);
+		pmd_populate_kernel(NULL, pmdp, ptep);
 	}
 
 	ptep = pte_offset_kernel(pmdp, dst_addr);
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
