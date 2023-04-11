Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0E1C7619A
	for <kexec@archiver.kernel.org>; Tue, 11 Apr 2023 18:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qo1GCxUr1wdRYJ5XLddkNKN0cBoPBeokCwHJyMKCTbw=; b=aSZQENDpnSGMms
	IgOeTL9pDTlVjVQtdpJ0BUGVrRxKCInttCGJzLE99e/XXXBokt3Fn89u47H2Cf3vZrJM6ma6UAS2r
	O7JTPYhGKWAMykRqiAS5FA+mTirI2EdOAG1ERWnTpCkLq4IjoEEil+62vZ+qpgJtyr4Om4OyIQ28Y
	eINHLBrDNX4/xDS8tFHCxXABX/EQFrd9xlM5KDVyvM7vCrYICuk28q/R4VHLkpPrW7g2+YrzWqT++
	US3ghuFohtOGDG0ihXYJ7kSb4c6HgVzVFKfxtocyiquPpEta/5MwkC2QbHBuPmea64qyI5Uqe9raU
	i0Tdiu/NHWfPOxIdpr0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmIs6-000oZm-39;
	Tue, 11 Apr 2023 18:37:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmIs2-000oYU-2A;
	Tue, 11 Apr 2023 18:37:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 33A6262ADD;
	Tue, 11 Apr 2023 18:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C93CC4339B;
	Tue, 11 Apr 2023 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681238253;
	bh=cuJkj0gXqgGwRRDX0gNvDxHkCZkNFXT4t3hB/stfPCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1G6irrGVfNL90UxP1t0WrtEGZbgdV+tWzqng1wAWqO0r59xZNWHtnkgg539fvGJO
	 AEmKO/XJozgjgp2q+A1QEl2Fogn3TIDKbG4tXz2isL3QUqAmJ9ToB8WgVQj4bjAHMG
	 3u1tRSXi1eJ1rIKkWJPte0lE3qR6UYdqLA3Mg93nP2L7MKuya9F65woEpAgUroQad0
	 4FbSH/5mNEUjtB0t2+MiEz8/rrD/MoHzOeJESDEjIIX1H6CX5oroADhwBdRgs5cBsO
	 o5nJYMoaRX4qLVzr7WpX+cZNvQTuzbxZmulZvuy/1Ay6tInt8IDA8rMmMFy636Lcrf
	 nq9wDX5YH3Sdw==
From: Will Deacon <will@kernel.org>
To: Baoquan He <bhe@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	thunder.leizhen@huawei.com,
	horms@kernel.org,
	John.p.donnelly@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	ardb@kernel.org,
	rppt@kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64: kdump : take off the protection on crashkernel memory region
Date: Tue, 11 Apr 2023 19:37:24 +0100
Message-Id: <168123748697.3041682.15156562269597498270.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230407011507.17572-1-bhe@redhat.com>
References: <20230407011507.17572-1-bhe@redhat.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_113734_750873_E22115C4 
X-CRM114-Status: GOOD (  10.87  )
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

On Fri, 7 Apr 2023 09:15:04 +0800, Baoquan He wrote:
> Problem:
> =======
> On arm64, block and section mapping is supported to build page tables.
> However, currently it enforces to take base page mapping for the whole
> linear mapping if CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled and
> crashkernel kernel parameter is set. This will cause longer time of the
> linear mapping process during bootup and severe performance degradation
> during running time.
> 
> [...]

Applied to arm64 (for-next/kdump), thanks!

[1/3] arm64: kdump : take off the protection on crashkernel memory region
      https://git.kernel.org/arm64/c/0d124e96051b
[2/3] arm64: kdump: do not map crashkernel region specifically
      https://git.kernel.org/arm64/c/04a2a7af3d97
[3/3] arm64: kdump: defer the crashkernel reservation for platforms with no DMA memory zones
      https://git.kernel.org/arm64/c/504cae453f82

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
