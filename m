Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68121C88E53
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 13:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UD1C1sFiLo886bWFCF4yCVjFbhAC5ORHunqhsih89BI=; b=k8kzgIWWgAMKLRRZDcRO/RxymW
	ZIjKWeeBpAaWxms3tgZCG9p7c0DLtlEN12J29+GtTXjLGSCbA5BQ+7KUfOwx803daZLaOF00num27
	5Q6c9smfmpVva81JD2tQhU0RwxcMt8C3Lpe281gMWzq4hZE+3lWnIF8jiunmBSufwwKZVIL6urOwJ
	SieqwgaGD1ZEtDRgHeHtwh3w7pfO31JVPkX9Gl4MUhj99yeCv7MuMrOCJKVMtNryFXyCfM/IjK5Uz
	8JtgmDALUWhdBEo1dF8OmD570miNmbQZMqeRd6wwERe/5koVqTs9Vm8MRsUUmXLzxC8lwT8Q27ey5
	Y1APomWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6TKr-00000006krr-3T6V;
	Tue, 15 Sep 2026 13:36:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6TKq-00000006krF-0DyE
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 13:36:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 78072400FD;
	Tue, 15 Sep 2026 13:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700EE1F000FF;
	Tue, 15 Sep 2026 13:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789479391;
	bh=UD1C1sFiLo886bWFCF4yCVjFbhAC5ORHunqhsih89BI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SZqVJGAm8yvcnbN40xI+hqlsdqMDLkdt+phXQtPX68AzkVtujfWWbbiGfXbUa2Uym
	 GVn/Nt/2dfvQsCKfCKY5JX4TDRFYeUywiiZtEQoSyMDnNFAB58WVP3gyPlYfr2gLzW
	 46i7sA6/3GwFqCAkXxGegqIiREYKDnXnFYbG1IWUedOQs3dlPwWKAIFvt88csCqqJB
	 JhrYK8GNSnhKAnI3Vd7VcyfPulYz/1mfzI61CW6idvYDRk1L0h0bM3cgCGE/lu9XqC
	 I0p1GADYpzRWQgYCXbBM6PXsUZCYGyyJPl+mIfv7Aztx0DqxKRTslvqj0jpq9mMRRc
	 5Y/PrfNGoeEZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] mm/memory-failure: efi: record hardware-poisoned
 frames into the poisoned-memory table
To: "David Hildenbrand" <david@kernel.org>, "Naoya Horiguchi" <nao.horiguchi@gmail.com>, kas@kernel.org, "Zi
 Yan" <ziy@nvidia.com>, "Breno Leitao" <leitao@debian.org>, hannes@cmpxchg.or, shakeel.butt@linux.dev, "Liam
 R. Howlett" <liam@infradead.org>, "Miaohe Lin" <linmiaohe@huawei.com>, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Borislav Petkov" <bp@alien8.de>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Danilo Krummrich" <dakr@kernel.org>, "Michal
 Hocko" <mhocko@suse.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Oscar
 Salvador" <osalvador@suse.de>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Mike
 Rapoport" <rppt@kernel.org>
Cc: kernel-team@meta.com, kexec@lists.infradead.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, linux-mm@kvack.org, rmikey@meta.com, driver-core@lists.linux.dev, riel@surriel.com, harry@kernel.org
In-Reply-To: <20260915-hwpoison-kho-v5-5-3bc7a57bd503@debian.org>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-5-3bc7a57bd503@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 13:36:29 +0000
Message-Id: <20260915133629.700EE1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] efi: memblock_add() with PAGE_ALIGN_DOWN forces adjacent MMIO =
into system RAM
- [High] efi: ABI breakage in linux_efi_poisoned_memory due to native word =
size
- [Medium] mm: hard memory failures on soft-offlined pages are omitted from=
 EFI table
--

commit e69689c81050c18119d69206dc9a7cb1e2fa4eeb
Author: Breno Leitao <leitao@debian.org>

