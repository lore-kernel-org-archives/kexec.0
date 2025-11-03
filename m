Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61619CCFA06
	for <kexec@archiver.kernel.org>; Mon,  3 Nov 2025 12:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Message-ID:Date:
	In-Reply-To:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZPuCVp19rwtajvK56KK/F0/OHsoUFzTB2npaMEA3thI=; b=u4lAP0v72+iWASp/dfslN0s+5/
	iNVQ7oSkpQyNzL9E94HgQGI48M8L3IzZwQEOTxZy8JgcfLd7vxrpZjPEPqvxTHEICXqrUqADN+Z6L
	Hl9F+mAc+hFOcioORCu2g85Cng7rjXUsDGTFLUwueTnAnJaMUSGordSnIVPQiRGhD6lkUgTVtWVD+
	SEPNYSC3pubK0ZbmQkbUMsU7aEJU/+PIqhUDvqP2U0U9JDBr21M/ste9l/XHgi7VdsSnHSxrtxJTL
	SJg6bmwSAbb0TcZfB8UGQtLw+uxZzbo7qZLTePs3AH6irmOg+X/Hy66nVFN/klBpisROX8lU2es/I
	jm9bYf/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFu32-00000009rJL-0JDX;
	Mon, 03 Nov 2025 12:52:36 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFu2z-00000009rIv-28Gx
	for kexec@lists.infradead.org;
	Mon, 03 Nov 2025 12:52:34 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-33be037cf73so4453065a91.2
        for <kexec@lists.infradead.org>; Mon, 03 Nov 2025 04:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762174352; x=1762779152; darn=lists.infradead.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZPuCVp19rwtajvK56KK/F0/OHsoUFzTB2npaMEA3thI=;
        b=cA6JocjhK+qaY0UsZTP+spxexIVPq8E++EdwMHmA3gbzOGItfSRAX/60a0DVBNZmv1
         j5P1AZGu4Jy7gAf8oPoJHhBGAVB7QoESzlALZKSJWc8MIWIW3jOhAMxm+oHl2F1622x+
         86iNwGF8Er8c/OsMSoiAsWjPayFBmSBPpx4+pVseJj4GulcDJx4SANgn2/1d2osBqotb
         Qivb0ttVhSI7H3G3fYETPg2tKWYucbT5Nnm9G5XwC88JUZtr6/2OCOZa6RQ3YWMwmkQ0
         CvawM9R1hO6ZKlkjuwkF2lpc2KEQyQ0d7rhpDwhlm5m8oTX2l5XueFv4dIFJSB5sFC46
         bpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762174352; x=1762779152;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPuCVp19rwtajvK56KK/F0/OHsoUFzTB2npaMEA3thI=;
        b=tecEG7VSiLE6TqSODzJwERSPQ8MJa2u8k4/fyLZSMLxd4uloGVKd4mHT7YhnjYuSVc
         UUEk/6CWV8tuSwEpOzoRtDJgtJBsaF8jQ46YFv6BO3x/g56QiZblMxuVUzCjbZK82Fur
         WqUh6SYsMhxMbw9cBCEe/FmU03+YiwqQqpPuUmLxWB6QTCV2zCC3A84Pa84Doj4NGdLb
         Cyol7hBf8HjnvpQN7XrSRqtdau+atxi7OoIX5M2dvZ4HXGn6nI81N4CNhXv8sLQtA/H2
         oLbUS/+2lbdL0G6nu/uiPyyCUvjCRlItyhtx6m7sGQ7oyJP+u+iehvyaKmPTUCpK0M2y
         RmSg==
X-Forwarded-Encrypted: i=1; AJvYcCW7MAfrUdcvplWnWw2JCAr7DsCZy4SeANVS4qu2/PFgud1VVy7fRHWZtk9MGsAZU6Aq7GGMog==@lists.infradead.org
X-Gm-Message-State: AOJu0YwMNewcea/p/zD0Gdr7oO047s1jItYHQ14JWoLCHM4KnU/ZTxVR
	xsMLET4wOw9Oc8MTNc0mb5X+Asz9Ts7O6iLQpLZUCE5tTtUrNEjvwCfrtBh68i6K
