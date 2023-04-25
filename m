Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0337C77B61
	for <kexec@archiver.kernel.org>; Tue, 25 Apr 2023 13:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:CC:To:From:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aNK3/4YH0/nMmzvdJmFf/ltanh1ENIJyla3BWhVNqbs=; b=1YjWO8lKxwszYb
	gk9FHv5cFxn2qEigivR0eZpGnNKZR23Eqr+5RDlqAaCQ15BMRcLqQkIgvv0wsKc4cTI8RrxvYWe9x
	0MEUsm3iX6o7DMxmvj/lf8Cayja0HJntb0p6VBaROPGwxix5yshcY0wR7Dno+vlIGExfsAkX10rD+
	M4wID86mb7X7CXlFNljULF+FKNrppUE38L7sUiaOXl5MVbPMSFLeV5htMFX8YwNKf/hg94oQXcEqD
	ix9hJ+P0Q6mgJyc3zfGq0N6rWPGmCzHGwFGMUMftvoTXIdX1kpjeUcxbD0PvX3hyO+24TMyjKovpO
	mrwbZ864g8RL7lo9j63g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prIbb-001CVs-1h;
	Tue, 25 Apr 2023 13:21:15 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prIbX-001COm-3D;
	Tue, 25 Apr 2023 13:21:14 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q5MwY6SF8zpT8Q;
	Tue, 25 Apr 2023 21:17:01 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 25 Apr
 2023 21:20:53 +0800
Message-ID: <db4ba964-1c09-1d8a-bfc4-8fe50debfc6c@huawei.com>
Date: Tue, 25 Apr 2023 21:20:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v4 0/2] support allocating crashkernel above 4G
 explicitly on riscv
Content-Language: en-US
From: "chenjiahao (C)" <chenjiahao16@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <bhe@redhat.com>, <thunder.leizhen@huawei.com>,
	<horms@kernel.org>
References: <20230410130553.3226347-1-chenjiahao16@huawei.com>
In-Reply-To: <20230410130553.3226347-1-chenjiahao16@huawei.com>
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_062112_442597_6298EDD6 
X-CRM114-Status: GOOD (  16.79  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


On 2023/4/10 21:05, Chen Jiahao wrote:
> On riscv, the current crash kernel allocation logic is trying to
> allocate within 32bit addressible memory region by default, if
> failed, try to allocate without 4G restriction.
>
> In need of saving DMA zone memory while allocating a relatively large
> crash kernel region, allocating the reserved memory top down in
> high memory, without overlapping the DMA zone, is a mature solution.
> Hence this patchset introduces the parameter option crashkernel=X,[high,low].
>
> One can reserve the crash kernel from high memory above DMA zone range
> by explicitly passing "crashkernel=X,high"; or reserve a memory range
> below 4G with "crashkernel=X,low". Besides, there are few rules need
> to take notice:
> 1. "crashkernel=X,[high,low]" will be ignored if "crashkernel=size"
>     is specified.
> 2. "crashkernel=X,low" is valid only when "crashkernel=X,high" is passed
>     and there is enough memory to be allocated under 4G.
> 3. When allocating crashkernel above 4G and no "crashkernel=X,low" is
>     specified, a 128M low memory will be allocated automatically for
>     swiotlb bounce buffer.
> See Documentation/admin-guide/kernel-parameters.txt for more information.
>
> To verify loading the crashkernel, adapted kexec-tools is attached below:
> https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2
>
> Following test cases have been performed as expected:
> 1) crashkernel=256M                          //low=256M
> 2) crashkernel=1G                            //low=1G
> 3) crashkernel=4G                            //high=4G, low=128M(default)
> 4) crashkernel=4G crashkernel=256M,high      //high=4G, low=128M(default), high is ignored
> 5) crashkernel=4G crashkernel=256M,low       //high=4G, low=128M(default), low is ignored
> 6) crashkernel=4G,high                       //high=4G, low=128M(default)
> 7) crashkernel=256M,low                      //low=0M, invalid
> 8) crashkernel=4G,high crashkernel=256M,low  //high=4G, low=256M
> 9) crashkernel=4G,high crashkernel=4G,low    //high=0M, low=0M, invalid
> 10) crashkernel=512M@0xd0000000              //low=512M
> 11) crashkernel=1G@0xe0000000                //high=0M, low=0M, no enough low memory, failed
>
> Changes since [v4]:
> 1. Update some imprecise code comments for cmdline parsing.
>
> Changes since [v3]:
> 1. Update to print warning and return explicitly on failure when
>     crashkernel=size@offset is specified. Not changing the result
>     in this case but making the logic more straightforward.
> 2. Some minor cleanup.
>
> Changes since [v2]:
> 1. Update the allocation logic to ensure the high crashkernel
>     region is reserved strictly above dma32_phys_limit.
> 2. Clean up some minor format problems.
>
> Chen Jiahao (2):
>    riscv: kdump: Implement crashkernel=X,[high,low]
>    docs: kdump: Update the crashkernel description for riscv
>
>   .../admin-guide/kernel-parameters.txt         | 15 ++--
>   arch/riscv/kernel/setup.c                     |  5 ++
>   arch/riscv/mm/init.c                          | 71 +++++++++++++++++--
>   3 files changed, 79 insertions(+), 12 deletions(-)

Hi folks,

The current version has fix all problems up-to-date, please let me know
if there is any other bug, or somewhere not quiet correct. Thanks for
looking into this.

Best Regards,
Jiahao


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
