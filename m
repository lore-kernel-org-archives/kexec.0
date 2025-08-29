Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67803CA0FF9
	for <kexec@archiver.kernel.org>; Fri, 29 Aug 2025 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2LO4ZEsX97BTO//S8vTmFlLedqVPpfeYZsTNF1IT0Y8=; b=cas1fRn3zXvFjgmHwq8P3IkLWm
	QWB87QK8eZ4UBQMT7ZxEogXmN8ESx2L5+dGfctdGufrE6Qjjj/XWRSYj48VRxdZzPfqmNnaWSDcic
	q694if83K6oNRtylJEA31AlD4/03x33uc3I8bVVqo2fBOM1843pd2BO7vAm/4o2MW72muiB6YxFAf
	q5j5jB/BN9GPwj8ua9cW02LjJAUwFAiDKU/p52kGcea9mCvPrL98UJaOOzSnAoQeNF5NAiaxp5Ye9
	x56GPizd+o/mFaIBBkwvte3iix7qrDrbCRgCPG1KvrFptmJyifj+sgdpQ9YRNRIduQ9Wop3jQK0gL
	GSDJWUDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urwDD-00000005Igl-02Zo;
	Fri, 29 Aug 2025 10:20:03 +0000
Received: from out-188.mta1.migadu.com ([2001:41d0:203:375::bc])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urv9I-0000000562E-3YYn
	for kexec@lists.infradead.org;
	Fri, 29 Aug 2025 09:11:58 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756458714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2LO4ZEsX97BTO//S8vTmFlLedqVPpfeYZsTNF1IT0Y8=;
	b=fyisTO1XuXBhmhUny/e4zuzNJtmrVNu1Eu+OMhkTT8fe41YKOACGbmm8PAVHcTY90k+iX6
	sgEbdBwahY7+bVYI6JkTdYcQa7/pNhEkwE6hnKkR3UXklyYw3moqJrXaKSfzqO3AjJ4bR6
	8I+HOCxLSbstmyR35JxS2oJJCsiiat0=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinios.cn>,
	Chenghao Duan <duanchenghao@kylinos.cn>
Subject: [PATCH 5/7] LoongArch: Change initrd allocation to top-down
Date: Fri, 29 Aug 2025 17:10:38 +0800
Message-Id: <20250829091040.35827-6-youling.tang@linux.dev>
In-Reply-To: <20250829091040.35827-1-youling.tang@linux.dev>
References: <20250829091040.35827-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_021157_028615_A6AB3563 
X-CRM114-Status: UNSURE (   7.97  )
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

From: Youling Tang <tangyouling@kylinios.cn>

When loading a secondary kernel with KASLR enabled, the randomized relocation
of the kernel image may overlap the initrd memory region, causing data corruption
and boot failure. This occurs because KASLR dynamically shifts the kernel's load
address, which could accidentally target the initrd's pre-allocated space.

Modify the initrd allocation strategy from bottom-up to top-down within the
reserved memory region. By placing the initrd at higher addresses first, we
minimize the risk of the relocated kernel overwriting it.

Reported-by: Chenghao Duan <duanchenghao@kylinos.cn>
Signed-off-by: Youling Tang <tangyouling@kylinios.cn>
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


