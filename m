Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF39CD98D3
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 06:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kUCelmckjBNi0e5wGpkpyLLlcIgr+oD3Lo6ndz5cChg=; b=rmPAj117bldA9/ITD+y7SSQtjc
	FOX5HnNvHsGw+Pl42m9RQzINnN5sREWngq6dqRGMsWWb9MgpFGifM79jT412OGfLzLrh4Xjj5A0cT
	+zLo44f7oHWQ5rXyprTuSpQfRkLvugUQ1GDBHDUbvPxEjgFjDwfHfNsj6xiNY2wVkTKIIe12bVUeW
	hDxEdf9wKdAUp0+ViU/hZyzvWgjbUbv5GMPbCRTZJ1zHNurKbxkRE7AZBH8nXeo0jEZpnGQ9wWhMn
	q5YsEFnEOLGaPJvPUt5u60Ul3ugrOnTCdNwQ/bnfa+RFhqB++9UnntR4kkT82g4V7ymltS5NJChFu
	j99CmYrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXCfr-00000006uBE-23sn;
	Wed, 10 Jun 2026 06:44:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWVFP-0000000351c-0FCO;
	Mon, 08 Jun 2026 08:22:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=kUCelmckjBNi0e5wGpkpyLLlcIgr+oD3Lo6ndz5cChg=; b=LQjMsgUgWnKOCE3Pt3+ek6d3cY
	vPKyxQYZ4ZjW0I7UeADku/qDN5zujebNy+LyrkXJxcG2vzC+ABVYdYBqEG8StusS5rPlxd86f/xKg
	ge754uTrPUYn8sPxd+4oOqoW13SAa+QyLTPKBkLWKHZxHSHUvTHnwaAPKvYnL4yx4iPMz3fA4dwl5
	TbMha0WLBZ9bt+JiyONeDyfEbZ4CAUzCaATj4BmmIXntr5zjZy7iAabpT21UOT7/gldKkjQGEhYho
	FM7U4P4sa/7RArh3IiJoqCuchWsHbrBw5CPDJOsDrTChHMqgVxCDMuwT7JI4lyEb24WYdjdaW5aUe
	kohABiYw==;
Received: from canpmsgout03.his.huawei.com ([113.46.200.218])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWVFK-00000000i1c-07D1;
	Mon, 08 Jun 2026 08:22:13 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kUCelmckjBNi0e5wGpkpyLLlcIgr+oD3Lo6ndz5cChg=;
	b=eGqvnHevvIsFCKHXou9Wr2LhFErNm58FMYvC1yhJxjBMAr9+QXaB8DVv09sIJciMWm3DBH+VI
	9lskGYvktV7G3Xv7h/xgG7ALoUr7BkW9dZEF+Rgr2Uo3d3bEWHpwt37fAJKzAQHbKl57ch3GF2s
	VuggWBK/t9vp5qtGmjfZREo=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gYlDy4F5XzpTK2;
	Mon,  8 Jun 2026 16:14:10 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id B5EB0203AC;
	Mon,  8 Jun 2026 16:21:57 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jun 2026 16:21:54 +0800
Message-ID: <005cff45-895f-40f4-b0ae-62744ce74643@huawei.com>
Date: Mon, 8 Jun 2026 16:21:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 05/10] x86: kexec_file: Use crash_prepare_headers()
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
 <20260608073459.3119290-6-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260608073459.3119290-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_092211_662605_26467C64 
X-CRM114-Status: GOOD (  25.70  )
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
> Only the following three architecture functions need to be implemented:
> - arch_get_system_nr_ranges(). Call get_nr_ram_ranges_callback()
>   to pre-count the max number of memory ranges.
> 
> - arch_crash_populate_cmem(). Use prepare_elf64_ram_headers_callback()
>   to collect the memory ranges and fills them into cmem.
> 
> - arch_crash_exclude_ranges(). Exclude the low 1M for x86.
> 
> By the way, remove the unused "nr_mem_ranges" in
> arch_crash_handle_hotplug_event().

The below AI reported TOCTOU bug is an existing artifact and completely
unrelated to the reowork here. Therefore, we will skip fixing it in this
series to avoid unnecessary noise.

Link:
https://lore.kernel.org/all/20260608074748.58E8E1F00893@smtp.kernel.org/

