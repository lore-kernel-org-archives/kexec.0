Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DAFCD98D6
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kwzn1hzeGIcRzeJH6kryEm6m63oonjH9mTFa0zzCpug=; b=Ve5lEqEeHl5+9UjzizrOo9AbTB
	Wc3dz+K7MectZaJRFFk3BSLUNOZL3MLPASy8gLLZGOn0nfF7yMfIOXy8+8M6EqtDOEYQ8M1CwHMPZ
	MrSj8jfLqgerrhfz50nRD1rKCz+kpR0U5WnTO4BUPFv3LCMcvpCxmicWooirz2z9H/N0JojhBDLH7
	q+cs7LGOi1fASxFLGUlgqlwLVLvXB+sP1QkjGa+MoH7tlAhCvKm3Lst1wSBKNHhbBGuntwLx6gljW
	0M0uYS1kneivVrHIWf/TO7ENNBl8NaJjFNry1MNNJDN4v470J2Uwbsn/QSoZWfTcPCGNTFEHeY/Zs
	34++pu3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjYB-0000000Cwre-09oj;
	Sun, 14 Jun 2026 12:02:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjY9-0000000Cwqc-2STo
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 12:02:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A7EC43E47;
	Sun, 14 Jun 2026 12:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558261F00A3A;
	Sun, 14 Jun 2026 12:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781438569;
	bh=kwzn1hzeGIcRzeJH6kryEm6m63oonjH9mTFa0zzCpug=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=RqNkEevGhGMmJm9i8JjJw+HFEelsGN9sOdHOkFELNlVTiV2mNeuTULivvU6ea53iY
	 of46hPHggr0DGI05GY3R13xoRQ1NOZeAZJohFZu+9Cd0l+DJH5DNyQC8SVIVx2X2Z6
	 lEo2YZ+V0661mxlaRSg4RizLKmUSGyfNoXVH5JybPxLBlG9Tv9QNgFS9Ed1Mr9SqtN
	 jJO0R0vghBsiiu8GKH1iY6JvvdjR3A7kOzgmyUcxWlYramil2bUksEUl7i0LAPKZKA
	 jrUVOF0sbSStxR1D/HrQZSpg3S9iUmvg6rsCtl9NF1oYCLwiW5dIZ4aVvY5wEUCQ7G
	 dUgHrAzn0YWWQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 14/18] memblock: use kho_scratch_overlap() to decide
 migratetype
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
 Jork Loeser <jloeser@linux.microsoft.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260605183501.3884950-15-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
 <20260605183501.3884950-15-pratyush@kernel.org>
Date: Sun, 14 Jun 2026 15:02:31 +0300
Message-Id: <178143855115.2123877.12922508735700031761.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Fri, 05 Jun 2026 20:34:47 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 5afcd99aa8c1..546d7ef798b8 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -618,7 +619,7 @@ bool memblock_is_kho_scratch_memory(phys_addr_t addr);
>  static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
>  						       enum migratetype mt)
>  {
> -	if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)))
> +	if (kho_scratch_overlap(PFN_PHYS(pfn), pageblock_nr_pages << PAGE_SHIFT))

I'd move it to kexec_handover.h and kill
memblock_is_kho_scratch_memory() in the same patch

BTW, please double check that the extended scratch does not require
updates to efi_init()::reserve_regions().

-- 
Sincerely yours,
Mike.


