Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F12CD6E50
	for <kexec@archiver.kernel.org>; Fri, 29 May 2026 15:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+neS3Llvyfy3P4tauMZpeOCQxOmOPM92PXLEWzDVW0=; b=FQpUFQb5zpqJiFUTaxeNACuFo5
	6TBtg0lw4oUgNaypoPPUc9aBIB7rj0hZQq1nQqHsWweaTQnLWy/xzJWLwYwPgDIvXGzu3AgAGWQfP
	EOffqpzP7aTgOvkh3diAcqnEKfzimIyt8WzPTX4xyHx5C+z3m+3ZhL4U2VLXcK0ikDRDvgi6Q9Knz
	AxxPrvvbH+TL3f6MyUBgiQ2L0wgOsdupdpiWD76eRzJbHXnzbMoyOL1E+sWxot68pEVuW8VRoV9gJ
	cWW7pttc+8Y+G2CgboucTpx9U98Nb+e+RDXneApL5o0LW0z4L4DEjQntJCpV54eFLRbmh5Mtga3y9
	K/Edr3vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSypQ-00000007dlW-09Ai;
	Fri, 29 May 2026 15:08:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSypP-00000007dlH-261g;
	Fri, 29 May 2026 15:08:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AB72F60546;
	Fri, 29 May 2026 15:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879E21F00893;
	Fri, 29 May 2026 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780067330;
	bh=Z+neS3Llvyfy3P4tauMZpeOCQxOmOPM92PXLEWzDVW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lR2pXawpPwU7zOlNmNYRWyqr6Rs8IREQyqXMAgYbEUQnkqvx5JDHA1xCz0bi7n4E5
	 FvbfKcblWQTnP5e/D/SsEZl0f8k2dCUK+A6vkCoMuv0DrYH6JlkQ8mzfqdsO2rb3yy
	 Ii03QBrvON1RZGmF0snsD1x+dVkZ74002GDXbRNsK3428w0kwgNIABDZygdD2YlsyK
	 Et+xwQ2V5wuhOItthhp2u/f1mFJ/EAX7OrQ1vi30I0PkzggRH6bRUz60RJJwtEplpE
	 buDUncSPwMsci9bBxMrD7aHU3hDo4xpDCHbrh5H8bQOLqgyOjvPiHe3IFaYQXPN3hU
	 NRKVFqyew03qQ==
Date: Fri, 29 May 2026 16:08:41 +0100
From: Will Deacon <will@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	catalin.marinas@arm.com, chenhuacai@kernel.org, kernel@xen0n.name,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, m.szyprowski@samsung.com,
	robin.murphy@arm.com, quic_obabatun@quicinc.com
Subject: Re: [PATCH v3 09/11] arm64: kdump: exclude non-dumpable reserved
 memory regions from vmcore
Message-ID: <ahmr-UjoApj2j5JS@willie-the-truck>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <20260527032917.3385849-10-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527032917.3385849-10-chenwandun1@gmail.com>
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

On Wed, May 27, 2026 at 11:29:15AM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> Reserved memory regions are excluded from vmcore by default unless
> marked dumpable. Honor the dumpable flag to filter out device firmware
> regions (e.g., GPU, DSP, modem) reserved via device tree, since they
> typically contain data not useful for kernel crash analysis and can
> significantly increase vmcore size.
> 
> Use of_reserved_mem_kdump_exclude() to perform the exclusion, and
> pre-size the crash_mem array via of_reserved_mem_kdump_nr_ranges().
> 
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index e31fabed378a..1d65320c6ba4 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -17,6 +17,7 @@
>  #include <linux/memblock.h>
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> @@ -51,6 +52,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  	nr_ranges = 2; /* for exclusion of crashkernel region */
>  	for_each_mem_range(i, &start, &end)
>  		nr_ranges++;
> +	nr_ranges += of_reserved_mem_kdump_nr_ranges();
>  
>  	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
>  	if (!cmem)
> @@ -75,6 +77,10 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  			goto out;
>  	}
>  
> +	ret = of_reserved_mem_kdump_exclude(cmem);
> +	if (ret)
> +		goto out;
> +
>  	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);

This looks fine to me:

Acked-by: Will Deacon <will@kernel.org>

Although I do wonder whether there's scope to consolidate some of the
arch code here. Now that you have a helper for reserved memory, perhaps
the core code could also handle the crashkernel reservation itself as
well? If the arch code passed in its number of memory regions, the
core code could take care of (a) allocating the crash_mem ranges array
(b) excluding the crashkernel and (c) excluding the reserved regions
(the part you have here).

Obviously that would be follow-up work, but the fact that you're having
to apply basically the same diff to three architectures is a bit of a
giveaway that this could benefit from some wider cleanup.

Will

