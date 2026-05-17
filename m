Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B7ECD4F21
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 10:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZCkN3CP7OdEUHRCKYw7qa8nK+EbFRHVG/U6scz8hx0I=; b=jzQfz44PLJYVBTpxZdPFBIbHjc
	SYKy8YmtdtGWUabOItf1vtIALdOPcmLC0tNQGP4XSXkFbsX/vbSc3iURqR2+ygXngBdjyM4Ls9uxD
	OY9grsl2Wm2NAOQ9CMQzhV0yYMk9buCQWEOeRiq4944XfWQMpnw2XfF937W3If+OTE6XTEK8M6mwE
	neAAOOiAAZET6z816A3C+XRnVGj5HivIGWQDe3wJDTqOrH+kG0Xhcqqlpys8XOgYFMf65u7DMlerG
	QYMBylW0I/Kwnu1oD43BgDwcGEgvX6YAU9XDn+bpR1Xw9n8jtWyCA0E/Ht43aOGvX6ibHsYtilIAd
	fGq8OBNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOYZN-0000000CVmJ-0KO1;
	Sun, 17 May 2026 10:18:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOYZK-0000000CVli-2qum
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 10:17:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6CDEF4173A;
	Sun, 17 May 2026 10:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A241C2BCB0;
	Sun, 17 May 2026 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779013077;
	bh=I0qBvfgj53Jp++THC/CCO/kmcft0x3HCmB3+tnF/LrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrB+T16nkVTMYt7xlK0QT3nNBbBQ+u+K50tCW25pJhVN7Tk8vwPMUY6PohUVHQirK
	 Jo8KYGxg5BGZCUOkJA3Bl1g6m4lKrOEK99Z4tKh2Aah2YmetX8SZZ90yEkmLkD65Z4
	 K8JC/2KDCJwfgxlPArmvmM3oyufCLsftE/evV74sNDUN4gytbYFqRQtbvxO71Xxhgg
	 bda/SQC65qNuJOutl7qu6rWZcHGKXV5WutSxCYxd649o/XUrgEEmUllL/DlriJDShh
	 VsoGofQGL1PgRdBPxkmIdkR2y+Nau7KHQwsMr3VTaSUFbF/1hYlIPlV0q/A4TAGJaQ
	 zGyVf7Hno9FGQ==
Date: Sun, 17 May 2026 13:17:50 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] kho: extended scratch
Message-ID: <agmVzhvF8cxFu1PK@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-11-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133928.850721-11-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_031758_741334_FABE92F0 
X-CRM114-Status: GOOD (  18.08  )
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

On Wed, Apr 29, 2026 at 03:39:12PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> Methodology
> ===========
> 
> Introduce extended scratch areas. These areas are discovered at boot by
> walking the preserved memory radix tree and looking for free blocks of
> memory. They then marked as scratch to allow allocations from them. This
> makes KHO more resilient to memory pressure and allows supporting huge
> page preservation.
> 
> Since the preserved memory radix tree mixes both physical address and
> order into a single key, and does not track table pages, it is difficult
> to identify free areas from it directly. Walk the tree and digest it
> down into another radix tree. The latter tracks blocks of
> KHO_EXT_SHIFT (1 GiB as of now) granularity. Then walk the digested tree
> and mark the areas between the present keys as scratch.
>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  include/linux/kexec_handover.h     |   1 +
>  kernel/liveupdate/kexec_handover.c | 148 +++++++++++++++++++++++++----
>  mm/mm_init.c                       |   1 +
>  3 files changed, 133 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 1a04e089f779..c2b843a5fb28 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -840,6 +857,120 @@ static void __init kho_reserve_scratch(void)
>  	kho_enable = false;
>  }
>  
> +#define KHO_EXT_SHIFT 30 /* 1 GiB */

arm64 does not necessarily use 1G gigantic pages and worse, it can have 2
gigantic hstates.

I think this should take into account what actual gigantic page sizes are
in use for the general case.

-- 
Sincerely yours,
Mike.