> 
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/x86/kernel/crash.c | 89 +++++------------------------------------
>  1 file changed, 11 insertions(+), 78 deletions(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index cd796818d94d..cb2ce7acfec4 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -153,16 +153,8 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>  	return 0;
>  }
>  
> -/* Gather all the required information to prepare elf headers for ram regions */
> -static struct crash_mem *fill_up_crash_elf_data(void)
> +unsigned int arch_get_system_nr_ranges(void)
>  {
> -	unsigned int nr_ranges = 0;
> -	struct crash_mem *cmem;
> -
> -	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> -	if (!nr_ranges)
> -		return NULL;
> -
>  	/*
>  	 * Exclusion of crash region, crashk_low_res and/or crashk_cma_ranges
>  	 * may cause range splits. So add extra slots here.
> @@ -177,49 +169,16 @@ static struct crash_mem *fill_up_crash_elf_data(void)
>  	 * But in order to lest the low 1M could be changed in the future,
>  	 * (e.g. [start, 1M]), add a extra slot.
>  	 */
> -	nr_ranges += 3 + crashk_cma_cnt;
> -	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
> -	if (!cmem)
> -		return NULL;
> -
> -	cmem->max_nr_ranges = nr_ranges;
> +	unsigned int nr_ranges = 3 + crashk_cma_cnt;
>  
> -	return cmem;
> +	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> +	return nr_ranges;
>  }
>  
> -/*
> - * Look for any unwanted ranges between mstart, mend and remove them. This
> - * might lead to split and split ranges are put in cmem->ranges[] array
> - */
> -static int elf_header_exclude_ranges(struct crash_mem *cmem)
> +int arch_crash_exclude_ranges(struct crash_mem *cmem)
>  {
> -	int ret = 0;
> -	int i;
> -
>  	/* Exclude the low 1M because it is always reserved */
> -	ret = crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
> -	if (ret)
> -		return ret;
> -
> -	/* Exclude crashkernel region */
> -	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> -	if (ret)
> -		return ret;
> -
> -	if (crashk_low_res.end)
> -		ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
> -					      crashk_low_res.end);
> -	if (ret)
> -		return ret;
> -
> -	for (i = 0; i < crashk_cma_cnt; ++i) {
> -		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
> -					      crashk_cma_ranges[i].end);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> +	return crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
>  }
>  
>  static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
> @@ -233,35 +192,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>  	return 0;
>  }
>  
> -/* Prepare elf headers. Return addr and size */
> -static int prepare_elf_headers(void **addr, unsigned long *sz,
> -			       unsigned long *nr_mem_ranges)
> +int arch_crash_populate_cmem(struct crash_mem *cmem)
>  {
> -	struct crash_mem *cmem;
> -	int ret;
> -
> -	cmem = fill_up_crash_elf_data();
> -	if (!cmem)
> -		return -ENOMEM;
> -
> -	ret = walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
> -	if (ret)
> -		goto out;
> -
> -	/* Exclude unwanted mem ranges */
> -	ret = elf_header_exclude_ranges(cmem);
> -	if (ret)
> -		goto out;
> -
> -	/* Return the computed number of memory ranges, for hotplug usage */
> -	*nr_mem_ranges = cmem->nr_ranges;
> -
> -	/* By default prepare 64bit headers */
> -	ret = crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
> -
> -out:
> -	vfree(cmem);
> -	return ret;
> +	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
>  }
>  #endif
>  
> @@ -419,7 +352,8 @@ int crash_load_segments(struct kimage *image)
>  				  .buf_max = ULONG_MAX, .top_down = false };
>  
>  	/* Prepare elf headers and add a segment */
> -	ret = prepare_elf_headers(&kbuf.buffer, &kbuf.bufsz, &pnum);
> +	ret = crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &kbuf.buffer,
> +				    &kbuf.bufsz, &pnum);
>  	if (ret)
>  		return ret;
>  
> @@ -512,7 +446,6 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>  void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>  {
>  	void *elfbuf = NULL, *old_elfcorehdr;
> -	unsigned long nr_mem_ranges;
>  	unsigned long mem, memsz;
>  	unsigned long elfsz = 0;
>  
> @@ -530,7 +463,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>  	 * memory resources.
>  	 */
> -	if (prepare_elf_headers(&elfbuf, &elfsz, &nr_mem_ranges)) {
> +	if (crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
>  		pr_err("unable to create new elfcorehdr");
>  		goto out;
>  	}


