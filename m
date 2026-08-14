Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4FEC5CFCF
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 02:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mwpdohk4jKRRCU0fhMPoWPUNHIzxG8Q/HSRqbYJfoE8=; b=jyh2TUnbuW1BZM1BC98lkRf+mk
	4+9SP9ebHDeqJ2eB4tvbn+fF+tuQa4/ykshlJ+2jMyg62Yzta8XEQahYYNZbwSMel2snTsTfX3M1d
	IWrnJuZtFpGaRoBJCn1flL1tVfv69w8d6Kk/yXMG3NGIs14uvThIHw+Qb8HHV9TRA2mdPPA6q8Obo
	ViONuCTh/cpjyndsjFVJ5yVx0Oxf+AooIY71oavuPehWpyKrmRLhMV5Rnw6Car5kknN48oCeXmWGS
	eHsY3p0oeC3fZ5I63PrnkaxYA/Xx4Nh3UK20vaLBrNXcRWR8lCTTtmxUa+YvRlr+LhCB3mJiqpCCk
	bPMuLonQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuhJH-00000001pnZ-0Juk;
	Fri, 14 Aug 2026 02:06:15 +0000
Received: from canpmsgout07.his.huawei.com ([113.46.200.222])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuhJD-00000001pnE-2qF8
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 02:06:14 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mwpdohk4jKRRCU0fhMPoWPUNHIzxG8Q/HSRqbYJfoE8=;
	b=fOjuEgzbIZltTeohJRJQJskoEbJ8xtigAjIMjnoFV8DQpac8gSjm1cZVexKXQZ6LPqnJ0fKUl
	n8ql50vUgzSgL87hPLW3tECfoV/CVDIByuEeu8YVPc84adNYhRVOPqL7+rVeqw9H1NSqX3+Qprh
	kzn6aG3EDLMG/03o8qhSHYg=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hLlg20pPLzLlTg;
	Fri, 14 Aug 2026 09:55:26 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 135E1402AB;
	Fri, 14 Aug 2026 10:06:04 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Aug 2026 10:06:00 +0800
Message-ID: <56cd995e-d5d2-4779-9dd5-f85948876205@huawei.com>
Date: Fri, 14 Aug 2026 10:05:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS, not
 CONFIG_NR_CPUS_DEFAULT
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	<x86@kernel.org>, <kexec@lists.infradead.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <bhe@redhat.com>,
	<hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20260812170433.533845-1-ionut.nechita@windriver.com>
 <20260812170433.533845-2-ionut.nechita@windriver.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260812170433.533845-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_190612_378770_B3C97A5A 
X-CRM114-Status: GOOD (  22.01  )
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



在 2026/8/13 1:04, Ionut Nechita (Wind River) 写道:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> kexec_file_load(2) fails with -EINVAL when loading a crash kernel on a
> machine whose number of possible CPUs exceeds CONFIG_NR_CPUS_DEFAULT,
> even though the classic kexec_load(2) path succeeds on the same machine.
> 
> With CONFIG_CRASH_HOTPLUG=y the elfcorehdr segment is over-allocated so
> it can be updated in place on CPU/memory hotplug. crash_load_segments()

Right

> and arch_crash_get_elfcorehdr_size() compute that reservation from
> CONFIG_NR_CPUS_DEFAULT:
> 
> 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> 		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
> 	else
> 		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
> 
> However the actual header produced by crash_prepare_elf64_headers()
> contains one PT_NOTE per *possible* CPU, i.e. num_possible_cpus(), which
> is bounded by CONFIG_NR_CPUS, not by CONFIG_NR_CPUS_DEFAULT.  On configs
> that raise CONFIG_NR_CPUS above the arch default while leaving
> CONFIG_NR_CPUS_DEFAULT untouched (e.g. CONFIG_NR_CPUS=256,
> CONFIG_NR_CPUS_DEFAULT=64 on x86_64 without MAXSMP), a system with more
> than ~CONFIG_NR_CPUS_DEFAULT possible CPUs builds a header whose bufsz
> exceeds the reserved, page-aligned memsz.  sanity_check_segment_list()
> then rejects the image:
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
> 	CONFIG_NR_CPUS_RANGE_BEGIN=2
> 	CONFIG_NR_CPUS_RANGE_END=512
> 	CONFIG_NR_CPUS_DEFAULT=64
> 	CONFIG_NR_CPUS=256
> 
> kexec -p -s fails with "kexec_file_load failed: Invalid argument".
> Reducing the possible CPU count below the page-rounding threshold
> (e.g. 72 via firmware) makes it succeed, confirming the reservation is
> the limiting factor.
> 
> Reserve the elfcorehdr for CONFIG_NR_CPUS, the compile-time upper bound
> of num_possible_cpus(), so the reservation always covers the header that
> is actually generated.
> 
> Fixes: a72bbec70da2 ("crash: hotplug support for kexec_load()")
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>  arch/x86/kernel/crash.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e681ec9cf1dc8..e6f23933a6df2 100644
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

Could we just use num_possible_cpus()?

Either way, I think it's okay.

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>  		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
>  	sz *= sizeof(Elf64_Phdr);


