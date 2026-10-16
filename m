Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72179CCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uZkLliBTAbncT8UcYQIGgYsB3uSF1T6JCa0mfoiL0j0=; b=Qt0BHA8LAU2Ie5TcxPcYWWsCRg
	gZ3EHyMmUFK91yP1bJVPkZXWZhvewvAGbacaHdsCNa05q0SdsQkq0YexbHceP22d1PriJmJggLz0d
	LXhVMTlzhCnhlMLGRQtMEfTnBvoJavmUrfIpsXkYTf6+8OBfheyZTp996RWHgyKCC5I06RJmCtTc7
	ehXIJHTaa0IWVH7jgHFH3WqQAxO5RDhwljJH/Gu9jI3iJqFJsIxSBUPtzlAiKQd0ZwncrBeR8s2tR
	vcNaOD8b4iynIY1PKhj1Tdwe2NNA3H7XATJFOevz/e7ODyZvMYOZ+6nrZ3WMDShT0DDiSy3+0gxpH
	6BotuD4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHgzQ-00000002rhS-3nmR;
	Fri, 16 Oct 2026 12:24:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHgzP-00000002rh3-3RuK
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 12:24:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 44785601F0;
	Fri, 16 Oct 2026 12:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349811F000C5;
	Fri, 16 Oct 2026 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792153487;
	bh=uZkLliBTAbncT8UcYQIGgYsB3uSF1T6JCa0mfoiL0j0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lEhJdkTqY//IdqQvHfCohAu6GgWoge6REmtuMPjdfVSPuiVSZRgzUzvh/Pvc6khR/
	 w6GTY6IHyoCoJjVspsRpzI9nDLpZGu5rBko0rKaKJ8Ihag1O59V2uuHtbq+/0fXj3/
	 3oEhGVavuWZPA0B4HNfhzoxBgFCVLV+3xiB8YBA8F0F9gXt3mHwuvgJbfWz2nRu8PW
	 sF+NFaYgwbATIPhSdw+CKArNp6zhF6/4d+WfADZNzGDkkCjFU5NhZ720kAqkpo1B45
	 UFiLDLXO4SBGIztOmogAi5x5wa7nv5FKhBpX3SW9bPOOsHkhOfYKVoxg32fWsUVQgg
	 6GhS7qym/oyQg==
Message-ID: <sashiko-outbox-174291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/7] mm/memory-failure: efi: reserve the inherited
 poisoned-memory units
To: "Breno Leitao" <leitao@debian.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, "Oscar Salvador" <osalvador@suse.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, kas@kernel.org, kexec@lists.infradead.org, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi
 Yan" <ziy@nvidia.com>, shakeel.butt@linux.dev
Cc: linux-cxl@vger.kernel.org, rmikey@meta.com, riel@surriel.com, harry@kernel.org, kernel-team@meta.com
In-Reply-To: <20261016-hwpoison-kho-v6-6-f304255147da@debian.org>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-6-f304255147da@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:24:44 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] efi: linux_efi_poisoned_memory ABI depends on architecture word si=
ze
- [High] efi: missing PHYS_ADDR_MAX check causes physical address truncation
--

commit 458406c8bb39d60c5c6472cbc3795bf8b4bdc8e3
Author: Breno Leitao <leitao@debian.org>

mm/memory-failure: efi: reserve the inherited poisoned-memory units

This commit parses a new EFI table to inherit hardware-poisoned memory fram=
es=20
from previous kernels during kexec. It prevents the memory allocator from u=
sing=20
these corrupt physical pages.

> diff --git a/drivers/firmware/efi/poison.c b/drivers/firmware/efi/poison.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/firmware/efi/poison.c
> @@ -0,0 +1,174 @@
[ ... ]
> +static bool __init
> +efi_poison_geometry_valid(const struct linux_efi_poisoned_memory *pm)
> +{
> +	const u64 max_end =3D PHYS_ADDR_MAX - PAGE_SIZE;
> +	u64 nbits, span, top, end, len;
> +
> +	/* Whole words, and a bit count that can be taken without wrapping. */
> +	if (!pm->size || !IS_ALIGNED(pm->size, sizeof(unsigned long)) ||
> +	    check_mul_overflow(pm->size, (u64)BITS_PER_BYTE, &nbits))
> +		return false;

[Severity: High]
Does this architecture-dependent validation cause valid tables from mismatc=
hed
architectures to be rejected during kexec?=20

If a 32-bit kernel populates the linux_efi_poisoned_memory table with a size
that is a multiple of 4, a 64-bit kexec kernel will evaluate
IS_ALIGNED(pm->size, sizeof(unsigned long)) where sizeof(unsigned long) is =
8.
This check would fail, and the table would be erroneously discarded.

Additionally, if the table structure uses unsigned long for the bitmap arra=
y,
reading a 32-bit written array as 64-bit words can shift bit indices on
big-endian systems. Could fixed-width types like u64 be used instead to
ensure a stable cross-kernel ABI?

> +
> +	/* And a footprint that can be page aligned without wrapping either. */
> +	len =3D sizeof(*pm) + pm->size;
> +	if (check_add_overflow(efi.poisoned_memory, len, &end) ||
> +	    end > max_end)
> +		return false;
> +
> +	if (pm->unit_size < PAGE_SIZE || !is_power_of_2(pm->unit_size))
> +		return false;
> +
> +	/* Every unit has to lie inside the address space. */
> +	if (check_mul_overflow(nbits, (u64)pm->unit_size, &span) ||
> +	    check_add_overflow(pm->phys_base, span, &top))
> +		return false;

[Severity: High]
Should this validation also check if top exceeds PHYS_ADDR_MAX?

While this calculates the top address in 64-bit space, without an explicit
bounds check, a table specifying a phys_base above 4GB could pass validation
on a 32-bit architecture without PAE.

> +
> +	return IS_ALIGNED(pm->phys_base, pm->unit_size);
> +}
[ ... ]
> +static void __init
> +efi_poison_reserve_units(phys_addr_t table,
> +			 const struct linux_efi_poisoned_memory *hdr)
> +{
[ ... ]
> +		for_each_set_bit(bit, map, nbits) {
> +			u64 unit =3D off * BITS_PER_BYTE + bit;
> +			phys_addr_t base =3D hdr->phys_base + unit * unit_size;

[Severity: High]
Can this lead to physical address truncation on 32-bit systems?

Because hdr->phys_base + unit * unit_size evaluates as a 64-bit integer,
assigning it to phys_addr_t (which is 32 bits on 32-bit systems without PAE)
will silently truncate the upper 32 bits. This could cause valid low memory
to be erroneously marked as poisoned and reserved, potentially leading to
boot failures.

> +			bool overlap;
> +
> +			overlap =3D memblock_is_region_reserved(base, unit_size);
> +			if (memblock_reserve_hwpoison(base, unit_size)) {
> +				nr_skipped++;
> +			} else {
> +				nr_units++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-hwpoison-k=
ho-v6-0-f304255147da@debian.org?part=3D6

