Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3D2CD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 08:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Mime-Version:Date:To:
	In-Reply-To:Message-Id:Subject:Cc:References:Content-Type:
	Content-Transfer-Encoding:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V9KXRg676xMX6ELzf/ckYYIxKiRzm94zQnkCmzTl0Tg=; b=HfjgpvD0OMsas/
	mOCPCxTMUMHmzpWJFsBLfceI7QTdB3U+u1Xrs9z4zrYyjvd9CCf/SBevShWWvmEiP5VhXDc9q1zzM
	VlbhefrfgWJ+9AZw3KXHz7w96zMPYmhryhL0iHaPcJt28cegXmExw3XdNxAq2SPUzSuU0SEzN5mlJ
	fNo5Qu5un/+tW7625/FXM5VZPUalNAFrn0Bmd3nQMEmXHokJMm1wNoD7d0ZTaFPaopNdGfKnm7axV
	us9ENkdl9ZUJHmuaDqiE7/nWgvRoMaPbAgTaB8bx1ztYUjhtAKRlAlpxOjcv1q3nvaJUdkzWBcIfg
	uVSdNFyYlK8wf/0OnkXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNnau-00000007hHB-0lAC;
	Fri, 15 May 2026 08:08:28 +0000
Received: from va-1-111.ptr.blmpb.com ([209.127.230.111])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNnar-00000007hFf-0r4A
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 08:08:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778832500; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=V9KXRg676xMX6ELzf/ckYYIxKiRzm94zQnkCmzTl0Tg=;
 b=iLqNvUIvbRtbf4mlHP/qTPdIbU0W3Hc/14Uo2QxQqz3zbqXIothDCjpU7j557tkwzvtFOb
 aZXDkiZZtSlIR2fbFMdaGWCe0pwYh9I9jDbJb0tXCXp8zQzDX82aZ2OG5vo9nceDOrDGzR
 CsZ6Wp40X/bnRyBo76asptQ3VlxmPwu7W6VZXMDCywE7HJYL07SrmMHCiRh/510STkNqnS
 br3RptAZd5Z2V/saaxksJ6F549Smku60g3KFz5hffi1rhaYn69/CuTgOQaGSXVqda+d3kI
 +zBGM0vPwrEVTzL+0GtCTe8v0vfc6Tb6Xixh4jGgL55/OEGztO8fd4Sx1BkFFw==
From: "Rui Qi" <qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
References: <20260515080745.70110-1-qirui.001@bytedance.com>
Cc: <k-hagio-ab@nec.com>, "Rui Qi" <qirui.001@bytedance.com>, 
	"Shuan He" <heshuan@bytedance.com>
Subject: [PATCH v2 2/2] riscv64: Fix huge page translation in vtop_riscv64()
Message-Id: <20260515080745.70110-3-qirui.001@bytedance.com>
In-Reply-To: <20260515080745.70110-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.52.0
X-Lms-Return-Path: <lba+26a06d472+748f55+lists.infradead.org+qirui.001@bytedance.com>
To: <kexec@lists.infradead.org>
Date: Fri, 15 May 2026 16:07:44 +0800
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_010825_310602_E4609B28 
X-CRM114-Status: UNSURE (   8.18  )
X-CRM114-Notice: Please train this message.
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

When a page table entry has _PAGE_LEAF set at PGD/P4D/PUD/PMD level,
the current code incorrectly falls through to the next level instead
of computing the correct physical address. Fix this by calculating
the paddr with the proper level shift and returning directly.

Co-developed-by: Rui Qi <qirui.001@bytedance.com>
Signed-off-by: Shuan He <heshuan@bytedance.com>
---
 arch/riscv64.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/riscv64.c b/arch/riscv64.c
index 28365fa0cc5b..7b640b6f7d29 100644
--- a/arch/riscv64.c
+++ b/arch/riscv64.c
@@ -107,8 +107,12 @@ vtop_riscv64(pgd_t * pgd, unsigned long vaddr, long va_bits)
 
 	pt_phys = (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
 
-	if (pt_val & _PAGE_LEAF)
-		goto out;
+	if (pt_val & _PAGE_LEAF) {
+		unsigned long shift = (va_bits == VA_BITS_SV57) ? PGD_SHIFT_L5 :
+				      (va_bits == VA_BITS_SV48) ? PGD_SHIFT_L4 : PGD_SHIFT_L3;
+		paddr = (pt_phys & ~((1ULL << shift) - 1)) + (vaddr & ((1ULL << shift) - 1));
+		return paddr;
+	}
 
 	if (va_bits == VA_BITS_SV57)
 		goto p4d;
@@ -133,8 +137,10 @@ p4d:
 
 	pt_phys = (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
 
-	if (pt_val & _PAGE_LEAF)
-		goto out;
+	if (pt_val & _PAGE_LEAF) {
+		paddr = (pt_phys & ~((1ULL << P4D_SHIFT) - 1)) + (vaddr & ((1ULL << P4D_SHIFT) - 1));
+		return paddr;
+	}
 pud:
 	/* PUD */
 	puda = (pud_t *)(pt_phys) + pud_index(vaddr);
@@ -152,8 +158,10 @@ pud:
 
 	pt_phys = (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
 
-	if(pt_val & _PAGE_LEAF)
-		goto out;
+	if (pt_val & _PAGE_LEAF) {
+		paddr = (pt_phys & ~((1ULL << PUD_SHIFT) - 1)) + (vaddr & ((1ULL << PUD_SHIFT) - 1));
+		return paddr;
+	}
 pmd:
 	/* PMD */
 	pmda = (pmd_t *)(pt_phys) + pmd_index(vaddr);
@@ -171,8 +179,10 @@ pmd:
 
 	pt_phys = (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
 
-	if (pt_val & _PAGE_LEAF)
-		goto out;
+	if (pt_val & _PAGE_LEAF) {
+		paddr = (pt_phys & ~((1ULL << PMD_SHIFT) - 1)) + (vaddr & ((1ULL << PMD_SHIFT) - 1));
+		return paddr;
+	}
 
 	/* PTE */
 	ptea = (pte_t *)(pt_phys) + pte_index(vaddr);
@@ -190,8 +200,7 @@ pmd:
 
 	pt_phys = (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
 
-out:
-	paddr = pt_phys + PAGEOFFSET(vaddr);
+	return pt_phys + PAGEOFFSET(vaddr);
 invalid:
 	return paddr;
 }
-- 
2.20.1

