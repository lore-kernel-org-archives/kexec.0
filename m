Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635D9CC6B2C
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qQ829QttMAz4SqfqepXmwJ7bGAUWe1aT3YmaqbZjyQ8=; b=ukHvGPovxj9ZYnFdPsuqLEExxW
	bvL/ZK+Ss3z4DOXsqfI2YNVlulTr9XFHOLNSSgoGJGJiQDgZwLUcT2JEvhd5s2DwOQaKDcKfc9CZT
	WbvmHOHlXHRQxKfFkGkTKI9FIt5x0goKo/qkMD/RP5ZYDkz0gG8d7RQ4agF3oJDqBju2jN+ININMh
	SlYYBxcEKbwp6rLLh5zVve2fo/opz4tx/2FcsiiH3y+17Ej9R+QTxsXmwPirI/FmLNDTJVF8nYbMV
	cB+ZU4Pe+YhUZjjVkFV4vx7E7qcMxhnAgUirraU0KcxwFilcNRpLQix1KQ6PJhrKnKcHk7DFauixw
	fmUI72mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH0by-0000000FoFk-3tei;
	Wed, 14 Oct 2026 15:09:46 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH0bx-0000000FoFA-2PFW
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 15:09:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B3E68600DA;
	Wed, 14 Oct 2026 15:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B018C1F000C4;
	Wed, 14 Oct 2026 15:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791990584;
	bh=qQ829QttMAz4SqfqepXmwJ7bGAUWe1aT3YmaqbZjyQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rdga/Kjjh9ceiXFeB07QN78vX7uRyzhQLf5blN5L3jYK+zfZ9ykiw6Fura/Qm6VwP
	 poFn9NcmhfQBr9Hvrs6PnSphkE+5S1uVUUxqORqE/TrY04TlxHfhEBrSXJJoXn4sKt
	 KKEkqwKlFUUmO10JJ4sece85eBaIV82792aTN2qDKCOzVlb2NewuknEcVV7brvx9wi
	 kV034OaT8ZYNm8lCCk3ikKZXCHIO9rNzGuqlshowaQXJGUapJ5cI2BS6FEnhR61STW
	 WRz7BsFgAx+VHNnQ7FDt2PvX+6NCJZw+Dpld5sG4znE69/JvAmrbEPIoSjGnoGl494
	 bCgA6VlZl0Tnw==
Message-ID: <sashiko-outbox-171457@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] mm/cma: reject CMA areas that overlap the
 kernel image
To: "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, baoquan.he@linux.dev, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com
Cc: kexec@lists.infradead.org
In-Reply-To: <20261014145731.3431527-3-radhey.shyam.pandey@amd.com>
References: <20261014145731.3431527-1-radhey.shyam.pandey@amd.com>
 <20261014145731.3431527-3-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 15:09:43 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] mm: integer overflow in CMA kernel overlap check bypasses prot=
ection
--

commit af398e11f427511d4d7335b0e8810e798dcdd794
Author: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

mm/cma: reject CMA areas that overlap the kernel image

This commit adds an explicit check in cma_init_reserved_mem() to ensure
that initialized CMA areas do not overlap with the kernel image. This
prevents scenarios where an overlap clears PageReserved on the kernel's
own text and data, releasing them to the page allocator.

> diff --git a/mm/cma.c b/mm/cma.c
> index 1f4d3d48a3bb9..32b799a3f5c8f 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
[ ... ]
> @@ -68,6 +70,11 @@ bool cma_has_fixed_base(const struct cma *cma)
>  	return test_bit(CMA_FIXED_BASE, &cma->flags);
>  }
> =20
> +static bool cma_overlaps_kernel_image(phys_addr_t base, phys_addr_t size)
> +{
> +	return base < __pa_symbol(_end) && __pa_symbol(_text) < base + size;

[Severity: Critical]
Can a maliciously large size cause an integer overflow here?

If a malformed huge size is passed down from an untrusted source (like a
device tree overlay), base + size could wrap around in a 32-bit phys_addr_t.
This would cause __pa_symbol(_text) < base + size to evaluate to false,
completely bypassing the kernel image protection.

> +}
> +
>  static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
>  					     unsigned int align_order)
>  {
> @@ -295,6 +302,22 @@ int __init cma_init_reserved_mem(phys_addr_t base, p=
hys_addr_t size,
>  	if (!size || !memblock_is_region_reserved(base, size))
>  		return -EINVAL;

[Severity: Critical]
Does memblock_is_region_reserved() cap the size strictly internally?

Since size is passed by value, any capping inside memblock_is_region_reserv=
ed()
or memblock_reserve() leaves the caller's uncapped size unchanged.

The unmodified huge size then continues down to cma_overlaps_kernel_image(),
leading to the overflow described above. This could bypass the check entire=
ly,
allowing subsequent processing to clear PageReserved on live kernel text pa=
ges.

> =20
> +	/*
> +	 * The area being already reserved is expected here, so an overlap with
> +	 * the kernel image cannot be told apart from the normal case by looking
> +	 * at memblock alone. Check for it explicitly: activating such an area
> +	 * clears PageReserved on the kernel's own text and data and releases
> +	 * them to the page allocator.
> +	 */
> +	if (cma_overlaps_kernel_image(base, size)) {
> +		phys_addr_t text =3D __pa_symbol(_text);
> +		phys_addr_t end =3D __pa_symbol(_end);
> +
> +		pr_err("area %s (%pa, size %pa) overlaps kernel image [%pa-%pa]\n",
> +		       name ?: "(unnamed)", &base, &size, &text, &end);
> +		return -EBUSY;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014145731.3431=
527-1-radhey.shyam.pandey@amd.com?part=3D2

