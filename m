Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD107C61DBD
	for <kexec@archiver.kernel.org>; Tue, 25 Aug 2026 17:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xz5GPfTIo7PT8ZQxO4zWr4a0zeJ2UwXMkkRyZohIxN4=; b=VIgV53poF8ewEyfWT33tLLx2il
	OU2oBdWbZ4sv6Oh28Gyn2j2oTbwRmligLFoZ2JUFhZ+OTcCYQnWNEHSghXJ6y2yhh+Fgv1IzNZ8W/
	9dgSA7SuNEuA/tOfQxSjycbiyQX4Qya46roH+iOgg+cNkP+N2r+92TiQFUO7riYSq1UnmTl4bUdrh
	JXMro7EYgxsuSa8ahkenYXNA00MTaIpM5VJXz0SG0YbvDKieU5aK/ih30Jze02kR79I6LBIBDEemG
	cDruTcI3qaVN6jVtJhrNohrtI+FFyKUIFNXI+M+3G+gMdgUz6J1bKqu83bwP+MmjoRzX4WBm2cLVa
	5blEzgng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyvGq-00000001FHn-23DT;
	Tue, 25 Aug 2026 17:49:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyvGn-00000001FH9-0YXH
	for kexec@lists.infradead.org;
	Tue, 25 Aug 2026 17:49:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787680146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xz5GPfTIo7PT8ZQxO4zWr4a0zeJ2UwXMkkRyZohIxN4=;
	b=Cor5+iNrSQ92dJTFryyZ2r2roTu0NSZ5lc45dHQI5aqAAqOnQwFvNEyuPS1es8OW1NyJX6
	uzQ4eO03oTRLTF5iXuf/ehKS+we0S/wJNqbHa6en4ghSO6KXmh2LLtYEdAzG9CswGt81Tk
	yxSHlKsHvGwvs3KTZ+4cRQUaifdeRzM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-TY0CuzufPC-C2EgYMam3PQ-1; Tue, 25 Aug 2026 13:49:04 -0400
X-MC-Unique: TY0CuzufPC-C2EgYMam3PQ-1
X-Mimecast-MFC-AGG-ID: TY0CuzufPC-C2EgYMam3PQ_1787680144
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-388b404eaa4so226792a91.0
        for <kexec@lists.infradead.org>; Tue, 25 Aug 2026 10:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680144; x=1788284944;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xz5GPfTIo7PT8ZQxO4zWr4a0zeJ2UwXMkkRyZohIxN4=;
        b=LyjwVagnVvhHJcJ24kacYy31HtECJLADwI9V8rZujrMHGjM/dwn+yjNVJKokjWtrKX
         n2576IYMWPnEynq9yAtL92s1tqYC9dKHz8H2E/VanBK3G3MooNUzqNAAxhKBevD90MP7
         7YjRwASzRnPfeWqfUPvzpgYiUCzM7VdMjMwpKX7g2z7hsM0QDxaRWNQRRI3YJr2vI3iq
         faMUcYLJc/F4vqJexDc9BDPeYHjGJnPIMbdInEVH1oMJL7URNceVDPiOgkmNh0udMcaL
         hR34225bU6IrKJl4mKf6oGtG3wJiPNW2qw99lqynxICEmRtOdSuEq67dDK2CdE0tjPhP
         yfRA==
X-Gm-Message-State: AFuF++mTMF8CV+4ga6A7P+RViiK8xQEuPfYZN+jzTmIcc6SUcp9EJOIz
	JnKgePM6uZkYusjJAQ3bwujEMMiP2RNAmAsSarn8Rl5xopdLLcg2hiN2ekXER5xw11r20bXdvBk
	Egq9+fO3w5pMdqOgciFz9eaoW3RGjrDoNPIm6WTui3EcHdGEFzMkbjst/yJ2JDFrSUlbLDM2Vrd
	m+q1mY5gyTwaZIui5n2bkvxkooWZ2viWIO/sHKzJp1r6m19A==
X-Gm-Gg: AR+sD12e/traBpSnitozf/WF4FOn+Wditg4LWlMK3AUtSm3pXx6oOpq+XRvdDllaNYP
	Al8fnxbUcO3OEue6JlRL1kQ7nwM3+STYX5I2OyoU8pFrsxCtqUY45O7M2aFCknZZdFXUbz4TFBa
	x5ICuFuhqVaOgpfAcuqAkYQ8lE1V0g9dKjkUPn0avBj9bi+uTG4lOAwsRSYI46iGujYZT+fnHcd
	uNw0kt4rF7g/dOJDwnLXyfRnkDn1oNrPfo6ImN0bWVyqrXMnVyVGetT+bMqsc535WXwJeh7XY/m
	3eQSQMPN9e8+B44zqMD+l5H85nYm3oQPtfcMg0DqtxMOk0p26mReskeIXdU3vgJTyvibNDuiiO3
	ijqotqc5vESBd0Bzsxw==
X-Received: by 2002:a17:90b:5102:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-3966d370333mr1935579a91.3.1787680143539;
        Tue, 25 Aug 2026 10:49:03 -0700 (PDT)
X-Received: by 2002:a17:90b:5102:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-3966d370333mr1935412a91.3.1787680142805;
        Tue, 25 Aug 2026 10:49:02 -0700 (PDT)
Received: from [192.168.1.2] ([122.171.16.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm1188174c88.12.2026.08.25.10.49.00
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 10:49:02 -0700 (PDT)
Message-ID: <3c44d864-e56d-42b1-ad5d-5273c1ceb146@redhat.com>
Date: Tue, 25 Aug 2026 23:18:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS,
 not CONFIG_NR_CPUS_DEFAULT
To: kexec@lists.infradead.org
References: <20260825075043.42041-1-ionut.nechita@windriver.com>
 <20260825075043.42041-2-ionut.nechita@windriver.com>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20260825075043.42041-2-ionut.nechita@windriver.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PBDFRZObvTncawssVnscQqhiGhDpfeLKy55kfXwNkt0_1787680144
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_104909_252982_A26C9D55 
X-CRM114-Status: GOOD (  35.68  )
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



On 25/08/26 1:20 pm, Ionut Nechita (Wind River) wrote:
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
> 
While looking at this function I noticed it does not include
sizeof(Elf64_Ehdr) in the returned size. This value is exposed to
userspace via /sys/kernel/crash_elfcorehdr_size, and userspace tools
(e.g. kexec-tools) may use it to size their elfcorehdr allocation.

The actual allocation in crash_load_segments() adds both components:
kbuf.memsz = pnum * sizeof(Elf64_Phdr);
kbuf.memsz += sizeof(Elf64_Ehdr);

And powerpc's also correctly includes the ELF header:
return sizeof(struct elfhdr) + (phdr_cnt * sizeof(Elf64_Phdr));

So the x86 sysfs value is 64 bytes smaller than the actual in-kernel
allocation. In practice this probably has not caused a failure because
kexec-tools likely has its own sizing logic, but it is a correctness
issue for the interface contract ?

I can send that patch if you prefer not to grow this series further
because this was not introduced by your patch.

> base-commit: 4b18edbd8e70f7e6860d56370f13244896d0f95c

-- 
Regards,
Mukesh Pilaniya


