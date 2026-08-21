Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052C2C5DF89
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 11:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T/nW1BCc6K6NF98RkjC+qK+gveVrIp2Ec0sQaOBBYEE=; b=36nzSqsT2h0npvffWkRohwEV9M
	lcQExCMXS7y2F5nNvTs/fvvTed4LvznZbDS7gKmGg7fwY96dVsSEg06v0ODEk/ABegRKoPV5riTWS
	qmvd3A7fzC4IFrWjhkaKBT+BAXpKNx/xPHTZfhQZEZpNu5dC+nXvmw7LHlJ/ighRR7OxLyKf41JuC
	2zsxQkz5c2HpOOGZpVf5CA388MjzdItjxuNS6o5vfxUJtKNN5DlCaT8bSMOaJ6ooviEfZ02UKtd5A
	G/KKRkxnBZu54rHIcWBwIEEiMnsnwrZKgS8+m+la0BOzAbLaqk0nrgqctmhboKO4de6Z9WF586Ym+
	0YPpaBzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxNrS-0000000DFSd-3gj9;
	Fri, 21 Aug 2026 11:56:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxNrR-0000000DFSV-3xFe
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 11:56:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0D88460008;
	Fri, 21 Aug 2026 11:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4241F000E9;
	Fri, 21 Aug 2026 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787313396;
	bh=T/nW1BCc6K6NF98RkjC+qK+gveVrIp2Ec0sQaOBBYEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IjX6NrjC3RkHO/JFhPapADIOyk+E1jBkTDgGo0GoE7ZhEPRwowskKlbDKrR8KzKHH
	 NY3WAiCrMWRBsUCCS4MDbfGefLGO40A+TsC75fti1YW5L7xF9zfV8l3GSHCqJrXA+k
	 ZvtdiaBXqxEmH5FkpkZ8pGtgcg3sV5ka+qHmfDChqTXrrFbzjw7BMvU3qdl7eEzE1Y
	 kTQPwpx0hfxx02L9V8Y/0q3FHrig8/mWBunoUnba/u2+RLamaV+V4o9ePaTGLoEhTC
	 afJTsCDPTUqbv3C26AEi9nsLinowo1aSZ5RFmPj/WhbIyxiP6Ar/g5AQOxqJdgCrDc
	 J89yfPLdeQOyw==
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
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] powerpc: add support for Kexec HandOver (KHO)
In-Reply-To: <20260821105609.983622-3-sourabhjain@linux.ibm.com> (Sourabh
	Jain's message of "Fri, 21 Aug 2026 16:26:08 +0530")
References: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
	<20260821105609.983622-3-sourabhjain@linux.ibm.com>
Date: Fri, 21 Aug 2026 13:56:31 +0200
Message-ID: <2vxza4qfznyo.fsf@kernel.org>
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

> Add the architecture bits needed to enable CONFIG_KEXEC_HANDOVER on
> powerpc.
>
> Set ARCH_SUPPORTS_KEXEC_HANDOVER for PPC64, following the existing
> pattern used by ARCH_SUPPORTS_KEXEC and ARCH_SUPPORTS_KEXEC_FILE.
>
> On the boot path, parse the "linux,kho-fdt" and "linux,kho-scratch"
> properties from /chosen and pass them to kho_populate(). This lets a
> kernel booted via KHO kexec recover the FDT and scratch region left
> behind by the previous kernel. The call is placed early in
> setup_arch(), before unflatten_device_tree().
>
> Open issues:
> ============
>
> This patch also adds "depends on !CRASH_DUMP" to
> ARCH_SUPPORTS_KEXEC_HANDOVER. This is needed because of an ordering
> conflict between crashkernel reservation and KHO scratch reservation
> on powerpc.
>
> Crashkernel memory is reserved very early in boot, from arch-specific
> code: head.S -> early_setup() -> early_init_devtree() ->
> arch_reserve_crashkernel() / fadump_reserve_mem(). KHO's scratch
> region is reserved later, from generic code: start_kernel() ->
> mm_core_init() -> kho_memory_init(). So on powerpc, crashkernel
> memory is always reserved first.
>
> This ordering causes a real failure. In the common case, crashkernel
> reservation on powerpc starts at a 512M offset (the exact offset can
> vary, but 512M is typical). So with crashkernel=3G, the reservation
> occupies memory from 512M up to 3.5G -- roughly 75% of the entire low
> 4G area.
>
> Since crashkernel reservation always happens first, that 3G is
> already committed by the time kho_memory_init() runs. It then tries
> to reserve a low scratch region sized at 200% of whatever is already
> reserved below 4G. With ~75% of that 4G area already taken by
> crashkernel memory, 200% of that easily exceeds the remaining space
> -- and since the low scratch region is itself capped at 4G, there's
> no room left to fit it. The reservation fails.

crashkernel has the variant "crashkernel=size[KMG],high", which ensures
memory is allocated above 4G. Unless powerpc has some requirement for
strictly having the crashkernel below 4G, I think it will make a lot of
sense to enable support for this feature. So KHO users can specify this
to get crashkernel working with KHO.

Powerpc doesn't support this right now, but from a quick skim of the
code, I think it should be simple enough. From
arch_reserve_crashkernel() you just need to pass a bool * to
parse_crashkernel(), and then pass the result to
reserve_crashkernel_generic().

Solving the ordering of crash reservations and KHO is tricky and comes
with some difficult tradeoffs. Allocating crash from highmem should be a
lot simpler.

And on that note, I don't think you should do a depends on !CRASH_DUMP.
Even when CONFIG_KEXEC_HANDOVER is enabled, KHO isn't on by default
(well, unless KEXEC_HANDOVER_ENABLE_DEFAULT is set). You need to enable
it via cmdline. So it is entirely possible for people using KHO on PPC
to not use crash and vice versa. This decision can be made at deployment
time, not at compile time.

>
> To work around this and get KHO working on powerpc, this patch:
>
> 1. Makes KHO usable on powerpc only when CRASH_DUMP is disabled.
> 2. Calls kho_populate() from setup_arch(), so it runs before
>    kho_memory_init() reserves the scratch region.
>
> The real fix would be to reserve the KHO scratch region before
> crashkernel memory instead of after. But scratch reservation happens
> in generic code (kho_memory_init(), called from mm_core_init()), so
> this isn't something powerpc can address on its own -- it needs
> discussion on how to influence the ordering between generic scratch
> reservation and arch-specific crashkernel reservation. This patch
> doesn't attempt that; it's meant as a starting point for that
> discussion.
>
[...]
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2580e27e4328..61350d3e7a19 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -716,6 +716,11 @@ config ARCH_SELECTS_CRASH_DUMP
>  	depends on CRASH_DUMP
>  	select RELOCATABLE if PPC64 || 44x || PPC_85xx
>  
> +config ARCH_SUPPORTS_KEXEC_HANDOVER
> +	def_bool y
> +	depends on PPC64
> +	depends on !CRASH_DUMP
> +
>  config ARCH_SUPPORTS_CRASH_HOTPLUG
>  	def_bool y
>  	depends on PPC64
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 4afaba19b586..1fee743abdf2 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
[...]
>  }
>  #endif
>  
> +#ifdef CONFIG_PPC64
> +static void __init init_kho(const void *fdt)
> +{
> +	unsigned long node;
> +	u64 fdt_start, fdt_size, scratch_start, scratch_size;
> +
> +	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER))
> +		return;
> +
> +	/* Find and verify the /chosen node, same as early_init_dt_scan_chosen() does */
> +	node = fdt_path_offset(fdt, "/chosen");
> +	if ((long)node < 0)
> +		node = fdt_path_offset(fdt, "/chosen@0");
> +	if ((long)node < 0)
> +		return;
> +
> +	if (!of_flat_dt_get_addr_size(node, "linux,kho-fdt",
> +				      &fdt_start, &fdt_size))
> +		return;
> +	if (!of_flat_dt_get_addr_size(node, "linux,kho-scratch",
> +				      &scratch_start, &scratch_size))
> +		return;
> +
> +	kho_populate(fdt_start, fdt_size, scratch_start, scratch_size);
> +}

This looks pretty much a duplicate of early_init_dt_check_kho(). On
arm64 this is called via early_init_dt_scan(). But from a quick search I
don't see powerpc calling it.

Would it make sense to call this function (or
early_init_dt_scan_nodes()) for powerpc?

If not, I think it would be a better idea to expose
early_init_dt_check_kho() and call it from powerpc setup_arch() instead
of duplicating the logic.

> +#endif
> +
>  /*
>   * Called into from start_kernel this initializes memblock, which is used
>   * to manage page allocation until mem_init is called.
[...]

-- 
Regards,
Pratyush Yadav

