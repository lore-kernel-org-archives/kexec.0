Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9F1C61DB6
	for <kexec@archiver.kernel.org>; Tue, 25 Aug 2026 08:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CCYDel/tAdzTMGg+Jj8Kdei0wnaQDrvWQsN0iqXHMug=; b=f4hOPt7kjmY5oB+vrhKMbjb4Ap
	PYcgPMaVGAlG5xm7jlwSoOVyj2pCJz59MT9GIcQbfj3F1xj6thTr8AjTwfl51tXHftGUt6MNv5J20
	62i+FjMZxtnS3McW7Z2kMr8T+lrzMElu0fHVnA82jvGaoWXDFLqsSpj3HmpqkTdEQ5BEOwUTX+Coc
	d9bhDVcTlnls2YIU5WwhVz9OA7wfyLlpfOp2dBCQU2sL4Tgy088WI1uXwUukW86C5dhLO1HP5v9IQ
	Hvd5HCucB5OT7OtzGmNIPXUV80PpGI/k6TzJCLmyx1ZRATIxuk8KCtvm6uQqze8mwWcUNBHzhLG2j
	7Vu3Dn4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wymUv-00000000Nfg-102j;
	Tue, 25 Aug 2026 08:27:09 +0000
Received: from out-78.mta1.migadu.com ([2001:41d0:203:375::4e] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wymUp-00000000Nee-37BS
	for kexec@lists.infradead.org;
	Tue, 25 Aug 2026 08:27:07 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=DChXo/KfNVh9xF3RagTAYkVNjDX3u2CFlFuaf/8dF+U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787646420; v=1; x=1788251220;
 b=tVoGGlmo1peh2AqM9BV7kuU9nTTblE0Br7ZkksT7JUu4BzUeI1UgmNOPpicNt7CKT1xOO7cp
 XddEM6DrMvV/h8ndGj8q9fJh1RypArPHGnEX9F7NEMqSlDu9atVWev/ft9cpwREdx+ErlrWAjBE
 e0XJCwLOrE1uXwzqTQeMovgU=
X-Envelope-To: kexec@lists.infradead.org
Received: from localhost (3.112.29.171)
	by mta12.migadu.com with ESMTPS id 1c0c6490f2473443;
	Tue, 25 Aug 2026 08:27:00 +0000
X-Mizu-Trace-ID: 1c0c6490f2473443
X-Migadu-Flow: FLOW_OUT
Date: Tue, 25 Aug 2026 16:26:52 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, akpm@linux-foundation.org, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, eric.devolder@oracle.com,
	hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
	ruanjinjie@huawei.com, include@grrlz.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS,
 not CONFIG_NR_CPUS_DEFAULT
Message-ID: <ao1RzE6EgrLn3DbD@fedora>
References: <20260825075043.42041-1-ionut.nechita@windriver.com>
 <20260825075043.42041-2-ionut.nechita@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825075043.42041-2-ionut.nechita@windriver.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_012703_921826_2AA28E8A 
X-CRM114-Status: GOOD (  32.64  )
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

On 08/25/26 at 10:50am, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> kexec_file_load(2) fails with -EINVAL when loading a crash kernel on a
> machine whose number of possible CPUs exceeds CONFIG_NR_CPUS_DEFAULT,
> even though the classic kexec_load(2) path succeeds on the same machine.
> 
> With CONFIG_CRASH_HOTPLUG=y the elfcorehdr segment is over-allocated so
> it can be updated in place on CPU/memory hotplug.  On the
> !CONFIG_MEMORY_HOTPLUG path, crash_load_segments() sizes that
> reservation as:
> 
> 	ret = crash_prepare_headers(..., &kbuf.bufsz, &pnum);
> 	...
> 	pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
> 
> The value that lands in @pnum is crash_prepare_headers()'s
> @nr_mem_ranges out parameter, i.e. cmem->nr_ranges - the number of
> memory ranges only, not a phdr count.  The header that
> crash_prepare_elf64_headers() actually builds adds one phdr per
> *possible* CPU on top of those ranges:
> 
> 	nr_phdr = nr_cpus + 1;		/* + vmcoreinfo */
> 	nr_phdr += mem->nr_ranges;
> 	nr_phdr++;			/* + kernel text map */
> 
> So the reservation covers
> 
> 	nr_ranges + 2 + CONFIG_NR_CPUS_DEFAULT
> 
> phdrs while the buffer holds
> 
> 	nr_ranges + 2 + num_possible_cpus()
> 
> phdrs, and the buffer exceeds the reservation by
> 
> 	(num_possible_cpus() - CONFIG_NR_CPUS_DEFAULT) * sizeof(Elf64_Phdr)
> 
> bytes as soon as num_possible_cpus() grows past CONFIG_NR_CPUS_DEFAULT.
> num_possible_cpus() is bounded by CONFIG_NR_CPUS, not by
> CONFIG_NR_CPUS_DEFAULT, so this is reachable on any config that raises
> CONFIG_NR_CPUS above the arch default without CONFIG_MAXSMP.
> 
> crash_prepare_elf64_headers() rounds bufsz up to ELF_CORE_HEADER_ALIGN
> and kexec_add_buffer() rounds memsz up to PAGE_SIZE (both 4096), so the
> excess is invisible until it outgrows that padding.  Once it does,
> sanity_check_segment_list() rejects the image:
> 
> 	if (image->segment[i].bufsz > image->segment[i].memsz)
> 		return -EINVAL;
> 
> kexec_load(2) is unaffected because user space builds the elfcorehdr
> without the hotplug over-allocation.
> 
> Observed on a single-socket Xeon 6776P (144 possible CPUs) running a
> PREEMPT_RT kernel with:
> 
> 	# CONFIG_MAXSMP is not set
> 	# CONFIG_MEMORY_HOTPLUG is not set
> 	CONFIG_NR_CPUS_RANGE_BEGIN=2
> 	CONFIG_NR_CPUS_RANGE_END=512
> 	CONFIG_NR_CPUS_DEFAULT=64
> 	CONFIG_NR_CPUS=256
> 
> At 144 possible CPUs the buffer exceeds the reservation by
> (144 - 64) * 56 = 4480 bytes.  That is more than the 4096 bytes of page
> padding, so the overflow is guaranteed and kexec -p -s fails with
> "kexec_file_load failed: Invalid argument".  Reducing the possible CPU
> count to 72 leaves an excess of (72 - 64) * 56 = 448 bytes, which the
> page rounding still absorbs, and the load succeeds - confirming the
> reservation is the limiting factor.
> 
> Reserve the elfcorehdr for CONFIG_NR_CPUS, the compile-time upper bound
> of num_possible_cpus(), so the reservation always covers the header that
> is actually generated.
> 
> The CONFIG_MEMORY_HOTPLUG=y path discards @pnum and reserves
> 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES phdrs
> instead.  With the default CONFIG_CRASH_MAX_MEMORY_RANGES=8192 the
> memory range allowance dwarfs the CPU shortfall, so that path does not
> fail in practice; it is switched to CONFIG_NR_CPUS as well for
> consistency and to stay correct for small CONFIG_CRASH_MAX_MEMORY_RANGES
> values.
> 
> This does not change the reservation for defconfig-like builds, since
> CONFIG_NR_CPUS defaults to CONFIG_NR_CPUS_DEFAULT.  Only configs that
> raise CONFIG_NR_CPUS reserve more, and the worst case is bounded by the
> top of the range (CONFIG_NR_CPUS=8192 with CONFIG_CPUMASK_OFFSTACK=y),
> which is exactly what CONFIG_MAXSMP already reserves today.
> 
> Fixes: ea53ad9cf73b ("x86/crash: add x86 crash hotplug support")
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> ---
>  arch/x86/kernel/crash.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e681ec9cf1dc..e6f23933a6df 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -369,9 +369,9 @@ int crash_load_segments(struct kimage *image)
>  	 * maximum CPUs and maximum memory ranges.
>  	 */
>  	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> -		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
> +		pnum = 2 + CONFIG_NR_CPUS + CONFIG_CRASH_MAX_MEMORY_RANGES;
>  	else
> -		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
> +		pnum += 2 + CONFIG_NR_CPUS;
>  
>  	if (pnum < (unsigned long)PN_XNUM) {
>  		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
> @@ -430,7 +430,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>  	unsigned int sz;
>  
>  	/* kernel_map, VMCOREINFO and maximum CPUs */
> -	sz = 2 + CONFIG_NR_CPUS_DEFAULT;
> +	sz = 2 + CONFIG_NR_CPUS;
>  	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>  		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
>  	sz *= sizeof(Elf64_Phdr);

I didn't dare to read the commit log, but judging from the code, it looks
like a good fix.

Acked-by: Baoquan He <baoquan.he@linux.dev>

> 
> base-commit: 4b18edbd8e70f7e6860d56370f13244896d0f95c
> -- 
> 2.55.0
> 

