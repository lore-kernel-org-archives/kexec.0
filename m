Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA75ECAAD1
	for <kexec@archiver.kernel.org>; Sun, 28 Aug 2022 00:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zZWenKbDpeIXUV2pS4WL4O9weFkqYgYU7GAQxtjXMDU=; b=F5Potjw4/+iUcI
	IvNdcolA/K9Db0QCTcnAOUT/QB7bjSzTpX5//2hVYwfj9odrRjuaTt7ZBoEs5KMnyQtyK7Af3C6P4
	FuH3AtirWWz815aGGIB8hcYCpnzNo2z6kggWHQBNNKBkKDzrE4UI1m/s8QH6LhDIAP4QOKWIFWKlo
	80GZCpwG95IznxQaTej0G/3autX/nS76lI7m+jzn3uebjq06ocpXS+Yl+bIC/FSljsb5RrfOLON/Y
	rFGYeKealolg1Ju1thz2uPRVrMWgoQ6bLPPHLZGwRlk9mb2mvGJUtVc1Lm7SJHE+HPjFDyTuUaMHU
	lBqjCll6wL5zJmCva92Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oS6bn-0074Oq-KM; Sun, 28 Aug 2022 00:57:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oS6b0-0073Kk-2Q
	for kexec@lists.infradead.org; Sun, 28 Aug 2022 00:56:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661648173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klvCIsgXfinczEtZu1vkS1Kza9b+D2rCSj6ESjeEdL8=;
	b=PusNV5/honK/SupkV2/tBY8Y1n5uFjebnYuonpalh1xN+CzaYaIrFtrEYpI4XIsYYLw/Yl
	q2N9L8eTwF/kX50GZFgmSgEp0rma+rssMnPQ/ZIfiDfdEEp6VrzYbBUuS3lo9eHCWweZDi
	KP4LQm+zVABnPrr3fAgzc2atc9CvEZY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-mmYmt1CqPteYwdHhgDmfTw-1; Sat, 27 Aug 2022 20:56:08 -0400
X-MC-Unique: mmYmt1CqPteYwdHhgDmfTw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FAB729AB41D;
	Sun, 28 Aug 2022 00:56:08 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-25.pek2.redhat.com [10.72.12.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5F0A7492C3B;
	Sun, 28 Aug 2022 00:56:01 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com,
	ardb@kernel.org,
	rppt@kernel.org,
	guanghuifeng@linux.alibaba.com,
	mark.rutland@arm.com,
	will@kernel.org,
	linux-mm@kvack.org,
	thunder.leizhen@huawei.com,
	wangkefeng.wang@huawei.com,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] arm64: remove unneed defer_reserve_crashkernel() and crash_mem_map
Date: Sun, 28 Aug 2022 08:55:45 +0800
Message-Id: <20220828005545.94389-3-bhe@redhat.com>
In-Reply-To: <20220828005545.94389-1-bhe@redhat.com>
References: <20220828005545.94389-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220827_175614_323436_C7F6A650 
X-CRM114-Status: GOOD (  10.40  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Now they are not needed any more, clean them up.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/include/asm/memory.h |  5 -----
 arch/arm64/mm/mmu.c             | 15 ---------------
 2 files changed, 20 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 9dd08cd339c3..b9e71583c9cb 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -363,11 +363,6 @@ static inline void *phys_to_virt(phys_addr_t x)
 })
 
 void dump_mem_limit(void);
-
-static inline bool defer_reserve_crashkernel(void)
-{
-	return IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
-}
 #endif /* !ASSEMBLY */
 
 /*
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cdd338fa2115..c3f8f426c3d8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -502,21 +502,6 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
-static bool crash_mem_map __initdata;
-
-static int __init enable_crash_mem_map(char *arg)
-{
-	/*
-	 * Proper parameter parsing is done by reserve_crashkernel(). We only
-	 * need to know if the linear map has to avoid block mappings so that
-	 * the crashkernel reservations can be unmapped later.
-	 */
-	crash_mem_map = true;
-
-	return 0;
-}
-early_param("crashkernel", enable_crash_mem_map);
-
 static void __init map_mem(pgd_t *pgdp)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
