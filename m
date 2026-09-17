Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD19AC982D0
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 21:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5NhZ/y4a+dkUa7WaLlbHkeAQBTwZUNqbVt6sm8GoTkU=; b=5ClNMtK7GISFj9ojJMyZqAqkEf
	anonrnGl+I/7kUaTSqgcUnhjbLeyynFTdYP2ggTdgZfAU0UalWtHwFg8+iwCgrNYf9NKpX0sQFruJ
	wtDjxJgJdwQSQYxsIz1gPY0b9ZUrJlho7zV0IjNqmhBJFHZ4MEtDY9nkZYks+8PJfSKgFqHF5InQ+
	AnfmxxczDDNCh74IPQ9VaNr5amBtkcY/bWiRQUYO/vFfFGsLoomKY/JC2PQX0XCkaFxqg96s4LhLr
	kBXgvyQIJLcohxbjJt2hedzwPMKDYV6mYSsgxWrwLJHc7DK9VJLn9c555rQxK9FBqpT+VjkTIlbo7
	h1gXYyNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7K5e-0000000CbwV-2Hi8;
	Thu, 17 Sep 2026 21:56:22 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7K5c-0000000CbwG-2FQX;
	Thu, 17 Sep 2026 21:56:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E768B43AB3;
	Thu, 17 Sep 2026 21:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FA41F000FF;
	Thu, 17 Sep 2026 21:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789682179;
	bh=5NhZ/y4a+dkUa7WaLlbHkeAQBTwZUNqbVt6sm8GoTkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L1Mdag9kmnPe+L2tPYHLcz67jASLAJHRTXbLRL6FwDWypq3Me5VmVOJNpahpirJUr
	 gEsrTsb4nt+eg05Kke9kTilWmPAyVnbXAZ2QqEIckXNOxU8Nc03uHomC6TOH25W/2K
	 z5l+kA7XR1hsKOVXM9nOrECRGVVSTOZ0fYqJJ4d/qsSPlA92WfCU5Jhz5VgBRKk640
	 b+F2H3fiHFKhDUNxqU1GLBt2Ks6ayctuMUVHHspuUBp72wI7bAIxxIjtCNIMAhHGB1
	 kVbr6OldOAOOfF9euNAChU/YRakT3Vou1QLZTXALxAI02xOX2wLGmDaBhTwt/LCZFD
	 fiZ6QpTX8Oq4A==
Date: Thu, 17 Sep 2026 16:56:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: chenhuacai@kernel.org, linux-kernel@vger.kernel.org, rppt@kernel.org,
	m.szyprowski@samsung.com, x86@kernel.org, bp@alien8.de,
	iommu@lists.linux.dev, saravanak@kernel.org, pratyush@kernel.org,
	robin.murphy@arm.com, loongarch@lists.linux.dev,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, will@kernel.org,
	akpm@linux-foundation.org, pasha.tatashin@soleen.com,
	mingo@redhat.com, pjw@kernel.org, kexec@lists.infradead.org,
	hpa@zytor.com, catalin.marinas@arm.com, devicetree@vger.kernel.org,
	baoquan.he@linux.dev, ruirui.yang@linux.dev, mark.rutland@arm.com,
	kernel@xen0n.name, linux-arm-kernel@lists.infradead.org,
	alex@ghiti.fr, linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	tglx@kernel.org, dave.hansen@linux.intel.com
Subject: Re: [PATCH v6 07/10] of: reserved_mem: add dumpable flag to opt-in
 vmcore
Message-ID: <178968217748.3989713.7328577485527762154.robh@kernel.org>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-8-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902073116.802752-8-chenwandun1@gmail.com>
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


On Wed, 02 Sep 2026 15:31:13 +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> Add a 'dumpable' flag to struct reserved_mem to decide whether a
> reserved area should be included in the kdump vmcore. Non-dumpable
> regions are later marked MEMBLOCK_NODUMP;the filtering itself happens
> in memblock, keeping the arch kdump code independent of the DT API.
> 
> Most reserved regions are owned by devices and do not contain data
> useful for kernel crash analysis, so dumpable default to false.
> Reusable CMA regions are different: their pages are handed back to the
> buddy allocator and may contain key data for crash analysis, so set
> dumpable to true in rmem_cma_setup().
> 
> The dumpable flag is also used to check /memreserve/ entries for overlap
> with other dumpable regions.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  include/linux/of_reserved_mem.h | 1 +
>  kernel/dma/contiguous.c         | 1 +
>  2 files changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


