Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAC9C88E67
	for <kexec@archiver.kernel.org>; Mon, 14 Sep 2026 05:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o779dzepK0mFhzpZscdSpSvYUsF1kQ6qSiTkadkPzf4=; b=bn9BXlcgPvMtRVYrf5gxJfVV0D
	AK32gRlSUWMMonNkhU+aa/ax3lzY1iXG3EUp4U9SMtxg546GlpJZHNeFqhxNftjDdG0eSsCy02Hi2
	+6+II/1pE8td+RWCwxNsf7p+NdAbSTQX8x+YMHlWnT4mmn3ZjlIMYC9MsjS3uVkLC60o4wvZzo+8z
	MRxBlPnNogVXCrQKvIaGiEhi7hIcbo/Ljag8mRlvHcabwUWul4toPSStdg1+yPF+tWbg1YL50VyRI
	LiNip7ypz+Wb1CvqwxwlNoKQcyheMWKkhneWz9QaKC4p24X2Zv2cM3OR4fzLqcLxqyvdRt+PSoGT1
	1gRIH1Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5z7E-00000002MUe-32Cw;
	Mon, 14 Sep 2026 05:20:28 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5z7E-00000002MUN-0ltm;
	Mon, 14 Sep 2026 05:20:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 140CD40278;
	Mon, 14 Sep 2026 05:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998861F000FF;
	Mon, 14 Sep 2026 05:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789363226;
	bh=o779dzepK0mFhzpZscdSpSvYUsF1kQ6qSiTkadkPzf4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=CkTExBz8pPEMBf1jk73HqRy9cRVhv5/C+/iPCXbOYp6XW7Lzx+sQ1dPL4vfhzGUKD
	 1Qo4YLuCVLvhPKTxzUqjNbUy1Uvh7gG1I3nHUUqHzs/WEJuNkr9qBqahooT/6T5ZVm
	 oR6CnuJc3DGdo2E3oDlVtXriiCz3rzEwiOys5VH0cgx+ZEDK5FyJNz90827TMmdf6G
	 W2CcXEXQKcYkcl5oqdBHkuIsqpx+QgJgJl5qBheg0r2tbsTh9PXCq9NF/SX2bSEv/+
	 2xV2YnJfUQF8bV7GrpUBqRvCECLrzr3MeGPvYWJKa4h381dPopjrSfvVE5ZktcPrKV
	 K+Ef5ba1feaow==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 01/10] mm: memblock: add missing HugeTLB flag name
From: Mike Rapoport <rppt@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org, 
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
 robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, 
 baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, 
 pratyush@kernel.org, m.szyprowski@samsung.com, mark.rutland@arm.com, 
 kernel@xen0n.name, alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev, 
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 kexec@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev
In-Reply-To: <20260902073116.802752-2-chenwandun1@gmail.com>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-2-chenwandun1@gmail.com>
Date: Mon, 14 Sep 2026 08:20:16 +0300
Message-Id: <178936321614.3691424.10386784926753862087.b4-review@b4>
X-Mailer: b4 0.17-dev
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

Hi,

> Commit 7d163a75f821 ("memblock: make HugeTLB bootmem allocation work
> with KHO") added MEMBLOCK_RSRV_HUGETLB but did not add the corresponding
> entry to flagname[]. As a result, memblock debugfs cannot report the
> flag by name.
> 
> Add the missing RSV_HUGETLB entry.
> 
> Fixes: 7d163a75f821 ("memblock: make HugeTLB bootmem allocation work with KHO")
> Signed-off-by: Meijing Zhao <zhaomeijing@lixiang.com>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Link: https://lore.kernel.org/lkml/20260821020910.3428585-2-zhaomeijing100@gmail.com/

Can you please send this as a separate patch, I'll pick it to the
memblock tree.

-- 
Sincerely yours,
Mike.


