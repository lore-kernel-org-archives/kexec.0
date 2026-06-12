Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC70CD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8pFVODsK8nCijCDNDLMgxkikkdJrQAhHnV+T+5T5zWc=; b=0kzWLHxB0Vqgp8xspNTZEYdarw
	2dV2Mea0KLskZO7M+4BA4fiWOG9B5dA5GTiWBF0KEM/eXUL6qV7fAa3xoEwlYBJOEFoCo2KvK5+AJ
	84EZ7QwWFlMJnxO5R7fAG7v845ZitV/a4Kv69IkY3qtccUQWH6IbizxpM2PJZnaSUGCDFr5nedKSl
	aMRlutoYzJ5BEucRUKw1cemd5oqHN0D6T7tt7kWaaLHZvxI6iLsAl20Q/k4SOeAFiKTzCXLGsnbuI
	ygF878FqMkiVh9xzrYKr0ifLC+DEB1ZuUpvkLRmsokmu2Qik/9pWCqEXP/+nexuyh4jKNsmGAPXdL
	3juWDsGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY35z-0000000B652-2bPW;
	Fri, 12 Jun 2026 14:42:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY35y-0000000B64Z-1QY7;
	Fri, 12 Jun 2026 14:42:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C1FAF6008A;
	Fri, 12 Jun 2026 14:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500E61F00A3A;
	Fri, 12 Jun 2026 14:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275373;
	bh=8pFVODsK8nCijCDNDLMgxkikkdJrQAhHnV+T+5T5zWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ym/KchFKUOtSqs03zw7p0bBmd751BWdKhFtBdtk19PaYskXhLxCiU2wKH8lvRvWHo
	 gawVbS1RIGNl4PlNWJihz03okzNq9/cp6Ww5XKra5xbbcZYHNQxGCJ0q49orkQAj4O
	 JuLqTbP3nCbWkFMcgWB1ax5EpO+Yvbszkg2J7nRwE6cp4YrWjLJE4Uw3zRwtSxj2zQ
	 Mky2klprkntTIwKWcITUf5mHQeauSd798W7i3fnaExQYmYxPtva2ty6QfcfSaMh22m
	 cuE8Pq1IJy/flcs5MBzQsONPlcb+IxnY5oTx1zADRCEiFV2M8MzGlLx8BMD5waisk/
	 BKTkWBakHuGjw==
Date: Fri, 12 Jun 2026 09:42:52 -0500
From: Rob Herring <robh@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, m.szyprowski@samsung.com,
	robin.murphy@arm.com, quic_obabatun@quicinc.com
Subject: Re: [PATCH v3 00/11] kdump: reduce vmcore size and capture time
Message-ID: <20260612144252.GB974326-robh@kernel.org>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
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

On Wed, May 27, 2026 at 11:29:06AM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> On SoCs that carve out large firmware-owned reserved memory (GPU
> firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
> those carveouts as part of system RAM even though their contents are
> firmware state that is not useful for kernel crash analysis.
> 
> This series introduces an opt-in 'dumpable' flag [1] on struct
> reserved_mem and uses it to filter the elfcorehdr PT_LOAD ranges on
> DT-based architectures (arm64, riscv, loongarch). By default reserved
> regions are treated as non-dumpable; CMA regions are explicitly opted
> in because their pages are returned to the buddy allocator and may
> carry key crash-analysis data.
> 
> The series is organized as follows:
> Patches 1-3: Pre-existing fixes and a small prep change.
> Patches 4-5: Restructure to allow appending /memreserve/ entries.
> Patches 6-7: Add a dumpable flag and append /memreserve/ entries.
> Patch 8: Add generic kdump helpers.
> Patches 9-11: Wire the helpers into arm64, riscv and loongarch kdump
>               elfcorehdr preparation.
> 
> v2 --> v3:
> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.[2]
> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
> 3. Add some prepare patches.
> 
> v1 --> v2:
> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
>    feedback [1], v2 drop that property and exclude reserve memory
>    by default.
> 2. Split some prepared patches from the original patches.
> 3. Address coding-style comments on patch 5 from Rob.
> 
> [1] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
> [2] https://sashiko.dev/#/patchset/20260520091844.592753-1-chenwandun%40lixiang.com?part=4
> 
> Wandun Chen (11):
>   of: reserved_mem: handle NULL name in of_reserved_mem_lookup()

>   of: reserved_mem: zero total_reserved_mem_cnt if no valid
>     /reserved-memory entry

I applied these 2 for 7.2.

Rob

