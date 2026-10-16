Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0FFCCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OpZ0wBLLxQUa5CgdozF2ufRx7c/l/sR+IFVbcv3+wks=; b=Kv5M73LifRggoHe5FjLedRI8uD
	+Gc3U/HsPtAS0chZheZt1O1tLRbaWEBEpr4p75MZNUoX8hXQsjAVXwY3kmzt64MSK2upFR+Td5Sqp
	WEyxNrvZ0pozeVroKKlIbeGprFF8Z3E9sFBZfNDRF9YjU5X0fhlzjyc5Jt89ICLU4r70RsELU176u
	JAXqhD/kPVoClDfDIcYhX8sySX/lNXIgb+gOIVdftAOYPzf2b3MDxUBzXLhLG09NSWzS3zFwpdiLS
	Li/WzKYuOp4o+z6qv9Y4/kLZhE6Ie0yeyK6GZw7YHwZE9ocq8aiznEm8JejoKeCJkbqQOLlvBoPbK
	2B5siBDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHgzO-00000002rgp-3U5C;
	Fri, 16 Oct 2026 12:24:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHgzN-00000002rgZ-1feH
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 12:24:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C8BAF4358D;
	Fri, 16 Oct 2026 12:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5841F000C4;
	Fri, 16 Oct 2026 12:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792153484;
	bh=OpZ0wBLLxQUa5CgdozF2ufRx7c/l/sR+IFVbcv3+wks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jATMDPnAZ+9GZ2DERMkMV7mSoJQ5bsSrpt/XPRSP9eJegk9D/EsnMUdOHrk5atSMJ
	 yjKLT1C4Pl7Ca3Z4TYnNiWKoAjJC9dZEHGREpCTLI9vfyN77KeWNJdJGEy5RnK0NHz
	 xNSIJEhT1xgKKZjgdg0NxzUgXG2QN1cjuHbv6dwRWdNG2ZAhz0iMzjAwO3XHJdCrWu
	 TpZpqxNM6qO7SffINpUhXEhWI1vGOMJ0GN6qQ53JtIBD7LtgFfsVDGJE1aAzLHlriy
	 dqdTtQ5qdMxv5dKoI05UkcRtW4xLp9C6erC6Whk4bGAxh5ef7fUzpsutUIkaJYGC4V
	 zk/lpDLxP+Lkg==
Message-ID: <sashiko-outbox-174290@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/7] mm/memory-failure: libstub: install the
 poisoned-memory EFI table
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
In-Reply-To: <20261016-hwpoison-kho-v6-2-f304255147da@debian.org>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-2-f304255147da@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:24:42 +0000
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
- [High] mm: 32-bit integer truncation in efi_poison_alloc causes heap buff=
er overflow
--

commit 09b9f9b59673eeb21856d3365898ea89a642bbc0
Author: Breno Leitao <leitao@debian.org>

mm/memory-failure: libstub: install the poisoned-memory EFI table

This commit adds support for installing a poisoned-memory EFI configuration
table during boot services. It sizes a bitmap based on the RAM span to
track memory failures.

> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/fir=
mware/efi/libstub/efi-stub-helper.c
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
[ ... ]
> +static efi_status_t efi_get_ram_range(u64 *base, u64 *top)
> +{
[ ... ]
> +	if (!ram_top || ram_base =3D=3D ULLONG_MAX)
> +		return EFI_NOT_FOUND;
> +
> +	*base =3D round_down(ram_base, EFI_POISON_UNIT_SIZE);
> +	*top =3D round_up(ram_top, EFI_POISON_UNIT_SIZE);

[Severity: High]
Could ram_top wrap around to 0 here if it is very close to ULLONG_MAX?

If ram_top wraps to 0, the later calculation of span (ram_top - ram_base)
in install_poisoned_memory_table() would result in a very large 64-bit valu=
e.

> +
> +	return EFI_SUCCESS;
> +}
[ ... ]
> +static struct linux_efi_poisoned_memory *efi_poison_alloc(u64 phys_base,
> +							  u64 bitmap_size)
> +{
> +	struct linux_efi_poisoned_memory *pm;
> +	efi_status_t status;
> +
> +	status =3D efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> +			     sizeof(*pm) + bitmap_size, (void **)&pm);

[Severity: High]
Does this risk a heap buffer overflow due to 32-bit integer truncation?

If the earlier calculation produces a bitmap_size exceeding 32 bits, could
sizeof(*pm) + bitmap_size truncate to a tiny allocation on 32-bit
architectures?

The subsequent memset() might then use the truncated or original 64-bit size
to write far past the bounds of the allocated pool:

    memset(pm->bitmap, 0, bitmap_size);

> +	if (status !=3D EFI_SUCCESS)
> +		return NULL;
> +
> +	pm->version =3D 1;
> +	pm->unit_size =3D EFI_POISON_UNIT_SIZE;
> +	pm->phys_base =3D phys_base;
> +	pm->size =3D bitmap_size;
> +	memset(pm->bitmap, 0, bitmap_size);
> +
> +	return pm;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-hwpoison-k=
ho-v6-0-f304255147da@debian.org?part=3D2

