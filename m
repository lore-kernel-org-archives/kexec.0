Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9FACD5BC7
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 06:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=acZ9/LK5EVhAjK8ZnaMSqOtU1DWY9dKNeWMugFjaoLg=; b=16LJj/Op89yPGBG+rW6/PTGwcY
	ncD8myaAYy/vSZb300j+bnEd//TjlU9tXvDU4HZpyMJn1+Nu0UYUudnL9F0Tl7++8XuKIBc+A99ld
	OO/056d0PlSwlaBNRNhWZGBrRLkgkduxNXlBFRH+pIQr96M2pFE8vqCFghdmlhJ2XkH46aO8OFadZ
	xzT0CSLU+ovX+rJVYpOIZOCYkMjzOv2JCzCcAWrU3TLAk1m5dAicd+KPGw3vnJa7QzfWhV5CHA6OX
	JY/TIaHbICcoyb1XpDtpmq0Tm3ZIBw2IN/ADVRZn4lnldnS8T2W2M2ux9X6ZexEVBRZp/X/3/6u9h
	2MzMKR3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROni-0000000GQ4N-3qX0;
	Mon, 25 May 2026 06:28:34 +0000
Received: from out-187.mta1.migadu.com ([95.215.58.187])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROnd-0000000GQ1P-20GW
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 06:28:30 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779690507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acZ9/LK5EVhAjK8ZnaMSqOtU1DWY9dKNeWMugFjaoLg=;
	b=VuZqun4Pplkhr1ruJCNhwVyCRlrJ8YN5XTuCHzFwjIcN4On6My5+wO2nuTa2YcDH+R4x6j
	OjQ+8k237y/C3DS7wVCLCALfIUOCRMwX/WzkA/gCfLrA6MW2xJnKiJbNKOWvZQoDysQxv0
	8CF/cAFRfIql3lLNEgSTyZ3IVe4HdCo=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org
Cc: kernel@xen0n.name,
	graf@amazon.com,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>,
	Kexin Liu <liukexin@kylinos.cn>
Subject: [PATCH 3/7] LoongArch: Add missing linux/mm.h include in asm/io.h
Date: Mon, 25 May 2026 14:28:06 +0800
Message-Id: <20260525062810.103367-4-dongtai.guo@linux.dev>
In-Reply-To: <20260525062810.103367-1-dongtai.guo@linux.dev>
References: <20260525062810.103367-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260524_232829_662456_3C0F39C2 
X-CRM114-Status: UNSURE (   8.04  )
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

From: George Guo <guodongtai@kylinos.cn>

When CONFIG_KFENCE is enabled, the virt_to_phys() and phys_to_virt()
macros in arch/loongarch/include/asm/io.h expand to use offset_in_page()
and page_address(), both of which are declared in <linux/mm.h>.

Without this include, any translation unit that includes <asm/io.h> and
expands these macros with CONFIG_KFENCE=y will fail to build. This was
observed when building kernel/liveupdate/luo_session.c with
CONFIG_KFENCE=y:

  asm/io.h: error: implicit declaration of function 'offset_in_page'
  asm/io.h: error: implicit declaration of function 'page_address'

Add the missing include to fix these build errors.

Fixes: 0ca84aeaee15 ("LoongArch: Make {virt, phys, page, pfn} translation work with KFENCE")
Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index 0130185e0349..7ff4aa72a34a 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -13,6 +13,7 @@
 #include <asm/page.h>
 #include <asm/pgtable-bits.h>
 #include <asm/string.h>
+#include <linux/mm.h>
 
 extern void __init __iomem *early_ioremap(phys_addr_t phys_addr, unsigned long size);
 extern void __init early_iounmap(void __iomem *addr, unsigned long size);
-- 
2.25.1


