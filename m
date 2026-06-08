Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814B4CD98D0
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 06:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1O0W+PMFaImUEHS11h0qPr/2bHJpUyc1ctnF0elS/cQ=; b=VagxPR2n6572Sldc+1GtTNlAHx
	BeqdWCS0HXPl+PhCAGiP4trZHYLmxKjE69fMNTLiQG5MbN5cfUDlTJfTcZiAcZWG4EKRRLnhDkAN6
	4q9jvPpLYM2FUuwzABh0/2QUCq97RHx6K5pkez3dF8TOOJXmsP9wQNlvdfpcUrrvM4nj/R7qXM2PS
	tVbuBqSpj8XinzEjYo99dt8rEov0fBgYzMEBAXBm++1dHqS8EWeMGIEiDBn7UYcSoEDvRRdW/WN47
	j4csBCKU52w6hbPlCz9cieIUhdqjGi5J+I1zu/IuqyrFlWts70aRxVxixMJyLQL+TRBBd3znpW9I0
	32a52YJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXCfr-00000006uAG-1KDO;
	Wed, 10 Jun 2026 06:44:27 +0000
Received: from canpmsgout12.his.huawei.com ([113.46.200.227])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWV1s-000000033YD-0OSO;
	Mon, 08 Jun 2026 08:08:18 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1O0W+PMFaImUEHS11h0qPr/2bHJpUyc1ctnF0elS/cQ=;
	b=ngvO5U+Ohxn3umzASf6kJP2ao1O9uIHiDkFzKhI8AJYyg2zqXO9PDGtwpygvXHUrjwDUqKDRw
	ZSjEBkAgKLP5QhHH+29zOBe7hN9fmcJDxbOQ9rsbVSqLB6TkIBwxUiIA+jis3a7Beccw0Eb6Bv1
	IXRRaH15EfFKmS7gS/058Gg=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gYkww4rLZznTWn;
	Mon,  8 Jun 2026 16:00:16 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E864C40565;
	Mon,  8 Jun 2026 16:08:06 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jun 2026 16:08:03 +0800
Message-ID: <f26bc61d-14ad-450d-bdfa-59b039ae660c@huawei.com>
Date: Mon, 8 Jun 2026 16:08:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 06/10] riscv: kexec_file: Use crash_prepare_headers()
 helper to simplify code
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <peterz@infradead.org>,
	<feng.tang@linux.alibaba.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <kuba@kernel.org>,
	<lirongqing@baidu.com>, <ebiggers@kernel.org>, <paulmck@kernel.org>,
	<leitao@debian.org>, <coxu@redhat.com>, <Liam.Howlett@oracle.com>,
	<ryan.roberts@arm.com>, <osandov@fb.com>, <jbohac@suse.cz>,
	<cfsworks@gmail.com>, <tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
	<ritesh.list@gmail.com>, <adityag@linux.ibm.com>, <liaoyuanhong@vivo.com>,
	<seanjc@google.com>, <fuqiang.wang@easystack.cn>, <ardb@kernel.org>,
	<chenjiahao16@huawei.com>, <guoren@kernel.org>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20260608073459.3119290-1-ruanjinjie@huawei.com>
 <20260608073459.3119290-7-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260608073459.3119290-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_010816_847713_02A73C73 
X-CRM114-Status: GOOD (  19.20  )
X-Mailman-Approved-At: Tue, 09 Jun 2026 23:44:17 -0700
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



On 6/8/2026 3:34 PM, Jinjie Ruan wrote:
> Use the newly introduced crash_prepare_headers() function to replace
> the existing prepare_elf_headers(), allocate cmem and exclude crash kernel
> memory in the crash core, which reduce code duplication.
> 
> Only the following two architecture functions need to be implemented:
> - arch_get_system_nr_ranges(). Call get_nr_ram_ranges_callback()
>   to pre-counts the max number of memory ranges.
> 
> - arch_crash_populate_cmem(). Use prepare_elf64_ram_headers_callback()
>   to collects the memory ranges and fills them into cmem.


The below AI reported TOCTOU bug is an existing artifact and completely
unrelated to the core CMA implementation introduced here. Therefore, we
will skip fixing it in this series to avoid unnecessary noise.

Link:
https://lore.kernel.org/all/20260608075420.8C5871F00893@smtp.kernel.org/

> 
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: Guo Ren <guoren@kernel.org>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/riscv/kernel/machine_kexec_file.c | 47 +++++++-------------------
>  1 file changed, 12 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
> index 3f7766057cac..439cbc50dfa6 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -44,6 +44,15 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>  	return 0;
>  }
>  
> +unsigned int arch_get_system_nr_ranges(void)
> +{
> +	unsigned int nr_ranges = 2; /* For exclusion of crashkernel region */
> +
> +	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> +
> +	return nr_ranges;
> +}
> +
>  static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>  {
>  	struct crash_mem *cmem = arg;
> @@ -55,41 +64,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>  	return 0;
>  }
>  
> -static int prepare_elf_headers(void **addr, unsigned long *sz)
> +int arch_crash_populate_cmem(struct crash_mem *cmem)
>  {
> -	struct crash_mem *cmem;
> -	unsigned int nr_ranges;
> -	int ret;
> -
> -	nr_ranges = 2; /* For exclusion of crashkernel region */
> -	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> -
> -	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
> -	if (!cmem)
> -		return -ENOMEM;
> -
> -	cmem->max_nr_ranges = nr_ranges;
> -	cmem->nr_ranges = 0;
> -	ret = walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
> -	if (ret)
> -		goto out;
> -
> -	/* Exclude crashkernel region */
> -	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> -	if (ret)
> -		goto out;
> -
> -	if (crashk_low_res.end) {
> -		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
> -
> -out:
> -	kfree(cmem);
> -	return ret;
> +	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
>  }
>  
>  static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
> @@ -281,7 +258,7 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
>  	if (image->type == KEXEC_TYPE_CRASH) {
>  		void *headers;
>  		unsigned long headers_sz;
> -		ret = prepare_elf_headers(&headers, &headers_sz);
> +		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
>  		if (ret) {
>  			pr_err("Preparing elf core header failed\n");
>  			goto out;


