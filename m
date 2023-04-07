Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94A1C761A6
	for <kexec@archiver.kernel.org>; Fri,  7 Apr 2023 01:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bd6MFtMq2D23kErA/7HWc2m5ZZkkQYfH2dwNjlT2Z3A=; b=JRkAaRzCkuWjte
	W3maBlHCfh+aFLj+78fRAVJ6EWVGkSf9ceE26xsECsrWIKtwrbziW4j3rah3uHW7oGYHC8XAK/NMh
	+wCoEOO+bddyVXRh/s7cjXuZIQ6t+EBhSGXILYIlndeNWqD2edI2DcdoH97uCswa1zr6h94B9OG/1
	Z0JKrzmuFGmNzln6JvqNk6/FWEHzcJUYMNmYFGpYkkn0o74JYtT/cmzSTXz5Bb354Peovc0rkcWbP
	nXodFZ0tapNDL4A+ZtMOlMmgo12HAyaT+madegAP9xT27/ql1rcvMC7uDbg/Q/8Wi5w9vUk+yn3mi
	HmDIMpossoM23nQQh4QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkahj-008vyX-2y;
	Fri, 07 Apr 2023 01:15:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkahh-008vxG-0i
	for kexec@lists.infradead.org;
	Fri, 07 Apr 2023 01:15:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680830148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wyhFBqDO1MjHjj4hsjkNBn2UQkr+0AMWB+0eD0EOGw=;
	b=XlWGMN6TjtiTN2YDc727AutM3+YBAvJPutcCE10SewjbEj34LDZBIFxldS4PXInbz+X3Ar
	T5GKSM9YHHH3G+dC/p7FuXM84lAhfPhy/B7P61Q+VBGEkNjABea1CmZFUulBSV99q1qKBt
	0mydGkv/77s2XjRCXhtpDzPBh+gO5Q8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-TfRYGdxlOGyQDUCWR8k82w-1; Thu, 06 Apr 2023 21:15:31 -0400
X-MC-Unique: TfRYGdxlOGyQDUCWR8k82w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D2CD101A550;
	Fri,  7 Apr 2023 01:15:30 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-86.pek2.redhat.com [10.72.12.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB2E218EC7;
	Fri,  7 Apr 2023 01:15:24 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	rppt@kernel.org,
	thunder.leizhen@huawei.com,
	will@kernel.org,
	ardb@kernel.org,
	horms@kernel.org,
	John.p.donnelly@oracle.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/3] arm64: kdump: do not map crashkernel region specifically
Date: Fri,  7 Apr 2023 09:15:06 +0800
Message-Id: <20230407011507.17572-3-bhe@redhat.com>
In-Reply-To: <20230407011507.17572-1-bhe@redhat.com>
References: <20230407011507.17572-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_181549_329430_D95AF061 
X-CRM114-Status: GOOD (  13.04  )
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

After taking off the protection functions on crashkernel memory region,
there's no need to map crashkernel region with page granularity during
linear mapping.

With this change, the system can make use of block or section mapping
on linear region to largely improve perforcemence during system bootup
and running.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/mmu.c | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6f9d8898a025..7556020a27b7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -510,21 +510,6 @@ void __init mark_linear_text_alias_ro(void)
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
@@ -554,16 +539,6 @@ static void __init map_mem(pgd_t *pgdp)
 	 */
 	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
 
-#ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map) {
-		if (defer_reserve_crashkernel())
-			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
-		else if (crashk_res.end)
-			memblock_mark_nomap(crashk_res.start,
-			    resource_size(&crashk_res));
-	}
-#endif
-
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
 		if (start >= end)
@@ -590,24 +565,6 @@ static void __init map_mem(pgd_t *pgdp)
 	__map_memblock(pgdp, kernel_start, kernel_end,
 		       PAGE_KERNEL, NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
-
-	/*
-	 * Use page-level mappings here so that we can shrink the region
-	 * in page granularity and put back unused memory to buddy system
-	 * through /sys/kernel/kexec_crash_size interface.
-	 */
-#ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map && !defer_reserve_crashkernel()) {
-		if (crashk_res.end) {
-			__map_memblock(pgdp, crashk_res.start,
-				       crashk_res.end + 1,
-				       PAGE_KERNEL,
-				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-			memblock_clear_nomap(crashk_res.start,
-					     resource_size(&crashk_res));
-		}
-	}
-#endif
 }
 
 void mark_rodata_ro(void)
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
