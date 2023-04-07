Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDFBC76196
	for <kexec@archiver.kernel.org>; Fri,  7 Apr 2023 01:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4EdouDmAUadm2Dcw99DpAg2ka/xJbwYUVreaD4/mrG0=; b=uinnYwnQQsKuAA
	6NICoUxTQEKeXKGiHpea+VA4YTiq935eSQeR4clU/ouJjQDjVUHLYICaLmTLlm3jIzX1AMU2hV1Nw
	Xe+3bn9WZumUggTvs3kj1RP8Jdf8lP/s3iCHPPtf55klbuKUqCHHBSXPjH1cGJ8N6hcAMwH1hNuMe
	5afDaZvSmH0hVrDH49w1HhhdDpb7BvvsZlSUq3s+PIinhkBsDwMhrstjyCrtdEPa2R68kPHo9xBCS
	PmErCN2RGQVMUvL92Qq9y89aSYdQ3mQBLB0Xjv9zNQDawtQ12alwSQ/RKGj0nZc9y7Og7/4+if/6Y
	xyP7Mz8qFIPyhMZ+IXdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkahR-008vrh-1R;
	Fri, 07 Apr 2023 01:15:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkahM-008vqD-1p
	for kexec@lists.infradead.org;
	Fri, 07 Apr 2023 01:15:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680830127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oy29AYYgML7Ch0hXumRCRb+rrtZVQXUDb4HMadFEibw=;
	b=inDxI9ucZ7cCTgwP80CZybLS00EX/xfqa1DTfiNBByYVYHsRXuUU+lAkl1dAmscsC9Yyu/
	i25t/3iDKa40yhSjBO0iSoG5k30X0/YSZP+7MU6osIxy45+BqI9Esdo+zE6W63gMH3y9M7
	S/BnVWY+DOt2jNDZ9w9Vz7Yy7hVKC9k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-lIi9gKHuOBqBB7clS_i7ww-1; Thu, 06 Apr 2023 21:15:24 -0400
X-MC-Unique: lIi9gKHuOBqBB7clS_i7ww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 180203806737;
	Fri,  7 Apr 2023 01:15:24 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-86.pek2.redhat.com [10.72.12.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E509718EC6;
	Fri,  7 Apr 2023 01:15:17 +0000 (UTC)
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
Subject: [PATCH v2 1/3] arm64: kdump : take off the protection on crashkernel memory region
Date: Fri,  7 Apr 2023 09:15:05 +0800
Message-Id: <20230407011507.17572-2-bhe@redhat.com>
In-Reply-To: <20230407011507.17572-1-bhe@redhat.com>
References: <20230407011507.17572-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_181528_683353_7FF06713 
X-CRM114-Status: GOOD (  14.11  )
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

Problem:
=======
On arm64, block and section mapping is supported to build page tables.
However, currently it enforces to take base page mapping for the whole
linear mapping if CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled and
crashkernel kernel parameter is set. This will cause longer time of the
linear mapping process during bootup and severe performance degradation
during running time.

Root cause:
==========
On arm64, crashkernel reservation relies on knowing the upper limit of
low memory zone because it needs to reserve memory in the zone so that
devices' DMA addressing in kdump kernel can be satisfied. However, the
upper limit of low memory on arm64 is variant. And the upper limit can
only be decided late till bootmem_init() is called [1].

And we need to map the crashkernel region with base page granularity when
doing linear mapping, because kdump needs to protect the crashkernel region
via set_memory_valid(,0) after kdump kernel loading. However, arm64 doesn't
support well on splitting the built block or section mapping due to some
cpu reststriction [2]. And unfortunately, the linear mapping is done before
bootmem_init().

To resolve the above conflict on arm64, the compromise is enforcing to
take base page mapping for the entire linear mapping if crashkernel is
set, and CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabed. Hence
performance is sacrificed.

Solution:
=========
Comparing with the base page mapping for the whole linear region, it's
better to take off the protection on crashkernel memory region for the
time being because the anticipated stamping on crashkernel memory region
could only happen in a chance in one million, while the base page mapping
for the whole linear region is mitigating arm64 systems with crashkernel
set always.

[1]
https://lore.kernel.org/all/YrIIJkhKWSuAqkCx@arm.com/T/#u

[2]
https://lore.kernel.org/linux-arm-kernel/20190911182546.17094-1-nsaenzjulienne@suse.de/T/

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/include/asm/kexec.h    |  6 ------
 arch/arm64/kernel/machine_kexec.c | 20 --------------------
 2 files changed, 26 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 559bfae26715..9ac9572a3bbe 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -102,12 +102,6 @@ void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 
 int machine_kexec_post_load(struct kimage *image);
 #define machine_kexec_post_load machine_kexec_post_load
-
-void arch_kexec_protect_crashkres(void);
-#define arch_kexec_protect_crashkres arch_kexec_protect_crashkres
-
-void arch_kexec_unprotect_crashkres(void);
-#define arch_kexec_unprotect_crashkres arch_kexec_unprotect_crashkres
 #endif
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index ce3d40120f72..22da7fc1ff50 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -268,26 +268,6 @@ void machine_crash_shutdown(struct pt_regs *regs)
 	pr_info("Starting crashdump kernel...\n");
 }
 
-void arch_kexec_protect_crashkres(void)
-{
-	int i;
-
-	for (i = 0; i < kexec_crash_image->nr_segments; i++)
-		set_memory_valid(
-			__phys_to_virt(kexec_crash_image->segment[i].mem),
-			kexec_crash_image->segment[i].memsz >> PAGE_SHIFT, 0);
-}
-
-void arch_kexec_unprotect_crashkres(void)
-{
-	int i;
-
-	for (i = 0; i < kexec_crash_image->nr_segments; i++)
-		set_memory_valid(
-			__phys_to_virt(kexec_crash_image->segment[i].mem),
-			kexec_crash_image->segment[i].memsz >> PAGE_SHIFT, 1);
-}
-
 #ifdef CONFIG_HIBERNATION
 /*
  * To preserve the crash dump kernel image, the relevant memory segments
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
