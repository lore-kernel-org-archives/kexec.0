Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181EFD7495D
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 06:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oAP6Z0e/yWsNG1D2mwSpfmhrnvSiAbTcGRMa3P4yRgA=; b=Dnqf5xyZ3MCz0QgwWm+974qCTP
	vQKuKmqjQGZkRkQ2T8/k+VC0rftEsMiRvopSaf/iY6EHEfkQt0sntheXMAW0ZNrikFtLixyIxYumW
	pHFVyk5/skZg3OZbbiCqvH3Gj5Nucojy/c3RoD1hbNo7dCCXpPHl8zRkgjG9bKzVCwt4LdwNDcV53
	LmMjgLfTRm/k6qbXl1kUVuhU4CsyZ8A3sxoWzmo9avYcMM8zLWpnbU6C57L/cs3tkjn+DzAWeP1hJ
	Y36U4kDX8ZA3CtraRrO/vAukp5ccB/UJPdx1MZZ5bvmb5g2BeFLXmlIdejyNOqogj2A2CfYBczOCI
	G/bPVqlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWUBd-00000009iaw-24kh;
	Fri, 19 Dec 2025 06:42:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWUBa-00000009iaX-1zo3
	for kexec@lists.infradead.org;
	Fri, 19 Dec 2025 06:41:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DFE1440734;
	Fri, 19 Dec 2025 06:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC21C4CEF1;
	Fri, 19 Dec 2025 06:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766126516;
	bh=HzEKMFvO/dlheq7ln+rLHMiIciSJnfxSw3qvsSgM+PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVtdQwEF8ZPRKcW5SvddzS/n5jX0AfDpfi6uBms4JQBoUoqt9ySK4jaBmNy3/v93x
	 z6plPJd7pHQPJi0rdGg6otDHy0kDOnOtoCE44riDat91Jzd2FPuTOFQIdLPehcV8Vc
	 /9YVerVnQnb6vYuBKWOpS70A8Vj8JHFixjEJE/ZCzvJ70x1KVKgF7UfRg+VbDM6biP
	 L0AHmjPx6QGhyeO4wwyfSQCO0pA6kUpAU2yGcVd+fG4cWbmPY87ukp71Cjr3GjAVyx
	 4wLvcQ9WGBJeVO6Z6nfHX1mBcSqTDJBMEo0FVEu5YwMn/9jnbZ6mq8QvdNzts4R7p9
	 fhYRoT+OpH1Hg==
Date: Fri, 19 Dec 2025 08:41:50 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, graf@amazon.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, pratyush@kernel.org,
	ricardo.neri-calderon@linux.intel.com
Subject: Re: [PATCH v2] kho: validate preserved memory map during population
Message-ID: <aUTzrnz3ZBm_APmv@kernel.org>
References: <20251219030854.3527871-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219030854.3527871-1-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_224158_581406_DDF41260 
X-CRM114-Status: GOOD (  17.76  )
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

On Thu, Dec 18, 2025 at 10:08:54PM -0500, Pasha Tatashin wrote:
> If the previous kernel enabled KHO but did not call kho_finalize()
> (e.g., CONFIG_LIVEUPDATE=n or userspace skipped the finalization step),
> the 'preserved-memory-map' property in the FDT remains empty/zero.
> 
> Previously, kho_populate() would succeed regardless of the memory map's
> state, reserving the incoming scratch regions in memblock. However,
> kho_memory_init() would later fail to deserialize the empty map. By that
> time, the scratch regions were already registered, leading to partial
> initialization and subsequent list corruption (double-free) during
> kho_init().
> 
> Move the validation of the preserved memory map earlier into
> kho_populate(). If the memory map is empty/NULL:
> 1. Abort kho_populate() immediately with -ENOENT.
> 2. Do not register or reserve the incoming scratch memory, allowing the new
>    kernel to reclaim those pages as standard free memory.
> 3. Leave the global 'kho_in' state uninitialized.
> 
> Consequently, kho_memory_init() sees no active KHO context
> (kho_in.mem_chunks_phys is 0) and falls back to kho_reserve_scratch(),
> allocating fresh scratch memory as if it were a standard cold boot.
> 
> Fixes: de51999e687c ("kho: allow memory preservation state updates after finalization")
> Reported-by: Ricardo <ricardo@example.com>

I believe Ricardo has a real email ;-)

> Closes: https://lore.kernel.org/all/20251218215613.GA17304@ranerica-svr.sc.intel.com
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
> Changes v2:
> - Removed phys_to_virt() from kho_populate().
> 
>  kernel/liveupdate/kexec_handover.c | 39 ++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 9dc51fab604f..6ba554208c81 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -460,27 +460,23 @@ static void __init deserialize_bitmap(unsigned int order,
>  	}
>  }
>  
> -/* Return true if memory was deserizlied */
> -static bool __init kho_mem_deserialize(const void *fdt)
> +/* Returns head of preserved physical memory chunks pointer from FDT */
> +static phys_addr_t __init kho_get_mem_chunks_phys(const void *fdt)

Let's s/mem_chunks/mem_map/ everywhere please.
And the comment would become

/* Returns physical address of the preserved memory map from FDT */

Other than that

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

