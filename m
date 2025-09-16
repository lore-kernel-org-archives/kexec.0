Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C257BCAC599
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 01:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EYusAw+ydKRQCYLdtHQyUeEwT4JHuq76P/m5GhX8G8M=; b=RagGnfPTU3pxB9OzGGhU0XWXKB
	jz3wkZax6IoY4+4q4bIFith6ZrFgfUbN9k3BAbrA36GqqPnL0nJuE9sCwZMhm9CwqlTTZN02nFBEB
	2HkT0qLwV3BsRWa9pLOKCwd4OFW+EJotRDeGSl2NBhjtg5KQdrBNEIBKnfXw1JUrn4GmtG4rcTcOO
	DSZluIK6AZ3EHad+q4SRU1cVr7UBYx3Hhnt9bj6CB4biBQPcHb5XIh5wi2ypD1Xw7lsP+HLxTXCxQ
	alSvXYjQ17aLLuEvNfJctvJKUgo0CcUI7NW54y0TINZaXhdyfnQx+kFt6kw9VZgULGQw5LmPf6kPN
	byxD/lOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKt2-00000006Cc8-2aLh;
	Tue, 16 Sep 2025 01:53:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKt1-00000006Cal-2V5N
	for kexec@bombadil.infradead.org;
	Tue, 16 Sep 2025 01:53:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=EYusAw+ydKRQCYLdtHQyUeEwT4JHuq76P/m5GhX8G8M=; b=IG93i01nLibokwC2L+yId7fcTg
	e/AKhEsQQj5oCChdidULm0lbfBosc5qTyfNgKcekDxe0ghm887uCYzOoxNRZYOAbg8lglmDo47FmD
	+EMP1S9zGsyGWvODY7XHpaTbJBLhTADJUprAv0KNiGQ1oIFxv22ZD8rDYPZ1J65ll0W4QFAekTKBc
	de46bHu1uC/RsSswzFeSDsBf3E3e/B97lLaD5P0GOYTWhxMi0SeIYXXjz5F5i2dObVcCulgdkZjdd
	+D96ykf1PcMa0hptnGSjSMwGj4f3V6gRfq1+VObiHY1ceG/ShFuR7hRIS/3boBo1iSS0mZTNs/AB5
	CGswer1g==;
Received: from out-186.mta0.migadu.com ([2001:41d0:1004:224b::ba])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsx-000000077kC-3RkS
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 01:53:38 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757987299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYusAw+ydKRQCYLdtHQyUeEwT4JHuq76P/m5GhX8G8M=;
	b=ANvLWaAsZHJR8zXjDS/MG+b9yxyZZM1RSsT4zRXAJW7lg2ffv+K+FD7ZBS5GZkwGMslMpK
	am5O9X9OWixQCyu3p3ZPtFN9OYlXRGY8YPCR7JvTNYixzev1cwJWYBCw4lJwjzNgoN3GDZ
	AV3vqVVehHWsksTUL4lwXO+CLWOjDyc=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	kexec@lists.infradead.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>,
	Chenghao Duan <duanchenghao@kylinos.cn>
Subject: [PATCH v2 05/10] LoongArch: Change initrd allocation to top-down
Date: Tue, 16 Sep 2025 09:46:50 +0800
Message-Id: <20250916014655.841632-6-youling.tang@linux.dev>
In-Reply-To: <20250916014655.841632-1-youling.tang@linux.dev>
References: <20250916014655.841632-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_025336_295820_2BEE94C1 
X-CRM114-Status: UNSURE (   8.30  )
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

From: Youling Tang <tangyouling@kylinos.cn>

When loading a secondary kernel with KASLR enabled, the randomized relocation
of the kernel image may overlap the initrd memory region, causing data corruption
and boot failure. This occurs because KASLR dynamically shifts the kernel's load
address, which could accidentally target the initrd's pre-allocated space.

Modify the initrd allocation strategy from bottom-up to top-down within the
reserved memory region. By placing the initrd at higher addresses first, we
minimize the risk of the relocated kernel overwriting it.

Reported-by: Chenghao Duan <duanchenghao@kylinos.cn>
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 kexec/arch/loongarch/kexec-loongarch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index c335e0b..32cd484 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -317,7 +317,7 @@ int loongarch_load_other_segments(struct kexec_info *info, unsigned long hole_mi
 		initrd_base = add_buffer(info, initrd_buf, initrd_size,
 					initrd_size, sizeof(void *),
 					_ALIGN_UP(initrd_min,
-						pagesize), hole_max, 1);
+						pagesize), hole_max, -1);
 		dbgprintf("initrd_base: %lx, initrd_size: %lx\n", initrd_base, initrd_size);
 
 		cmdline_add_initrd(cmdline, initrd_base, initrd_size);
-- 
2.34.1