X-Gm-Gg: ASbGnct32jn4UjrZYbCTT75ia1TOC4S1FgNT35hIHn1q4G4H3KhK84nxvn7wal4hSoY
	aE6UKjHL3E4PPg/c2s6ihPX6n1CqPOt2s493aKRv/R0Egt3u4B67Juh2HJI/odYlUaIduFrraL5
	uRaUnahG6/UEZOhO3uOImiKp6jD+YE7JpFpW+kuxS8epIVatzB8Cl4CdrnFhPcCEfXjuxGg3HO0
	ZN3ffBCxt37lpuERxl9f3yxNNFAEdNNxAlufLBD5TSkAXbAL7h/7ykZTyG+sFZvPuK+9nDwA84s
	/zbLY3oQa32HJXZUbCav7pG+VV9Hq6WYcpovfMrKsvu6v1rWIqmQv7P+RmFO1QYK2BS72bhXfsO
	H36d5COERI1/EFQ3Ekvvd8/qviz3o69wGNgeZqnvzt78HNSUDvjbbJN6AukxGQu8uMQVSjQ==
X-Google-Smtp-Source: AGHT+IFnm5vVQ4LL2FiBxK5wjOxArExyZSlTVpwK9caPgGksac55Zj0+jJbxQegqTQKm1Vaw8fvuYA==
X-Received: by 2002:a17:90b:50:b0:340:9d52:44c1 with SMTP id 98e67ed59e1d1-3409d524557mr13145643a91.35.1762174351724;
        Mon, 03 Nov 2025 04:52:31 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599f13f2sm1007160a91.11.2025.11.03.04.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:52:30 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan he <bhe@redhat.com>, Jiri Bohac <jbohac@suse.cz>, Hari Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivang Upadhyay <shivangu@linux.ibm.com>, kexec@lists.infradead.org
Subject: Re: [PATCH v5] powerpc/kdump: Add support for crashkernel CMA reservation
In-Reply-To: <20251103043747.1298065-1-sourabhjain@linux.ibm.com>
Date: Mon, 03 Nov 2025 15:40:10 +0530
Message-ID: <87y0on4ebh.ritesh.list@gmail.com>
References: <20251103043747.1298065-1-sourabhjain@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_045233_555167_6EDC5B80 
X-CRM114-Status: GOOD (  38.44  )
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
> crashkernel= command line option") and commit ab475510e042 ("kdump:
> implement reserve_crashkernel_cma") added CMA support for kdump
> crashkernel reservation.
>
> Extend crashkernel CMA reservation support to powerpc.
>
> The following changes are made to enable CMA reservation on powerpc:
>
> - Parse and obtain the CMA reservation size along with other crashkernel
>   parameters
> - Call reserve_crashkernel_cma() to allocate the CMA region for kdump
> - Include the CMA-reserved ranges in the usable memory ranges for the
>   kdump kernel to use.
> - Exclude the CMA-reserved ranges from the crash kernel memory to
>   prevent them from being exported through /proc/vmcore.
>
> With the introduction of the CMA crashkernel regions,
> crash_exclude_mem_range() needs to be called multiple times to exclude
> both crashk_res and crashk_cma_ranges from the crash memory ranges. To
> avoid repetitive logic for validating mem_ranges size and handling
> reallocation when required, this functionality is moved to a new wrapper
> function crash_exclude_mem_range_guarded().
>
> To ensure proper CMA reservation, reserve_crashkernel_cma() is called
> after pageblock_order is initialized.
>
> Update kernel-parameters.txt to document CMA support for crashkernel on
> powerpc architecture.
>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Jiri Bohac <jbohac@suse.cz>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: kexec@lists.infradead.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> Changlog:
>
> v3 -> v4
>  - Removed repeated initialization to tmem in
>    crash_exclude_mem_range_guarded()
>  - Call crash_exclude_mem_range() with right crashk ranges
>
> v4 -> v5:
>  - Document CMA-based crashkernel support for ppc64 in kernel-parameters.txt
> ---
>  .../admin-guide/kernel-parameters.txt         |  2 +-
>  arch/powerpc/include/asm/kexec.h              |  2 +
>  arch/powerpc/kernel/setup-common.c            |  4 +-
>  arch/powerpc/kexec/core.c                     | 10 ++++-
>  arch/powerpc/kexec/ranges.c                   | 43 ++++++++++++++-----
>  5 files changed, 47 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6c42061ca20e..0f386b546cec 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1013,7 +1013,7 @@
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
>  	crashkernel=size[KMG],cma
> -			[KNL, X86] Reserve additional crash kernel memory from
> +			[KNL, X86, ppc64] Reserve additional crash kernel memory from

