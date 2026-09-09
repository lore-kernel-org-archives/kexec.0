Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E2FC79FB6
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZqGD6+EIHmen/yXXRwBLkUFq1BO6jBImOTP5fEBlNDw=; b=RrWgxgC0na/crZ7wiw7vwYISrN
	XCxLQtEuvQRICoYDc0LMvovwPeh3gQZwdz3Z6Gh2Z5Gk1KwjVBJLSmXnx4c+GwFbXmUuuzxb8UTVi
	1g37xhti82Kiu3Qi+DNHaZZqwfvTJqapXEW/uifSXZVtDi07KJskN9fW1BzU1bqwom3MavRjYxpTM
	lJeiCi5G1z0W83NYVGIcekZ64Ar2aoI3Zs1OCBYnWWzFzCZ/WgCdzJ9qs5spHSjSlzzUDtS772L/1
	x5dRtQIX+u4A3oGDxxKrsiXICOBGJsiHKJRq7jcoAjHuCagreiW8HXrYLUHQr6RHQryjSiy9xUVtQ
	FmT/Vmog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4IrX-0000000BrrQ-3QDw;
	Wed, 09 Sep 2026 14:01:19 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4IrU-0000000Brqj-123m
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 14:01:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZqGD6+EIHmen/yXXRwBLkUFq1BO6jBImOTP5fEBlNDw=; b=cTCDZr6ZCnhsx+vTe2Bu439RDN
	zgmXwoq1tVj2rx1oPZhMrSaFompcN5ZiFJdN/lhLCVc6R5T3U/Utt6CUPXc2qguLiC9jxT+VCRK/F
	U3ncOktFQ9HN+NnyyZ2Y71JQr6LSiFDnT8eLQMzOY+g97udoqNxU3Fjkl8/RX0cwOuFk45/Cl2qcu
	J+drc+sx7Y2+76t/NIr7LdQcnx66ZNjf3vXefaNaYQXDTvp4kor32JZGM20hxOsmjbCdHPvyiR5XX
	2GFIhX2leHw0/Vg/YI7PM1Vmbtf7uRgGps32nBAS2NlQyuwr3fpCx4xgVi5FR/JZs92o3FEwfD2zb
	H3lcLMpQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x4Iqs-0036XE-0I;
	Wed, 09 Sep 2026 14:00:38 +0000
Date: Wed, 9 Sep 2026 07:00:30 -0700
From: Breno Leitao <leitao@debian.org>
To: sashiko-reviews@lists.linux.dev
Cc: David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>, 
	Zi Yan <ziy@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Johannes Weiner <hannes@cmpxchg.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>, kas@kernel.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Liam R. Howlett" <liam@infradead.org>, x86@kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Brendan Jackman <brendan.jackman@linux.dev>, harry@kernel.org, 
	linux-efi@vger.kernel.org, riel@surriel.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kexec@lists.infradead.org, rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v4 2/5] mm/memory-failure: libstub: install the
 poisoned-memory EFI table
Message-ID: <aqFmJao8Os0ySPjF@gmail.com>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-2-359313564495@debian.org>
 <20260909131911.76D361F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909131911.76D361F00A3A@smtp.kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_070116_284181_DEBD3F29 
X-CRM114-Status: GOOD (  15.97  )
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

On Wed, Sep 09, 2026 at 01:19:11PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Integer truncation in efi_poison_alloc leads to a massive heap buffer overflow during memset on 32-bit or mixed-mode systems.
> --
> 
> commit 626632820fe1fdcddc73aaeb109705cbddc9828c
> Author: Breno Leitao <leitao@debian.org>
> Subject: mm/memory-failure: libstub: install the poisoned-memory EFI table
> 
> This patch introduces functionality in the EFI stub to create and install a
> poisoned-memory EFI configuration table. It walks the UEFI memory map to find
> the RAM range and allocates a bitmap to track poisoned memory granules.
> 
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > index 48f93f7758e9e..5cbe675491333 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> [ ... ]
> > +static struct linux_efi_poisoned_memory *efi_poison_alloc(u64 phys_base,
> > +							  u64 bitmap_size)
> > +{
> > +	struct linux_efi_poisoned_memory *pm;
> > +	efi_status_t status;
> > +
> > +	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> > +			     sizeof(*pm) + bitmap_size, (void **)&pm);
> 
> [Severity: Critical]
> Could sizeof(*pm) + bitmap_size overflow 32 bits on 32-bit or mixed-mode
> systems?

This feature (EFI_POISONED_MEMORY) is only enabled on 32-bits system,
so, 32-bit issues is not a real issue. See very first patch:

	+config EFI_POISONED_MEMORY
	+	def_bool y
	+	depends on EFI_STUB && MEMORY_FAILURE && 64BIT

So, this is a false positive

