Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F79C88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U0YAPSCzjIvx9j5UuO3la71ldkiY663ti2cQ1z7Zo34=; b=pjt/x9S9Tky5wHPuhbAZWZzUw2
	/xU1XAkoBTTkfuFEZh0Yep0V5YeeSE2tQ+TAe5iXE/vlqRM6f0eLT5aY47qfcgB9D8j52FhF2ZlJr
	ltSlZedYdrUxQLMIW5BFlRllrf0F+KUUKtAL2S7XbreQBgz98I9irUQejalkGEKEcdFshZZn0Vbrm
	U9Qv7b91//+HSToy4IH/j3RsjRoQiMMmiWk687OFjW+HJD6z/zbiEpYA9OwnidPVNlzCo9n/cUwFd
	Q0xptbsOgfbi33cZrK8CzCyDrLy0ze27hTW1Tx0U6t+jBMToin50HqEAxs24jb60V6bDw7owSg6R4
	NV4Py0Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Tsa-00000006sh2-31ha;
	Tue, 15 Sep 2026 14:11:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6TsZ-00000006sgV-0oix
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 14:11:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 99FE14385F;
	Tue, 15 Sep 2026 14:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A209A1F000FF;
	Tue, 15 Sep 2026 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789481482;
	bh=U0YAPSCzjIvx9j5UuO3la71ldkiY663ti2cQ1z7Zo34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=baDlUtFwZ7KCV4ufgTF//oU9YijykM7UmGP8RPQrD+I8pBO+jchLE29xCD1JteFFG
	 uJ0SOqHSmDC+KQ4IZxr7tzq7M6U2SU8TAl5BBntbdoZ5zj1na3pmN7vXwcO9Wpx5SC
	 rY25b6BGE0yPe+0Mswb8tlBkv5+sXjFsGykikSy1u4unUQZWAkHACiourVm8X4+O/E
	 HDneJHgr8sfHh5bwIaTnsDcvU/1uJxa2dZ/oPSwy0lhieD/NUrLxIJRS5tFAt/jW1D
	 l3m84KwUcryVRdWgYhgaA0nOxBWmOhcjT4OkTN+OlDGJuUQa+LciWoQcxHs7mQDkuq
	 cZRjH/f/KpnBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/9] mm/memory-failure: add hwpoison_boot_page() to
 flag an inherited frame
To: "Oscar Salvador" <osalvador@suse.de>, "Suren Baghdasaryan" <surenb@google.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Michal Hocko" <mhocko@suse.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Zi Yan" <ziy@nvidia.com>, "Miaohe
 Lin" <linmiaohe@huawei.com>, "Borislav Petkov" <bp@alien8.de>, "Thomas
 Gleixner" <tglx@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Mike Rapoport" <rppt@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, x86@kernel.org, "David
 Hildenbrand" <david@kernel.org>, "Naoya Horiguchi" <nao.horiguchi@gmail.com>, shakeel.butt@linux.dev, "Brendan
 Jackman" <brendan.jackman@linux.dev>, hannes@cmpxchg.or, "Ard Biesheuvel" <ardb@kernel.org>, kas@kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Breno
 Leitao" <leitao@debian.org>
Cc: linux-cxl@vger.kernel.org, linux-mm@kvack.org, rmikey@meta.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, linux-efi@vger.kernel.org, harry@kernel.org, driver-core@lists.linux.dev, kexec@lists.infradead.org, riel@surriel.com
In-Reply-To: <20260915-hwpoison-kho-v5-8-3bc7a57bd503@debian.org>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-8-3bc7a57bd503@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 14:11:20 +0000
Message-Id: <20260915141120.A209A1F000FF@smtp.kernel.org>
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
- [Medium] mm: memory_failure_stats data race in hwpoison_boot_page()
--

commit 95ab593413859ad843df67ede9095a08529eb0cd
Author: Breno Leitao <leitao@debian.org>

mm/memory-failure: add hwpoison_boot_page() to flag an inherited frame

This commit adds a helper, hwpoison_boot_page(), to flag inherited frames
recorded as poisoned by the previous kernel before they reach the allocator.
It leaves the frame in the state expected for poisoned frames, allowing
existing PG_hwpoison logic to cover it appropriately.

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d9b8be696aac3..60e9682434700 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
[ ... ]
> @@ -137,6 +137,32 @@ phys_addr_t range_last_hwpoison(phys_addr_t start, u=
nsigned long size)
>  	return range_hwpoison(start, size, false);
>  }
> =20
> +static void update_per_node_mf_stats(unsigned long pfn, enum mf_result r=
esult);
> +
> +void __meminit hwpoison_boot_page(struct page *page,
> +				  enum meminit_context context)
> +{
> +	unsigned long pfn =3D page_to_pfn(page);
> +
> +	if (PageHWPoison(page))
> +		return;
> +
> +	SetPageHWPoison(page);
> +	set_page_count(page, 1);
> +	/* The page has been completely isolated =3D=3D MF_RECOVERED */
> +	update_per_node_mf_stats(pfn, MF_RECOVERED);

[Severity: Medium]
Is it safe to call update_per_node_mf_stats() here without acquiring mf_mut=
ex?

During memory hotplug (when context =3D=3D MEMINIT_HOTPLUG), if
hwpoison_boot_page() is called for inherited poisoned frames, it appears th=
is
could race with runtime hardware error processing on other CPUs.

Other paths like memory_failure() update these same per-node statistics whi=
le
holding mf_mutex. Because update_per_node_mf_stats() performs non-atomic
increments:

mm/memory-failure.c:update_per_node_mf_stats() {
        ...
        case MF_RECOVERED:
                ++mf_stats->recovered;
                break;
        ...
        ++mf_stats->total;
}

Could calling it here circumvent the mutex and corrupt the memory failure
sysfs statistics by losing counter updates?

> +
> +	/*
> +	 * The per memory block half of num_poisoned_pages_inc() has no block to
> +	 * find at boot, and divides by zero looking for one. A hotplugged block
> +	 * is already there.
> +	 */
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-hwpoison-k=
ho-v5-0-3bc7a57bd503@debian.org?part=3D8

