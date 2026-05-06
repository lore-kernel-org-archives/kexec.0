Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A7BCD3436
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Mime-Version:Message-Id:In-Reply-To:Subject:From:To:Content-Type:References:
	Cc:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YeS0QPnSv0aM0izN7SJxmYTtXB7tT4UpcetS6NXsMMA=; b=I0YGjBw5O84YVJ5jbUkZgAGDtM
	VTYKsveT2VZ9xR9xgOLN8y1sfKV4jjU7DUSdOHykOMPiH6/gQA40REDdM1FXJhaVaakd35t+UgGda
	5xQBkJcWwB0lbp+Lp3V1IyGYQfemmJ4lkhPimIeD4FuPtV3v+iiuk99qj45z20QYT3iOzFYMgdYzl
	ox5LBzidj9M4dmFtzrDWR1VfuIH/qXX36HM5WIYdYGZEeiZkflsjgF56brZgcJZAV0Hu4IAbzX/b/
	7yFiCPYp+GzlSSItKEWoHSkNJM1K96hcNmIVpwqBsdtj6gm9zO3FKlUb1pNwnbDwPdL2Rqqt+DUGQ
	hwKz2/9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKayO-00000000i6O-3X31;
	Wed, 06 May 2026 12:03:28 +0000
Received: from sg-3-112.ptr.tlmpb.com ([101.45.255.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKayN-00000000i5k-1r0u
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 12:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778068696; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=YeS0QPnSv0aM0izN7SJxmYTtXB7tT4UpcetS6NXsMMA=;
 b=YQ3/0PQKU4MLutW2r4g9IM/XjoFNrW1mdhZ2DoyiCPyL3+DnLngJQOyctnLA+qaIyASUUo
 9cFGY67Gk3l1irsWyZqEHdf5ExUgw6bbYW4VR4kWxxi/EAuX2EYXFphnrZL1MUtQ2/0AC/
 Rh3XyxR0Oqw/yZgzg1gpjv+O6KTcZtE7H3UxeUdiRF9sUCcTOQLx+6JrpDgYLPIBIVPqvn
 urm+qre0gVuKZf2+LopTduTsto+QTnSqnSChpuX6jhCzzL0S0fKc68SQH94EhluSp0mAD7
 80aXeTn74lG/bx7fWfH6fgyjSllNEJ2M0YBTpXAIrT4UGmnFJfJr73BN8lHjog==
Date: Wed,  6 May 2026 19:57:57 +0800
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Cc: "Rui Qi" <qirui.001@bytedance.com>, "Shuan He" <heshuan@bytedance.com>
References: <20260506115758.2497610-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <kexec@lists.infradead.org>
From: "Rui Qi" <qirui.001@bytedance.com>
Subject: [PATCH][makedumpfile] 1/2 riscv64: Fix vaddr_to_paddr for vmalloc and vmemmap regions
In-Reply-To: <20260506115758.2497610-1-qirui.001@bytedance.com>
Message-Id: <20260506115758.2497610-2-qirui.001@bytedance.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1
X-Lms-Return-Path: <lba+269fb2cd6+48ac34+lists.infradead.org+qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_050327_653881_D712DE7D 
X-CRM114-Status: UNSURE (   6.67  )
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

The current vaddr_to_paddr_riscv64() incorrectly uses VTOP() linear
mapping for vmalloc and vmemmap addresses, which are not linearly
mapped. Add checks to exclude these regions so they fall through to
page table walk via vtop_riscv64().

Co-developed-by: Rui Qi <qirui.001@bytedance.com>
Signed-off-by: Shuan He <heshuan@bytedance.com>
---
 arch/riscv64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv64.c b/arch/riscv64.c
index 1b43ec4f62a1..28365fa0cc5b 100644
--- a/arch/riscv64.c
+++ b/arch/riscv64.c
@@ -202,6 +202,8 @@ vaddr_to_paddr_riscv64(unsigned long vaddr)
 	unsigned long long swapper_phys;
 
 	if (vaddr >= PAGE_OFFSET &&
+	    !(vaddr >= NUMBER(vmalloc_start) && vaddr <= NUMBER(vmalloc_end)) &&
+	    !(vaddr >= NUMBER(vmemmap_start) && vaddr <= NUMBER(vmemmap_end)) &&
 	    !(vaddr >= NUMBER(modules_vaddr) && vaddr <= NUMBER(modules_end))){
 		return VTOP(vaddr);
 	}
-- 
2.20.1

