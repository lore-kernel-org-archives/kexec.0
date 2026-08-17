Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1ACC5B572
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 01:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cPSAjWPvInHMSsU35Wf6vZRvbHjZJV0hLdpnJC/a9SM=; b=jukkAOry/70YawSU4ofAplPO++
	zeXlxAsJ7iV1u+tcOcqNyy1B4KiYZ+387Ab7rbzGlUxccS6kLtuu0gQyk9Md8E4O9aXMNJ+eHD9mN
	NZyUYbxB2icghkwRBdowKcKa+frZKwgI6EmDfXEcK6eB/esPzKCOiQr/2Znm/94nkXY0Wuzxg/eUA
	7sQi5xAQbx2wL2+47ulvoHshw/xXZuVoeJmjeb262CMEYDEMwYB1g6+Lx0+k46iq1INVAzkFp+Q+P
	MOBXDWAPGYR62kw3PzcawX4FJpn0+cmxjGsD9UdSk6nEhbgDTQzYCz9B9IUMglPC4Y63EHS6dpVYQ
	tRDLqNFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvm0S-00000005FhM-2esa;
	Mon, 17 Aug 2026 01:19:16 +0000
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvm0L-00000005Fh1-3eM0
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 01:19:12 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cPSAjWPvInHMSsU35Wf6vZRvbHjZJV0hLdpnJC/a9SM=;
	b=cyNQYIZyRY8Iv6108t9N82UnvTcM+5btoDXylFQ5JzcQnd/36WMsgx1gwXjka8pK8hbLafClv
	n0LOKR1pCRm1rwc8iX/k7hqaDiDameNQMe5l7+nSTBcPPfQ6xYcYDYamiLjdmr87JsvPVhm7Rxa
	A6vnnv0sFlZsP6oMWIc6uxw=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hNZTg05lQz12LHf;
	Mon, 17 Aug 2026 09:08:39 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 7542840538;
	Mon, 17 Aug 2026 09:19:01 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Aug 2026 09:19:00 +0800
Message-ID: <e51a0df8-7519-480d-84a6-22cf96e6d06e@huawei.com>
Date: Mon, 17 Aug 2026 09:18:59 +0800
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260816_181910_598511_1CC0A629 
X-CRM114-Status: GOOD (  25.47  )
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

We should also update the comment in crash_handle_hotplug_event() to
avoid misleading people.

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 4f21fc3b108b..b046c1682aad 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -565,7 +565,7 @@ int crash_check_hotplug_support(void)
  * new list of CPUs and memory. To make changes to the elfcorehdr, it
  * should be large enough to permit a growing number of CPU and Memory
  * resources. One can estimate the elfcorehdr memory size based on
- * NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
+ * NR_CPUS and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
  * excluded from SHA verification by default if the architecture
  * supports crash hotplug.
  */


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
>  	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>  		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
>  	sz *= sizeof(Elf64_Phdr);


