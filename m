Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD20606A330
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cHhw6D5v;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b47bOC/3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=atDiQ1jLywCaP3AyVEImB+gZltQy0V8BagrbxL0rfyY=; b=cHhw6D5vSRVC2cDRaoYRIO09mC
	7lH8o7PFYMfsDeAkaN+ZUaArDj13xv9y1epB/kvM0aFgUH677pGjITur8+HZ6cUgE5m7SR6xCK2y0
	p4UuCaUBCuZ28jaLyx3onP+7pQQ/oBRh/wetRH6sfSZA22z+zIbFIvxAYT5VS8q/KVAkO2dGyzSpR
	SS682tNKTfajS+vQoCGuYiB1HCsRldBWDgCzAFNX0ae9o3qxG6q8GAJDiTRDQwkVA3X34MUDqWSfN
	W926gxODGk6SigPeklBbTOqAZfg059qa0pt3wNEoGUqvGGc/p3rqE+GAUhqvfGNHM73130wH8sKBN
	727oQxEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOds1-00000005z6X-1KXo;
	Wed, 04 Nov 2026 16:29:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOds0-00000005z4x-02dU
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:29:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BDA4D43B36;
	Wed,  4 Nov 2026 16:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E471F000C1;
	Wed,  4 Nov 2026 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809791;
	bh=atDiQ1jLywCaP3AyVEImB+gZltQy0V8BagrbxL0rfyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b47bOC/3A0RxnUdzrGef+aXOt5L92xLNPUSE5A24szrut0A3kwfnv5GWFo0Rmw85F
	 5Tdc/bfgkA1gTlKdM81tunrILY6eokjbGK+/nznxio0+VmOHSS6yWR/K4pch4WGfao
	 X2DC1SLRl6EPej/gADIMREih6WMk3VAUk1SsSnmcGdsSUZUeYeijaW8I5LxE64siT8
	 WKftT+EeRQuUm7+D6LB06kaL/XBI+8Rm8ri7O6/5letBBW2NOtTNrGUsp40RnchhhW
	 pjkd+4ixoPoxzTj4L9EZ3vouC5W4EmnsmzbuEWe1yrwmAZZnqWDTtJ310ri2gkvA1J
	 g0SZpdQQQjhYg==
Message-ID: <sashiko-outbox-197614@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] mm/cma: reject CMA areas that overlap the kernel
 image
To: "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>, robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, m.szyprowski@samsung.com, robin.murphy@arm.com, baoquan.he@linux.dev, pasha.tatashin@soleen.com, pratyush@kernel.org
Cc: devicetree@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, conor+dt@kernel.org
In-Reply-To: <20261103162429.2053989-4-radhey.shyam.pandey@amd.com>
References: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
 <20261103162429.2053989-4-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:29:50 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm/cma: __pa_symbol(_text) triggers BUG() on arm32 DEBUG_VIRTUAL
--

commit efca63a89d010b4bf63ea1571c8931374f2ec14d
Author: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

mm/cma: reject CMA areas that overlap the kernel image

This commit updates cma_init_reserved_mem() to reject CMA regions that
overlap the kernel image range [_text, _end) so that cma_activate_area()
cannot free kernel image pages into MIGRATE_CMA.

> diff --git a/mm/cma.c b/mm/cma.c
> index 9c53b2b70dc8f..3231a53161cda 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -31,6 +31,8 @@
>  #include <linux/kmemleak.h>
>  #include <trace/events/cma.h>
> =20
> +#include <asm/sections.h>
> +
>  #include "internal.h"
>  #include "cma.h"
>  #include "mm_init.h"
> @@ -68,6 +70,16 @@ bool cma_has_dynamic_base(const struct cma *cma)
>  	return test_bit(CMA_DYNAMIC_BASE, &cma->flags);
>  }
> =20
> +static bool cma_overlaps_kernel_image(phys_addr_t base, phys_addr_t size)
> +{
> +	phys_addr_t end;
> +
> +	if (check_add_overflow(base, size, &end))
> +		return true;
> +
> +	return base < __pa_symbol(_end) && __pa_symbol(_text) < end;
> +}
> +
>  static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
>  					     unsigned int align_order)
>  {
> @@ -295,6 +307,15 @@ int __init cma_init_reserved_mem(phys_addr_t base, p=
hys_addr_t size,
>  	if (!size || !memblock_is_region_reserved(base, size))
>  		return -EINVAL;
> =20
> +	if (cma_overlaps_kernel_image(base, size)) {
> +		phys_addr_t text =3D __pa_symbol(_text);
> +		phys_addr_t end =3D __pa_symbol(_end);
> +
> +		pr_err("area %s (%pa, size %pa) overlaps kernel image [%pa-%pa]\n",
> +		       name ?: "(unnamed)", &base, &size, &text, &end);
> +		return -EBUSY;
> +	}

[Severity: High]
Is __pa_symbol(_text) safe to call in architecture-independent CMA code?

In include/asm-generic/sections.h, _text is noted as architecture-specific:

    * _text, _data: architecture specific, don't use them in arch-independe=
nt code

On 32-bit ARM, arch/arm/kernel/vmlinux.lds.S places _text at the start of
.head.text before _stext:

    .head.text : {
        _text =3D .;
        HEAD_TEXT
    }

while arch/arm/include/asm/memory.h defines KERNEL_START starting at _stext
(or _sdata on CONFIG_XIP_KERNEL):

    #ifdef CONFIG_XIP_KERNEL
    #define KERNEL_START		_sdata
    #else
    #define KERNEL_START		_stext
    #endif
    #define KERNEL_END		_end

When CONFIG_DEBUG_VIRTUAL=3Dy is enabled on 32-bit ARM, __pa_symbol(_text)
calls __phys_addr_symbol() in arch/arm/mm/physaddr.c:

    phys_addr_t __phys_addr_symbol(unsigned long x)
    {
        /* This is bounds checking against the kernel image only.
         * __pa_symbol should only be used on kernel symbol addresses.
         */
        VIRTUAL_BUG_ON(x < (unsigned long)KERNEL_START ||
                       x > (unsigned long)KERNEL_END);
        return __pa_symbol_nodebug(x);
    }

Because _text is below KERNEL_START on 32-bit ARM, won't calling
cma_init_reserved_mem() -> cma_overlaps_kernel_image() with
base < __pa_symbol(_end) trigger VIRTUAL_BUG_ON() during early boot?

In addition, on 32-bit ARM with CONFIG_XIP_KERNEL=3Dy (where _text is linked
in ROM below PAGE_OFFSET while only [_sdata, _end) is in RAM) and on sparc64
(where [_text, _end) is linked at KERNBASE rather than in the PAGE_OFFSET
linear map), won't __pa_symbol(_text) also compute bogus physical addresses
for the kernel image?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103162429.2053=
989-1-radhey.shyam.pandey@amd.com?part=3D3

