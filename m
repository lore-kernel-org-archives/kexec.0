Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607D5C79FAD
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bEJmZIALLcjQXIB+g3fXQRl6DWuBiippwKn6sn+DjEU=; b=aXSymw4YjQ8f4urv7Zc/sQqE5d
	ZK+n762cgpvNQzmDVzKBU0EBKiLwhu3cJrDB1rYPnpZF1VDw9m8n/p94AUz0khg7SroTVG1p0OTCv
	ziDS54rNzCg3BdAeAWS3IFKud5Cf67LJ4irofgGhvvUYj5YJC/g79FMbbWFcLXEKYFER1z5xrFaz3
	ChfNTwRYzqz6tbtsST6jB7vcOAjJQSfoJGprXPJbVIZGBsrBDS1Iq4q2Z3NwGn2oK4wuJBnqAG+xE
	sNpLtynNAbvtexFlpylGPoe/Cq8ycYxhjU7WUzE1Vw4y7sinFXV8QKBegWPFGHB1J4FBKs/zOTbFp
	wgUU5boA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4IB2-0000000BljP-0IQM;
	Wed, 09 Sep 2026 13:17:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4IB0-0000000Blj9-0MyG
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 13:17:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2D7D160211;
	Wed,  9 Sep 2026 13:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1F01F00A3A;
	Wed,  9 Sep 2026 13:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788959840;
	bh=bEJmZIALLcjQXIB+g3fXQRl6DWuBiippwKn6sn+DjEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R3LmLYbgntYK+I4UH4uaxCnCYpQyqZDM2PKlOOWsUfSoMifDN2Xn9LoMlaHh2l+Xn
	 CI4hf7aXtDaTdIs12+sG0yKD00WsPfl11cqaXLv4DoWFow+Wz/n8ybKaLvLXMfHgHL
	 /tnzmxAmYi4c+8FHMgbNhwF1Php8YRjwVCh+IOp72LY3QyAnTG9OEQOMhudzopLfES
	 vWoR0svfqF6zkAUEhH4hCx6zp/tOiAq/wpuyXfghP7qhI/xJZmPhJVm751wxtY7E83
	 8/4XUtkwIB42i1cCOjlyIBM3Lxa5Nc/V5CXWYi/703OAiVam5yVYcdM6w11KL0nZmW
	 BIBg6RLrYfjhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] mm/memory-failure: efi: answer whether a range
 is poisoned
To: "H. Peter Anvin" <hpa@zytor.com>, "Borislav Petkov" <bp@alien8.de>, "Michal
 Hocko" <mhocko@suse.com>, "Zi Yan" <ziy@nvidia.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Breno
 Leitao" <leitao@debian.org>, "David Hildenbrand" <david@kernel.org>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, "Liam R. Howlett" <liam@infradead.org>, "Miaohe
 Lin" <linmiaohe@huawei.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Suren Baghdasaryan" <surenb@google.com>, "Mike
 Rapoport" <rppt@kernel.org>, x86@kernel.org, "Dave Hansen" <dave.hansen@linux.intel.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Johannes Weiner" <hannes@cmpxchg.org>, kas@kernel.org
Cc: linux-kernel@vger.kernel.org, rmikey@meta.com, harry@kernel.org, linux-mm@kvack.org, kernel-team@meta.com, riel@surriel.com, kexec@lists.infradead.org, linux-efi@vger.kernel.org
In-Reply-To: <20260909-hwpoison-kho-v4-4-359313564495@debian.org>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-4-359313564495@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:17:18 +0000
Message-Id: <20260909131719.5E1F01F00A3A@smtp.kernel.org>
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
- [High] Adjusting `start` without proportionally shrinking `size` shifts t=
he checked memory range out of bounds, causing false positive poison detect=
ion.
--

commit b492314fda14ef47eff8ff738b90a4749a490163
Author: Breno Leitao <leitao@debian.org>

mm/memory-failure: efi: answer whether a range is poisoned

This commit introduces range_contains_poisoned_memory() which allows the
page allocator to query whether a memory block overlaps with regions
recorded as poisoned by an earlier kernel via EFI.

> diff --git a/drivers/firmware/efi/poison.c b/drivers/firmware/efi/poison.c
> index c18edf111c710..e16d43f4438ee 100644
> --- a/drivers/firmware/efi/poison.c
> +++ b/drivers/firmware/efi/poison.c
[ ... ]
> +/* Does the range cover a unit an earlier kernel recorded as bad? */
> +bool range_contains_poisoned_memory(phys_addr_t start, unsigned long siz=
e)
> +{
> +	struct linux_efi_poisoned_memory *pm =3D efi_poisoned_memory();
> +	u64 first, last, nbits;
> +
> +	if (!pm)
> +		return false;
> +
> +	nbits =3D pm->size * BITS_PER_BYTE;
> +
> +	if (start + size <=3D pm->phys_base)
> +		return false;
> +	if (start < pm->phys_base)
> +		start =3D pm->phys_base;
> +
> +	first =3D (start - pm->phys_base) / pm->unit_size;
> +	if (first >=3D nbits)
> +		return false;
> +
> +	last =3D (start + size - 1 - pm->phys_base) / pm->unit_size;

[Severity: High]
When start is clamped to pm->phys_base earlier in this function, size is
not proportionally decreased. Does this result in an end boundary calculati=
on
that exceeds the originally requested range?

If the allocator queries a block that starts before the EFI poisoned memory
table (start < pm->phys_base) but extends into it, the unadjusted size added
to the newly shifted start will push the last bit beyond the intended regio=
n.=20
Could this out-of-bounds query cause false positive poison detections for
healthy memory that resides just after the requested block?

> +	last =3D min(last, nbits - 1);
> +
> +	return find_next_bit(pm->bitmap, last + 1, first) <=3D last;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-hwpoison-k=
ho-v4-0-359313564495@debian.org?part=3D4

