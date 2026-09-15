Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84324C88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 13:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VzikfrdXoe4OKdqIVI5MhWMg7/FGoAHvmjSaSoohyws=; b=KJoveC9pyr8fVr48Db6f4+FPJX
	SoPE1NnUgEIMk17mPdSM35Wd34w3yxDuE0cgJtPf1AM8/ateprz6+ELq7QTjlAIaFUHpV/md1tABd
	ORPQsDl+Kf775pKBn+yvw4VLnUOq4Ma6yH5T4ouXs45SAke7oPvXt2KzE/pRXc79rUh6McBRo6YYc
	iHIUB8WLFn7mi4TsEnbLzGRMJ8raS1uTsRWVMc7Mf34bDux2ZhXyJ9dBjeAcarOgW+oCJqEMlIxyl
	0MH9j4zn+hpS0o5AJgUQlVBdJV9IBFY/knN6dSNYjPBUpAG7kimOy43dMtN76x+vSvM2d0Bz/SuF/
	yVu6od5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6T0X-00000006gFi-261X;
	Tue, 15 Sep 2026 13:15:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6T0W-00000006gFa-05UY
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 13:15:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 18138600D1;
	Tue, 15 Sep 2026 13:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB261F0089A;
	Tue, 15 Sep 2026 13:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789478130;
	bh=VzikfrdXoe4OKdqIVI5MhWMg7/FGoAHvmjSaSoohyws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V4EdpEhkDelvZkC/X/3bK3vl9pG/mNCj4Y9fnQXsUyUjfO/C0WIiHtAE7wUFnpIJl
	 hf0m/zLPCJxaZOLx5gA1XcJJcyM0/Uwj48vUqKR2OOSz37Capy4w5XMFn4On3XQ+Qf
	 KJpsPuIDKAOrTGf4xYES5OyMcVKeiupxsGAG72zhWHFQTMAf7voR40D27dtYgU3ApH
	 8lKtecKBw1KA6sqz/3HTKKHhPKKiHHj46fRvgiZoudqwdy24NRL7Gtou8rddlFICmZ
	 SZ2KeUkDOqE1SfCUntS3mJ5Sx3OL7g5dd9LgQ4Mx2s5CqVa8s6KdFslIYwtccHAxlo
	 ocVNOhI1yr1Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] mm/memory-failure: libstub: install the
 poisoned-memory EFI table
To: "Suren Baghdasaryan" <surenb@google.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Brendan Jackman" <brendan.jackman@linux.dev>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Zi Yan" <ziy@nvidia.com>, "Miaohe
 Lin" <linmiaohe@huawei.com>, "H. Peter Anvin" <hpa@zytor.com>, shakeel.butt@linux.dev, kas@kernel.org, "Ard
 Biesheuvel" <ardb@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, x86@kernel.org, hannes@cmpxchg.or, "Thomas
 Gleixner" <tglx@kernel.org>, "Naoya Horiguchi" <nao.horiguchi@gmail.com>, "Ingo
 Molnar" <mingo@redhat.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Michal
 Hocko" <mhocko@suse.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, "Borislav Petkov" <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "Oscar Salvador" <osalvador@suse.de>, "David
 Hildenbrand" <david@kernel.org>, "Breno Leitao" <leitao@debian.org>
Cc: kernel-team@meta.com, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, rmikey@meta.com, riel@surriel.com, harry@kernel.org, kexec@lists.infradead.org, linux-efi@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20260915-hwpoison-kho-v5-3-3bc7a57bd503@debian.org>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-3-3bc7a57bd503@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 13:15:27 +0000
Message-Id: <20260915131527.AFB261F0089A@smtp.kernel.org>
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
- [High] mm: efi: integer overflow in poisoned memory bitmap allocation on =
32-bit
--

commit 591eef51f672049b14b50a75d67dac823925a19a
Author: Breno Leitao <leitao@debian.org>

mm/memory-failure: libstub: install the poisoned-memory EFI table

This commit introduces a new poisoned-memory EFI table installed by the stu=
b.
It sizes a bitmap based on the UEFI memory map to describe the RAM span and
allocates it as EFI_ACPI_RECLAIM_MEMORY so the next kernel does not take it
as free RAM.

> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/fir=
mware/efi/libstub/efi-stub-helper.c
> index 48f93f7758e9e..9c66e06c972c5 100644
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

[Severity: High]
Could this allocation size wrap around on 32-bit EFI architectures if the
memory map is extremely sparse?

In efi_get_ram_range(), ram_top is determined from EFI memory map
descriptors. If a descriptor is placed at a very high physical address,
bitmap_size could be large enough to wrap around 32-bit arithmetic.

On 32-bit EFI, the allocation size passed to allocate_pool (which takes
a 32-bit UINTN) is implicitly truncated. For example, if bitmap_size modulo
2^32 is very large (e.g., 0xFFFFFFF0), sizeof(*pm) + bitmap_size could
truncate to a tiny allocation (e.g., 8 bytes).

> +	if (status !=3D EFI_SUCCESS)
> +		return NULL;
> +
> +	pm->version =3D 1;
> +	pm->unit_size =3D EFI_POISON_UNIT_SIZE;
> +	pm->phys_base =3D phys_base;
> +	pm->size =3D bitmap_size;
> +	memset(pm->bitmap, 0, bitmap_size);

[Severity: High]
If the allocation size wrapped around, could this memset cause a heap
buffer overflow?

The 64-bit bitmap_size is passed to memset, which takes a 32-bit size_t on
32-bit architectures. This independently truncates bitmap_size (e.g., to
0xFFFFFFF0). Since the prior allocation could have wrapped to a very small
size, this would write gigabytes of zeroes into a tiny allocation, causing
boot-time memory corruption.

Would it be safer to check if bitmap_size exceeds the maximum allocation
size for the architecture, or use a safe addition helper before allocating?

> +
> +	return pm;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-hwpoison-k=
ho-v5-0-3bc7a57bd503@debian.org?part=3D3