Shouldn't this be PPC and not ppc64?

If I see the crash_dump support... 

config ARCH_SUPPORTS_CRASH_DUMP
	def_bool PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)

The changes below aren't specific to ppc64 correct? 

>  			CMA. This reservation is usable by the first system's
>  			userspace memory and kernel movable allocations (memory
>  			balloon, zswap). Pages allocated from this memory range
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 4bbf9f699aaa..bd4a6c42a5f3 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -115,9 +115,11 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt, struct crash_mem
>  #ifdef CONFIG_CRASH_RESERVE
>  int __init overlaps_crashkernel(unsigned long start, unsigned long size);
>  extern void arch_reserve_crashkernel(void);
> +extern void kdump_cma_reserve(void);
>  #else
>  static inline void arch_reserve_crashkernel(void) {}
>  static inline int overlaps_crashkernel(unsigned long start, unsigned long size) { return 0; }
> +static inline void kdump_cma_reserve(void) { }
>  #endif
>  
>  #if defined(CONFIG_CRASH_DUMP)
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 68d47c53876c..c8c42b419742 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -35,6 +35,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/hugetlb.h>
>  #include <linux/pgtable.h>
> +#include <asm/kexec.h>
>  #include <asm/io.h>
>  #include <asm/paca.h>
>  #include <asm/processor.h>
> @@ -995,11 +996,12 @@ void __init setup_arch(char **cmdline_p)
>  	initmem_init();
>  
>  	/*
> -	 * Reserve large chunks of memory for use by CMA for fadump, KVM and
> +	 * Reserve large chunks of memory for use by CMA for kdump, fadump, KVM and
>  	 * hugetlb. These must be called after initmem_init(), so that
>  	 * pageblock_order is initialised.
>  	 */
>  	fadump_cma_init();
> +	kdump_cma_reserve();
>  	kvm_cma_reserve();
>  	gigantic_hugetlb_cma_reserve();
>  
> diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
> index d1a2d755381c..25744737eff5 100644
> --- a/arch/powerpc/kexec/core.c
> +++ b/arch/powerpc/kexec/core.c
> @@ -33,6 +33,8 @@ void machine_kexec_cleanup(struct kimage *image)
>  {
>  }
>  
> +unsigned long long cma_size;
> +

nit:
Since this is a gloabal powerpc variable you are defining, then can we
keep it's name to crashk_cma_size?

>  /*
>   * Do not allocate memory (or fail in any way) in machine_kexec().
>   * We are past the point of no return, committed to rebooting now.
> @@ -110,7 +112,7 @@ void __init arch_reserve_crashkernel(void)
>  
>  	/* use common parsing */
>  	ret = parse_crashkernel(boot_command_line, total_mem_sz, &crash_size,
> -				&crash_base, NULL, NULL, NULL);
> +				&crash_base, NULL, &cma_size, NULL);
>  
>  	if (ret)
>  		return;
> @@ -130,6 +132,12 @@ void __init arch_reserve_crashkernel(void)
>  	reserve_crashkernel_generic(crash_size, crash_base, 0, false);
>  }
>  
> +void __init kdump_cma_reserve(void)
> +{
> +	if (cma_size)
> +		reserve_crashkernel_cma(cma_size);
> +}
> +

nit:
cma_size is already checked for null within reserve_crashkernel_cma(),
so we don't really need kdump_cma_reserve() function call as such.

