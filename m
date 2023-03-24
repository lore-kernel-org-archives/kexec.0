Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53729C6FD20
	for <kexec@archiver.kernel.org>; Fri, 24 Mar 2023 13:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZzUOFsZqX9x91RKoQh88rnN9fwucXGjkGqlLTcsj8LE=; b=ZT+itl51IPro3w
	xjXrziMZInaOpEu7rtXnI9lKC1rRamrA8g96acbMdS+mUuZ1Qv6cvPMeHwsj9ZcHr1EdY08xS/TKY
	QnZtwI7UyRSxZ9hUq6mqiOduyReNMAfXUc26wFmKNMdmeJEM5Sbet8Q/Bty2dClkKLjycM+ibylux
	nT8BP23RcSYATED2gmeA5LZ1RBniVBL8axNOvrWv03q1cRcnwJCYAz5PPByHnq6BLjmVKIGXVkD0z
	mtdKoOvNjhD0UMr/H0/BxvjkkgZy1jI+IzBm3seODiQc6HEsOnw/3ttRgTjzCGQX4GA3KK2aVkMfY
	lnn2A3Qt3hbjuwPLtWPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfhJs-004Skb-2b;
	Fri, 24 Mar 2023 13:19:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfhJm-004Sjh-33
	for kexec@lists.infradead.org;
	Fri, 24 Mar 2023 13:18:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679663931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eq/LWUPaBWXPVPONNt+ItToEb0I4pgNnBO6KTxueUWc=;
	b=YsneP1IWjC0viemAdaxbNJLySTHBR67uEaM9pMhinw2w3uoMP1ClR7Ol8592Pjc1kk1Brw
	tLoLxviAyusj6MSBJjQFKDGyqqPN7tcM6q/70VY5A5LMABzt0xENHsJlTotglb4ey4lWE+
	c9pj0O78ebAQ25KJByoS87gmHPD/QUE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-k6uFfsx5MiGYVH1ZdcxWyg-1; Fri, 24 Mar 2023 09:18:48 -0400
X-MC-Unique: k6uFfsx5MiGYVH1ZdcxWyg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08680101A54F;
	Fri, 24 Mar 2023 13:18:48 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-55.pek2.redhat.com [10.72.12.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BD527492B0A;
	Fri, 24 Mar 2023 13:18:41 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	horms@kernel.org,
	thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com,
	will@kernel.org,
	kexec@lists.infradead.org,
	ardb@kernel.org,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] arm64: kdump : take off the protection on crashkernel memory region
Date: Fri, 24 Mar 2023 21:18:35 +0800
Message-Id: <20230324131838.409996-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_061855_076230_5129EB15 
X-CRM114-Status: GOOD (  13.27  )
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
Comparing with the always encountered base page mapping for the whole
linear region, it's better to take off the protection on crashkernel memory
region for now because the protection can only happen in a chance in one
million, while the base page mapping for the whole linear mapping is
always mitigating arm64 systems with crashkernel set.

This can let distros have chance to back port this patchset to fix the
performance issue caused by the base page mapping in the whole linear
region.

Extra words
===========
I personally expect that  we can add these back in the near future
when arm64_dma_phys_limit is fixed, e.g Raspberry Pi enlarges the device
addressing limit to 32bit; or Arm64 can support splitting built block or
section mapping. Like this, the code is the simplest and clearest.

Or as Catalin suggested, for below 4 cases we currently defer to handle
in bootme_init(), we can try to handle case 3) in advance so that memory
above 4G can avoid base page mapping wholly. This will complicate the
already complex code, let's see how it looks if people interested post patch.

crashkernel=size
1)first attempt:  low memory under arm64_dma_phys_limit
2)fallback:       finding memory above 4G

crashkernel=size,high
3)first attempt:  finding memory above 4G
4)fallback:       low memory under arm64_dma_phys_limit


[1]
https://lore.kernel.org/all/YrIIJkhKWSuAqkCx@arm.com/T/#u

[2]
https://lore.kernel.org/linux-arm-kernel/20190911182546.17094-1-nsaenzjulienne@suse.de/T/

Baoquan He (3):
  arm64: kdump : take off the protection on crashkernel memory region
  arm64: kdump: do not map crashkernel region specifically
  arm64: kdump: defer the crashkernel reservation for platforms with no
    DMA memory zones

 arch/arm64/include/asm/kexec.h    |  6 -----
 arch/arm64/include/asm/memory.h   |  5 ----
 arch/arm64/kernel/machine_kexec.c | 20 --------------
 arch/arm64/mm/init.c              |  6 +----
 arch/arm64/mm/mmu.c               | 43 -------------------------------
 5 files changed, 1 insertion(+), 79 deletions(-)

-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
