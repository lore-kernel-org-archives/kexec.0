Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE508CA9EC5
	for <kexec@archiver.kernel.org>; Mon, 12 Oct 2026 14:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MKq0YlVZaN6uo7U9gHQW5guRnA4CvVhwp5Xx9G/tslo=; b=Ytd1JG/wAdXvxEH04A4OiT9Bgi
	LQeHVIVBB8IAMwx+pRrkBcQYw3DoCaDY5rg9w2aCKA2MFYSj2gvgJPGMd19AG201kthPs/zYe7pRT
	+TJgIT5C0QSgyF403EIPVVa/zd8LunhnowtO5V/s6uajqQln9oRounMWF9avXV6VFc4gN90w1oPcZ
	PjhCwa/oZyyQWSHZS5r5htCwwHSlcGwle+2WRkuUift3e+fxVCAW2ondc+NyxLDmFutQiYXlvfqWu
	f9WaiGPAifVqPm0tvIfs14ocjwCEt7xHOTzWywVBIEftXaGSk0VR6R9Qh8x1vDxp8mxyD86FKNw3J
	Kt1iKvow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGH3K-0000000AgwK-1xlK;
	Mon, 12 Oct 2026 14:30:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGH3H-0000000Agvq-3LCn
	for kexec@lists.infradead.org;
	Mon, 12 Oct 2026 14:30:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7183B40961;
	Mon, 12 Oct 2026 14:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099FB1F0089B;
	Mon, 12 Oct 2026 14:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815455;
	bh=MKq0YlVZaN6uo7U9gHQW5guRnA4CvVhwp5Xx9G/tslo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=N30nkZhnpfbN4mIx8WKiJZKQiRFP16MssSxvaATKX0mDhkhKjIzcKKzDvSc5/oXc9
	 EUvwV/7n6vhh4B78f1V3hQsonrFuoQZdfBOtMDLu7dXB/niEi73HqT1dg8EQVhQShR
	 B/OtCod86sIO7cjPyJG2b96TFgKiJpWPKq2tGEeeoD+yy3x50+FT3xWSNN3j3kbb3y
	 rf1b212b4LIU2yx08qfhd3V6vxJ/+fSnRNeJnaRaauRVPU6tTTApi9SlrcqP9LRa5v
	 il/SASQSEIC1fp6lr4u8wrZQpzxRv6Z6uR8stnuofQqohtx7IoYHASiQ0HjgwF7nkG
	 CqBY7xfaar5tw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org,  Aditya Gupta <adityag@linux.ibm.com>,
  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baoquan He <baoquan.he@linux.dev>,
  "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,  Hari Bathini
 <hbathini@linux.ibm.com>,  Madhavan Srinivasan <maddy@linux.ibm.com>,
  Mahesh Salgaonkar <mahesh@linux.ibm.com>,  Michael Ellerman
 <mpe@ellerman.id.au>,  Mike Rapoport <rppt@kernel.org>,  Nicholas Piggin
 <npiggin@gmail.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>,  Shivang Upadhyay <shivangu@linux.ibm.com>,
  Shrikanth Hegde <sshegde@linux.ibm.com>,  linux-kernel@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 1/2] kho: check scratch vs CMA alignment at runtime
In-Reply-To: <20260928083226.107807-2-sourabhjain@linux.ibm.com> (Sourabh
	Jain's message of "Mon, 28 Sep 2026 14:02:25 +0530")
References: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
	<20260928083226.107807-2-sourabhjain@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:30:50 +0200
Message-ID: <2vxzfqybj8it.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Sep 28 2026, Sourabh Jain wrote:

> KHO requires the scratch alignment to be at least CMA_MIN_ALIGNMENT_BYTES,
> and this is currently enforced with a static_assert().
>
> That assertion breaks the build on powerpc once CONFIG_KEXEC_HANDOVER is
> enabled together with CONFIG_TRANSPARENT_HUGEPAGE or CONFIG_HUGETLB_PAGE:
>
>     kernel/liveupdate/kexec_handover.c:49:39: error: expression in static assertion is not constant
>        49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>     ./include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
>        80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>           |                                                        ^~~~
>     kernel/liveupdate/kexec_handover.c:49:1: note: in expansion of macro 'static_assert'
>        49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>
> CMA_MIN_ALIGNMENT_BYTES depends on pageblock_order, which is not a
> compile-time constant with certain configs, such as
> CONFIG_HUGETLB_PAGE_SIZE_VARIABLE on powerpc. The next patch in this
> series enables KHO on powerpc, so the alignment must be checked at
> runtime instead.
>
> Replace the static_assert() with a runtime check at the start of
> kho_reserve_scratch(), before any scratch memory is reserved. If the
> scratch alignment is smaller than the CMA minimum alignment, warn once
> and disable KHO rather than continue with a misaligned reservation.
>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 7c4d86daf86d..dc76dd6b74da 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -39,15 +39,7 @@
>  #include "../kexec_internal.h"
>  #include "kexec_handover_internal.h"
>  
> -/*
> - * This is the minimal alignment required by deferred struct page init.
> - * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
> - * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> - * If KHO scratch is not aligned to that value, buddy can access uninitialized
> - * struct pages, which can cause a crash.
> - */
>  #define SCRATCH_ALIGNMENT_BYTES (PAGE_SIZE * MAX_ORDER_NR_PAGES)
> -static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>  
>  /* The magic token for preserved pages */
>  #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
> @@ -836,6 +828,21 @@ static void __init kho_reserve_scratch(void)
>  	if (!kho_enable)
>  		return;
>  
> +	/*
> +	 * This is the minimal alignment required by deferred struct page init.
> +	 * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
> +	 * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> +	 * If KHO scratch is not aligned to that value, buddy can access uninitialized
> +	 * struct pages, which can cause a crash.
> +	 */
> +	if (WARN_ON_ONCE(SCRATCH_ALIGNMENT_BYTES < CMA_MIN_ALIGNMENT_BYTES)) {

Nit: do we need both the WARN_ON_ONCE() and the pr_err()? Can't we drop
the WARN and keep the pr_err only?

LGTM otherwise.

> +		pr_err("scratch alignment %lu < CMA minimum %lu, disabling\n",
> +		       (unsigned long)SCRATCH_ALIGNMENT_BYTES,
> +		       (unsigned long)CMA_MIN_ALIGNMENT_BYTES);
> +		kho_enable = false;
> +		return;
> +	}
> +
>  	scratch_size_update();
>  
>  	/* FIXME: deal with node hot-plug/remove */

-- 
Regards,
Pratyush Yadav

