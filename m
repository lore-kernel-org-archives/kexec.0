Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA92C88E7B
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P0JxQYBjmO1vYJSywAUW1OOBMLXNRVrkgSCeVPxsXPU=; b=qH50nIbdPnCskqpgjWxfvEdRvP
	Z6EFBDKU27liueePj9u2onqPKFv7W7ZmzqOZq0WEcc6sc+2qtudDYoXQdWDk3kswK32dh2uWnc/ru
	0ZKbPAvfkEh1wJ1Aev9zW5lmUGRRakVRYRHMATHR3ZVhOvXu+3mfDSNjWcteKVuRmkNFZS7blmCfo
	qWDc82G5xEiQZPSqB7NiA6nzc3n+qCehyGA9foUAncb3ahMpQmBk9bVvfoFMgqesbv4nnB4Bk4DjP
	XbFYyzxrOHvniGw1dFEkpRGyLPGlqUi0M5InrAYcojv4tT0kaOLaJSeMN+0jROZX2Mv5fN12ejV1G
	aGusfDkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6TiV-00000006rEO-3Ahp;
	Tue, 15 Sep 2026 14:00:59 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6TiS-00000006rDY-2Mkm
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 14:00:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P0JxQYBjmO1vYJSywAUW1OOBMLXNRVrkgSCeVPxsXPU=; b=vqajrmCt1aMjHrgjKgf9nsMc8t
	1HTSPbrZ2Nu9GG4g/qb+VIW8VrZfKXNfmRiDThFCCgEbVDUPaF2MOej9pzOvolOO1Q4ULqu61+vWA
	JUHnoFVkpIBkIeFhbh44R1GkHpUH4RmS/d8uEKQHexTpSubRTJ9JmtyjJP5ZB71J43qi+QIxG0miR
	JC65jdSlXGG3axUCE8+IDglXpMmSaBmLQyZ8pivc9K5fqmz88ngwG++duTsmzfmH7dJnPqJVHuvQo
	Z58o30vNw2QLRJymW71I3AEVrmdxMAUI0O3y/MSbGXx0CDPON0t7fbMHwIjQ6x6hWv69xAJRAf1gQ
	09t+H54A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6Thi-004RXm-32;
	Tue, 15 Sep 2026 14:00:11 +0000
Date: Tue, 15 Sep 2026 07:00:02 -0700
From: Breno Leitao <leitao@debian.org>
To: sashiko-bot@kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Mike Rapoport <rppt@kernel.org>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Zi Yan <ziy@nvidia.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, shakeel.butt@linux.dev, kas@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, hannes@cmpxchg.or, 
	Thomas Gleixner <tglx@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, kernel-team@meta.com, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	rmikey@meta.com, riel@surriel.com, harry@kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 3/9] mm/memory-failure: libstub: install the
 poisoned-memory EFI table
Message-ID: <aqlPIbH1zCHtPNcZ@gmail.com>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-3-3bc7a57bd503@debian.org>
 <20260915131527.AFB261F0089A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915131527.AFB261F0089A@smtp.kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_070056_606294_2F7DB617 
X-CRM114-Status: GOOD (  16.65  )
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

On Tue, Sep 15, 2026 at 01:15:27PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm: efi: integer overflow in poisoned memory bitmap allocation on 32-bit
> --
> 
> commit 591eef51f672049b14b50a75d67dac823925a19a
> Author: Breno Leitao <leitao@debian.org>
> 
> mm/memory-failure: libstub: install the poisoned-memory EFI table
> 
> This commit introduces a new poisoned-memory EFI table installed by the stub.
> It sizes a bitmap based on the UEFI memory map to describe the RAM span and
> allocates it as EFI_ACPI_RECLAIM_MEMORY so the next kernel does not take it
> as free RAM.
> 
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > index 48f93f7758e9e..9c66e06c972c5 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> 
> [ ... ]
> 
> > +static struct linux_efi_poisoned_memory *efi_poison_alloc(u64 phys_base,
> > +							  u64 bitmap_size)
> > +{
> > +	struct linux_efi_poisoned_memory *pm;
> > +	efi_status_t status;
> > +
> > +	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> > +			     sizeof(*pm) + bitmap_size, (void **)&pm);
> 
> [Severity: High]
> Could this allocation size wrap around on 32-bit EFI architectures if the
> memory map is extremely sparse?

This feature is limited to 64-bits only, so, these wraps on 32-bit
architectures are not real:

config EFI_POISONED_MEMORY
	def_bool y
	depends on EFI_STUB && MEMORY_FAILURE && 64BIT

