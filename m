Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B20ACD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 12:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:Date:To:Mime-Version:Cc:References:Message-Id:From:
	In-Reply-To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pxvLGZeW6ypBIy0Q0BdWnrZwZo41ybzG+ytDqbGOTdo=; b=WDFF8ePwb3/FA3vk6CUN3KDD1W
	J3hxcIuCgnQlMxyZff7ZVXi94U1Kk/8VS+RnKdypRKztbDVoBx9Nu5DD+uKav0Jc/58HDF7iuwYgI
	RFRgOYKeJ/+ZvASH5eHtibz2wm/4BBbMbKW3S/kDckmwVCGstpb/4WwRXJ4G+lAtWE/bIcyZUXf0i
	rD3kKzL+ZMdp+VjMluTq5APISssUzqklsevyyfRL5I8aR/Lg6XigAYI2d9cQXGxsXuwGHNxMLizGD
	fNKBFr3cfgwCDwXQ9CUid1qCFwjPHLCP+jOP2/XBlOdPY+V2lWbJ1vSwe5OluhwXDwkrHbhkNy5qb
	KWeuAIdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKayS-00000000i8O-3nPr;
	Wed, 06 May 2026 12:03:32 +0000
Received: from sg-3-112.ptr.tlmpb.com ([101.45.255.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKayR-00000000i6o-105N
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 12:03:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778068702; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=pxvLGZeW6ypBIy0Q0BdWnrZwZo41ybzG+ytDqbGOTdo=;
 b=JX+3WHx9Sm5urZkJb/itBiXPvP0rJ8+Gt3Q3ZZkHDNWAT29SdDfzsN7ISaKq+Xi9Dtdnsc
 kC3ZtDnrqycByNSyv9v5PQP35JtwJm7C1ZxPaoRKZXVFC1J1xnBnAyTU4Ix5NLigk8j7VT
 8enAVQwPKWD6Ca9HiNRdH38j/izoUo5nYgxJck0VUbcOC7Pd6D5SbDRgVmqh0a7jICDK8s
 OzHhPdSLKmxif6G5TrTwrXstyIS0u6GZro2ts117WYGJ8QXWCZ/H4DYNf6Qca5uqcfjAUE
 t7zb0k28457V54mxSDxy2CymtgmKRNuvFL3EU9rJNd5lID8eCUkosZI/4/khZQ==
Subject: [PATCH][makedumpfile] 2/2 riscv64: Fix huge page translation in vtop_riscv64()
In-Reply-To: <20260506115758.2497610-1-qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <20260506115758.2497610-3-qirui.001@bytedance.com>
References: <20260506115758.2497610-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.20.1
Cc: "Rui Qi" <qirui.001@bytedance.com>, "Shuan He" <heshuan@bytedance.com>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+269fb2cdc+10e266+lists.infradead.org+qirui.001@bytedance.com>
To: <kexec@lists.infradead.org>
Date: Wed,  6 May 2026 19:57:58 +0800
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_050331_453587_AC9ACFDB 
X-CRM114-Status: UNSURE (   8.92  )
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
 arch/riscv64.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/riscv64.c b/arch/riscv64.c
index 28365fa0cc5b..67755331de24 100644
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
+		goto invalid;
+	}
 
 	if (va_bits == VA_BITS_SV57)
 		goto p4d;
@@ -133,8 +137,10 @@ p4d:
 
 	pt_phys = (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
 
-	if (pt_val & _PAGE_LEAF)
-		goto out;
+	if (pt_val & _PAGE_LEAF) {
+		paddr = (pt_phys & ~((1ULL << P4D_SHIFT) - 1)) + (vaddr & ((1ULL << P4D_SHIFT) - 1));
+		goto invalid;
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
+		goto invalid;
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
+		goto invalid;
+	}
 
 	/* PTE */
 	ptea = (pte_t *)(pt_phys) + pte_index(vaddr);
-- 
2.20.1

