Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F59FC79FB6
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 13:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VF44nhzHiC16881Gb5iN9h+Bgx6pDfvd8nvJKSSNfOA=; b=MG0cYNE9cVTugk0VQq/K5jPJF0
	5e1jB211FWbseksOKYiqBiyhd2QmyDPlVVu8YOxoxFi/qIGRpNA3j+ESUemNNx174w+Ra+26Gbfs5
	k1L2ms5l2WiFlrKN4kJsg+G0fr7aCKfATZnSqY3wXLZbg8o8Np0cvvjORKaA8XSoFYs52xBM0fWnb
	KAnsx0nFVDVSOiSxmOo2aEnhkvawILmpfRgBfs1h4Ow3/a9V+xbII1V4ECTjmTejzCIpXGtBK1OOs
	9tvq+0ckchtM4K5Dp+ZnvIjuPjqkrdozGtQESJbLvjzPix31/l+w7cK6V1RtWK17E+HpKj7lGGQmr
	Fu88GqkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4ICp-0000000BlpN-24Tu;
	Wed, 09 Sep 2026 13:19:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4ICn-0000000BlpG-3gQf
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 13:19:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5134260213;
	Wed,  9 Sep 2026 13:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D361F00A3A;
	Wed,  9 Sep 2026 13:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788959953;
	bh=VF44nhzHiC16881Gb5iN9h+Bgx6pDfvd8nvJKSSNfOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jifU7nYaAmhEue3ZYS6hL0mgYz8TAE2Dz8MLMyM0RGevIig9ehKh8qykWRHAfYsiA
	 z1r8vfttWhtJrvznAsmQdAhsI/5V6KgHMyMbZ/wH2+uJ2FV0zXLba5O84c8wX2KyOO
	 Q7Y3zuCqdn+GB6I4hS8XN9KVqJgl7OnRW79NXrj2KrVp4RyTXQ6ceX9oCDWI52ZRyt
	 HhNRMTB96EMZ47gBlPlLYwLjBDhkZTbdV5P4lhJsbs6/6bxgnjoFay7J0A1QF71p1D
	 Sb7KNx7hgZzzTIj/pbNoW+dmFMMwYtT6Bn3s5MjKIaX6Szh+RRcbCsIuBuHJbes2yo
	 FFL2fdsv3bxnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] mm/memory-failure: libstub: install the
 poisoned-memory EFI table
To: "David Hildenbrand" <david@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, "Breno Leitao" <leitao@debian.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Ingo Molnar" <mingo@redhat.com>, "Zi
 Yan" <ziy@nvidia.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "H. Peter Anvin" <hpa@zytor.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Miaohe Lin" <linmiaohe@huawei.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Ard Biesheuvel" <ardb@kernel.org>, kas@kernel.org, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Liam R. Howlett" <liam@infradead.org>, x86@kernel.org, "Suren
 Baghdasaryan" <surenb@google.com>, "Brendan Jackman" <brendan.jackman@linux.dev>
Cc: harry@kernel.org, linux-efi@vger.kernel.org, riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, rmikey@meta.com, kernel-team@meta.com
In-Reply-To: <20260909-hwpoison-kho-v4-2-359313564495@debian.org>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-2-359313564495@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:19:11 +0000
Message-Id: <20260909131911.76D361F00A3A@smtp.kernel.org>
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
- [Critical] Integer truncation in efi_poison_alloc leads to a massive heap=
 buffer overflow during memset on 32-bit or mixed-mode systems.
--

commit 626632820fe1fdcddc73aaeb109705cbddc9828c
Author: Breno Leitao <leitao@debian.org>
Subject: mm/memory-failure: libstub: install the poisoned-memory EFI table

This patch introduces functionality in the EFI stub to create and install a
poisoned-memory EFI configuration table. It walks the UEFI memory map to fi=
nd
the RAM range and allocates a bitmap to track poisoned memory granules.

> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/fir=
mware/efi/libstub/efi-stub-helper.c
> index 48f93f7758e9e..5cbe675491333 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
[ ... ]
> +static struct linux_efi_poisoned_memory *efi_poison_alloc(u64 phys_base,
> +							  u64 bitmap_size)
> +{
> +	struct linux_efi_poisoned_memory *pm;
> +	efi_status_t status;
> +
> +	status =3D efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> +			     sizeof(*pm) + bitmap_size, (void **)&pm);

[Severity: Critical]
Could sizeof(*pm) + bitmap_size overflow 32 bits on 32-bit or mixed-mode
systems? If the EFI memory map describes a very large physical address space
(such as a 32PB physical address provided by an untrusted hypervisor in a
TDX/SEV environment), bitmap_size could approach 4GB.

Because the size argument to allocate_pool is a UINTN, a value like
0x100000008 (sizeof(*pm) + 0xFFFFFFF0) would truncate to 8 bytes on 32-bit
EFI systems, resulting in an undersized allocation.

> +	if (status !=3D EFI_SUCCESS)
> +		return NULL;
> +
> +	pm->version =3D 1;
> +	pm->unit_size =3D EFI_POISON_UNIT_SIZE;
> +	pm->phys_base =3D phys_base;
> +	pm->size =3D bitmap_size;
> +	memset(pm->bitmap, 0, bitmap_size);

[Severity: Critical]
If the allocate_pool calculation overflowed and truncated as described abov=
e,
does this memset trigger an out-of-bounds write regression?

Since bitmap_size (e.g., 0xFFFFFFF0) fits within a 32-bit size_t, memset
will use the large untruncated size, potentially overwriting up to 4GB of E=
FI
boot services memory following the undersized allocation.

> +
> +	return pm;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-hwpoison-k=
ho-v4-0-359313564495@debian.org?part=3D2

