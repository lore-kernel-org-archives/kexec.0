Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C89CD98D6
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 06:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aATu7tVImBgCqv4P2EM9m+x6dmXEraQ/Wp+e4Xtstw4=; b=jIvbIda8jinV3MpfIovTBssbeP
	IZr4M5JgrqVtE9AT9CHEfWhq+gM97uStHEn43sMGpk7ynyHMjHSCMuUdWJ/KNuAGF9IP6jBpu56lX
	/dg5b886LleFPqO2REvMwYIJOXDRbuofXa6wV3ZWe6DksmHBKWNFYXpRoxacphlRZTR52dcqXMR//
	2WoOK95ihI7gr7izELxin/2lP4RkCVwOrVv4J2rZZCHS1NdflRzKnKOjIzwVHMi4zNo976gVV5PwU
	yaSeLxFDxY2E6S/Wpj2MMgoD8c4oFRSzwQ0G3YAL82A5Bv+LbmI3hwc8TlDJzYytzRjekJcfHw6ZP
	WSff3Zbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXCfr-00000006u9s-08ke;
	Wed, 10 Jun 2026 06:44:27 +0000
Received: from canpmsgout12.his.huawei.com ([113.46.200.227])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWUzt-000000032o8-3KuK;
	Mon, 08 Jun 2026 08:06:16 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aATu7tVImBgCqv4P2EM9m+x6dmXEraQ/Wp+e4Xtstw4=;
	b=joffotyX/LhOXzhiBQJ687sy38LBkFUJN+eZBQ6HwEnnv/WXYE9RFRQJPrwqs8ryCNuwygPha
	aAN8S1aw1FDh7M8xsSR8XCsX1aJg2rLh13a7TIeKPo7PJIDFzY3c2nVzw9l2WmLjko13Jw1dYzD
	ObI9uC8v6xFF6F/dj6RUeS4=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gYktX2hLJznTXY;
	Mon,  8 Jun 2026 15:58:12 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A16F40571;
	Mon,  8 Jun 2026 16:06:02 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jun 2026 16:05:59 +0800
Message-ID: <45fa93e6-dbeb-4844-bb19-f36fe642f362@huawei.com>
Date: Mon, 8 Jun 2026 16:05:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/10] riscv: kexec_file: Fix crashk_low_res not
 exclude bug
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
 <20260608073459.3119290-2-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260608073459.3119290-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_010614_492975_BF009FDF 
X-CRM114-Status: GOOD (  15.45  )
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
> As done in commit 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
> and commit 4831be702b95 ("arm64/kexec: Fix missing extra range for
> crashkres_low.") for arm64, while implementing crashkernel=X,[high,low],
> riscv should have excluded the "crashk_low_res" reserved ranges from
> the crash kernel memory to prevent them from being exported through
> /proc/vmcore, and the exclusion would need an extra crash_mem range.
> 
> Just simply tested on qemu with crashkernel=4G with kexec in [1] mentioned
> in [2]. And the second kernel can be started normally.
> 
> 	# dmesg | grep crash
> 	[    0.000000] crashkernel low memory reserved: 0xf8000000 - 0x100000000 (128 MB)
> 	[    0.000000] crashkernel reserved: 0x000000017fe00000 - 0x000000027fe00000 (4096 MB)
> 
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> [1]: https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2
> [2]: https://lore.kernel.org/all/20230726175000.2536220-1-chenjiahao16@huawei.com/
> Fixes: 5882e5acf18d ("riscv: kdump: Implement crashkernel=X,[high,low]")
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>


The below AI reported TOCTOU bug is an existing artifact and completely
unrelated to this fix here. Therefore, we will skip fixing it in this
series to avoid unnecessary noise.

Link:
https://lore.kernel.org/all/20260608074809.EE4201F00893@smtp.kernel.org/

> ---
>  arch/riscv/kernel/machine_kexec_file.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
> index 54e2d9552e93..3f7766057cac 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -61,7 +61,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  	unsigned int nr_ranges;
>  	int ret;
>  
> -	nr_ranges = 1; /* For exclusion of crashkernel region */
> +	nr_ranges = 2; /* For exclusion of crashkernel region */
>  	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
>  
>  	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
> @@ -76,8 +76,16 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  
>  	/* Exclude crashkernel region */
>  	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> -	if (!ret)
> -		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
> +	if (ret)
> +		goto out;
> +
> +	if (crashk_low_res.end) {
> +		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
>  
>  out:
>  	kfree(cmem);