mm/memory-failure: efi: record hardware-poisoned frames into the poisoned-m=
emory table

This commit hooks memory_failure() hard offline reports into the EFI
poisoned memory table so that they persist across kexec. Soft-offlined
pages are deliberately excluded to prevent predictive offlining from
becoming a permanent loss.

> diff --git a/drivers/firmware/efi/poison.c b/drivers/firmware/efi/poison.c
> index 3f12db3dc9b84..847592862f01d 100644
> --- a/drivers/firmware/efi/poison.c
> +++ b/drivers/firmware/efi/poison.c
> @@ -91,3 +91,30 @@ void __init efi_poisoned_memory_reserve(void)
>  	memblock_add(start, end - start);
>  	memblock_reserve(start, end - start);

[Severity: Critical]
Does this forcefully override the firmware's memory map for adjacent 4KB
chunks on larger page architectures?=20

On architectures like ARM64 where the kernel page size can be 16KB or
64KB, EFI memory descriptors remain 4KB. If the EFI poisoned memory table
occupies a 4KB region within a 64KB page, rounding down to the kernel
page boundary expands the range.

This could force adjacent 4KB EFI regions containing firmware MMIO or
reserved non-RAM regions into system RAM via memblock_add(). If the
kernel later maps these regions with Write-Back caching attributes in the
direct map, could this cause fatal Machine Check Exceptions or SError
panics during speculative CPU accesses?

[ ... ]

> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index dd3263456dd4a..56402fdccd114 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1288,8 +1288,10 @@ struct linux_efi_poisoned_memory {

[Severity: High]
Does the linux_efi_poisoned_memory ABI structure break on architectures
where the native word size differs from the firmware?=20

The struct uses an unsigned long flexible array for the bitmap, which
alters the element size depending on the kernel bitness (4 bytes on 32-bit
and 8 bytes on 64-bit). efi_poison_geometry_valid() rejects tables where
the size is not a multiple of sizeof(unsigned long).=20

If a 32-bit EFI firmware generates this table, it will use 4-byte alignment
and a 32-bit word array. Because CONFIG_EFI_POISONED_MEMORY is 64-bit only,
the 64-bit kernel will evaluate sizeof(unsigned long) as 8 and reject
perfectly valid 32-bit firmware tables as malformed.=20

Since bit array layouts also differ across word sizes on big-endian
architectures, should this firmware-to-kernel ABI boundary use fixed-size
types like u32 or u64 instead?

> =20
>  #ifdef CONFIG_EFI_POISONED_MEMORY
>  void __init efi_poisoned_memory_reserve(void);
> +void efi_hwpoison_record_pfn(unsigned long pfn);

[ ... ]

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a2ca8df501cae..d9b8be696aac3 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
[ ... ]
> @@ -1326,6 +1327,8 @@ static int action_result(unsigned long pfn, enum mf=
_action_page_type type,
>  	if (type !=3D MF_MSG_ALREADY_POISONED && type !=3D MF_MSG_PFN_MAP) {
>  		num_poisoned_pages_inc(pfn);
>  		update_per_node_mf_stats(pfn, result);
> +		/* Only hard offlines are carried over to the next kernel. */
> +		efi_hwpoison_record_pfn(pfn);
>  	}

[Severity: Medium]
Does placing efi_hwpoison_record_pfn() inside this conditional block
unintentionally skip recording hard errors on previously soft-offlined
pages?=20

Soft-offline marks a page with PageHWPoison but intentionally does not
record it in the EFI table to avoid permanent loss for predictive errors.=20

If a genuine hard, uncorrectable error later occurs on that same page,
memory_failure() will see the existing PageHWPoison flag and pass
MF_MSG_ALREADY_POISONED to action_result().=20

By coupling the EFI recording to the meminfo stat increments, genuine
hard errors on soft-offlined pages are omitted from the EFI table. Could
this allow the next kernel to map and crash on physically broken RAM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-hwpoison-k=
ho-v5-0-3bc7a57bd503@debian.org?part=3D5

