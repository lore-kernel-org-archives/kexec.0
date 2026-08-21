Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E872C5DF87
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kJK8zYVP422FvpgoMi2IYMM8fvVyRmiBglfOTp8DIAA=; b=cMwuVgmgPgYtEEC/1W8cKLiyy/
	AGwz8eTYZbj1hYYG/jpDtfnRIrg5rndxQhI49ADVzqZnp8Mqcrs198gbG5nwQDH3eaR0uRqDxkWhj
	wfeGAdQg42nt4VRUKOrmAVoOCOEfhDY0d7uy1TW5gZwsu1ZkurvEkLSSKmOLYDtRkCGtsoct4rskm
	/0QwbMoNtHeygFOHPm5uE/Hp8Oz0PU0Tq/xiJlTQhIaEaHDG7cV/+UKxCKpv5UgxKs+bJ8cW56Ds9
	ilgFJfyzax4ck/vXQpVQcznCSCiqQ0U/Rl4CallXJa3MTkGP8gu/q4w9jR2A3tIKKiZMujofG1eQE
	UuX/T4HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxNWR-0000000DCEp-0Kwd;
	Fri, 21 Aug 2026 11:34:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxNWQ-0000000DCEj-0t15
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 11:34:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5177760008;
	Fri, 21 Aug 2026 11:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7001F000E9;
	Fri, 21 Aug 2026 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787312093;
	bh=kJK8zYVP422FvpgoMi2IYMM8fvVyRmiBglfOTp8DIAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GfHCO7b71pDpL2ixqylgh76wjhe8mKsSfm32uTm22AvSEp6o5YPls8px3oH8ooGM4
	 ngTloyRJaLnVJQ/9nGdGqz2UghBZGeOPjDazczTK5CUA+H+PNdsarsqtjo/cUwU7ap
	 s4VUY7LndqGeDBDFhAe/kqp9OixfyCzBB4W99W8xxGlWKvqiA5Byhf4QTjyHrpKxH2
	 EnmuMl5QbcFa3ltN0JdprQGnI2dw/QzsGufcidXUYZMypFNqg+U4J2HE2fQHirvUBf
	 DfnOwK++CLRQxIelsxzJ6uE3IIZWBmpBIA5HeEjVq2St1M06sYslODdSGiVs3N+h+q
	 o6qVoQAl+knHQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,  Aditya Gupta <adityag@linux.ibm.com>,
  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baoquan He <baoquan.he@linux.dev>,
  "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,  Hari Bathini
 <hbathini@linux.ibm.com>,  Madhavan Srinivasan <maddy@linux.ibm.com>,
  Mahesh Salgaonkar <mahesh@linux.ibm.com>,  Michael Ellerman
 <mpe@ellerman.id.au>,  Mike Rapoport <rppt@kernel.org>,  Nicholas Piggin
 <npiggin@gmail.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>,  Shivang Upadhyay <shivangu@linux.ibm.com>,
  Shrikanth Hegde <sshegde@linux.ibm.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org, Michal Clapinski <mclapinski@google.com>
Subject: Re: [RFC PATCH 3/3] powerpc/kho: exclude THP and HUGETLB_PAGE
In-Reply-To: <20260821105609.983622-4-sourabhjain@linux.ibm.com> (Sourabh
	Jain's message of "Fri, 21 Aug 2026 16:26:09 +0530")
References: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
	<20260821105609.983622-4-sourabhjain@linux.ibm.com>
Date: Fri, 21 Aug 2026 13:34:48 +0200
Message-ID: <2vxzecfrzoyv.fsf@kernel.org>
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

On Fri, Aug 21 2026, Sourabh Jain wrote:

> Enabling CONFIG_KEXEC_HANDOVER together with CONFIG_TRANSPARENT_HUGEPAGE
> or CONFIG_HUGETLB_PAGE on powerpc fails to build:
>
>     kernel/liveupdate/kexec_handover.c:49:39: error: expression in static assertion is not constant
>        49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>     ./include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
>        80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>           |                                                        ^~~~
>     kernel/liveupdate/kexec_handover.c:49:1: note: in expansion of macro 'static_assert'
>        49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>
> CMA_MIN_ALIGNMENT_BYTES is derived from pageblock_order, which on
> powerpc is not a compile-time constant when THP or HUGETLB_PAGE is
> enabled -- powerpc can determine huge page size at runtime in that
> configuration, so pageblock_order becomes a variable rather than a
> constant expression. KHO's static_assert() on
> SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES then fails to
> compile, since it requires both sides to be constant expressions.
>
> Until CMA_MIN_ALIGNMENT_BYTES (or KHO's use of it) is made to handle
> the non-constant pageblock_order case on powerpc, exclude
> TRANSPARENT_HUGEPAGE and HUGETLB_PAGE from ARCH_SUPPORTS_KEXEC_HANDOVER
> so the two can't be enabled together and hit this build failure.

This should be a part of patch 2 I think. It is not a good idea to break
the build in one patch and fix it in the next.

That said, this is a debug check of sorts since SCRATCH_ALIGNMENT_BYTES
is of MAX_ORDER_NR_PAGES, and pageblocks _should_ always be smaller of
equal to this.

Anyway, I don't think this is something you should gate by a config. I
think you should either remove the static_assert(), or turn it into a
runtime check.

+Cc Michal.

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
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 61350d3e7a19..f68b9fc883ba 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -720,6 +720,7 @@ config ARCH_SUPPORTS_KEXEC_HANDOVER
>  	def_bool y
>  	depends on PPC64
>  	depends on !CRASH_DUMP
> +	depends on !TRANSPARENT_HUGEPAGE && !HUGETLB_PAGE
>  
>  config ARCH_SUPPORTS_CRASH_HOTPLUG
>  	def_bool y

-- 
Regards,
Pratyush Yadav