Also kdump_cma_reserve() only make sense with #ifdef CRASHKERNEL_CMA..
so instead do you think we can directly call reserve_crashkernel_cma(cma_size)?

-ritesh

>  int __init overlaps_crashkernel(unsigned long start, unsigned long size)
>  {
>  	return (start + size) > crashk_res.start && start <= crashk_res.end;
> diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
> index 3702b0bdab14..3bd27c38726b 100644
> --- a/arch/powerpc/kexec/ranges.c
> +++ b/arch/powerpc/kexec/ranges.c
> @@ -515,7 +515,7 @@ int get_exclude_memory_ranges(struct crash_mem **mem_ranges)
>   */
>  int get_usable_memory_ranges(struct crash_mem **mem_ranges)
>  {
> -	int ret;
> +	int ret, i;
>  
>  	/*
>  	 * Early boot failure observed on guests when low memory (first memory
> @@ -528,6 +528,13 @@ int get_usable_memory_ranges(struct crash_mem **mem_ranges)
>  	if (ret)
>  		goto out;
>  
> +	for (i = 0; i < crashk_cma_cnt; i++) {
> +		ret = add_mem_range(mem_ranges, crashk_cma_ranges[i].start,
> +				    crashk_cma_ranges[i].end - crashk_cma_ranges[i].start + 1);
> +		if (ret)
> +			goto out;
> +	}
> +
>  	ret = add_rtas_mem_range(mem_ranges);
>  	if (ret)
>  		goto out;
> @@ -546,6 +553,22 @@ int get_usable_memory_ranges(struct crash_mem **mem_ranges)
>  #endif /* CONFIG_KEXEC_FILE */
>  
>  #ifdef CONFIG_CRASH_DUMP
> +static int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
> +					   unsigned long long mstart,
> +					   unsigned long long mend)
> +{
> +	struct crash_mem *tmem = *mem_ranges;
> +
> +	/* Reallocate memory ranges if there is no space to split ranges */
> +	if (tmem && (tmem->nr_ranges == tmem->max_nr_ranges)) {
> +		tmem = realloc_mem_ranges(mem_ranges);
> +		if (!tmem)
> +			return -ENOMEM;
> +	}
> +
> +	return crash_exclude_mem_range(tmem, mstart, mend);
> +}
> +
>  /**
>   * get_crash_memory_ranges - Get crash memory ranges. This list includes
>   *                           first/crashing kernel's memory regions that
> @@ -557,7 +580,6 @@ int get_usable_memory_ranges(struct crash_mem **mem_ranges)
>  int get_crash_memory_ranges(struct crash_mem **mem_ranges)
>  {
>  	phys_addr_t base, end;
> -	struct crash_mem *tmem;
>  	u64 i;
>  	int ret;
>  
> @@ -582,19 +604,18 @@ int get_crash_memory_ranges(struct crash_mem **mem_ranges)
>  			sort_memory_ranges(*mem_ranges, true);
>  	}
>  
> -	/* Reallocate memory ranges if there is no space to split ranges */
> -	tmem = *mem_ranges;
> -	if (tmem && (tmem->nr_ranges == tmem->max_nr_ranges)) {
> -		tmem = realloc_mem_ranges(mem_ranges);
> -		if (!tmem)
> -			goto out;
> -	}
> -
>  	/* Exclude crashkernel region */
> -	ret = crash_exclude_mem_range(tmem, crashk_res.start, crashk_res.end);
> +	ret = crash_exclude_mem_range_guarded(mem_ranges, crashk_res.start, crashk_res.end);
>  	if (ret)
>  		goto out;
>  
> +	for (i = 0; i < crashk_cma_cnt; ++i) {
> +		ret = crash_exclude_mem_range_guarded(mem_ranges, crashk_cma_ranges[i].start,
> +					      crashk_cma_ranges[i].end);
> +		if (ret)
> +			goto out;
> +	}
> +
>  	/*
>  	 * FIXME: For now, stay in parity with kexec-tools but if RTAS/OPAL
>  	 *        regions are exported to save their context at the time of
> -- 
> 2.51.0

