Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475DBC43334
	for <kexec@archiver.kernel.org>; Tue, 28 Jun 2022 01:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=88YNgAQYVX+N/0VFGFIoVJUnRqQSp3Cophkre7Wnb0o=; b=4TkSvzTEtePqiO3Ri936waFJX5
	LgkXO/xxxZsNR0AGAtWsvfwGepkPMR63xqXG7uD9hyE4uXaoAEjHXLbJMETnd6/lM3EARFkUBc9Eo
	aRo/ieuQ8csKqHKhTGm37Jsj/BRgaWXYdFJrsHCaa99mhSfU/R5Vx6yIQUCDZ/CJKsjkARsNotYpE
	lXyXABu3TzBcgHjq0TE2Nd/nk9WoIds6yIx9sHVytarAGmjFQ/uMRc88scLFJXqGC7YvZnhNZBmoj
	eXnSuQ/dMRZcsdRCulcYtpAA3Uradcs+IkWuVmhkTp9FbEm0tFWJww/ewOzSw8RRw+UYodd/U47hT
	768nKAbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o60Uc-003bMv-B5; Tue, 28 Jun 2022 01:58:18 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o60UT-003bJD-U0; Tue, 28 Jun 2022 01:58:16 +0000
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LX74Y4M2gzkWt6;
	Tue, 28 Jun 2022 09:56:45 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 09:58:04 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 09:58:02 +0800
Subject: Re: [PATCH v2 0/3] arm64: kdump: Function supplement and performance
 optimization
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, Rob Herring
	<robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	<devicetree@vger.kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He
	<bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>, Feng Zhou
	<zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, "Chen
 Zhou" <dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220621124249.1315-1-thunder.leizhen@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <43d991e4-d0b0-1dd9-47ae-761746c20ab0@huawei.com>
Date: Tue, 28 Jun 2022 09:58:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220621124249.1315-1-thunder.leizhen@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_185810_353412_9E1DAD94 
X-CRM114-Status: GOOD (  20.54  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 2022/6/21 20:42, Zhen Lei wrote:
> v1 --> v2:
> 1. Update the commit message of Patch 1, explicitly indicates that "crashkernel=X,high"
>    is specified but "crashkernel=Y,low" is not specified.
> 2. Drop Patch 4-5. Currently, focus on function integrity, performance optimization
>    will be considered in later versions.
> 3. Patch 3 is not mandatory, it's just a cleanup now, although it is a must for patch 4-5.
>    But to avoid subsequent duplication of effort, I'm glad it was accepted.

Hi Catalin:
  Do you have time to review Patch 1-2? Please ignore Patch 3, because now someone has
proposed the following new approach:

https://lore.kernel.org/linux-mm/1656241815-28494-1-git-send-email-guanghuifeng@linux.alibaba.com/T/

> 
> 
> v1:
> After the basic functions of "support reserving crashkernel above 4G on arm64
> kdump"(see https://lkml.org/lkml/2022/5/6/428) are implemented, we still have
> three features to be improved.
> 1. When crashkernel=X,high is specified but crashkernel=Y,low is not specified,
>    the default crash low memory size is provided.
> 2. For crashkernel=X without '@offset', if the low memory fails to be allocated,
>    fall back to reserve region from high memory(above DMA zones).
> 3. If crashkernel=X,high is used, page mapping is performed only for the crash
>    high memory, and block mapping is still used for other linear address spaces.
>    Compared to the previous version:
>    (1) For crashkernel=X[@offset], the memory above 4G is not changed to block
>        mapping, leave it to the next time.
>    (2) The implementation method is modified. Now the implementation is simpler
>        and clearer.
> 
> Zhen Lei (3):
>   arm64: kdump: Provide default size when crashkernel=Y,low is not
>     specified
>   arm64: kdump: Support crashkernel=X fall back to reserve region above
>     DMA zones
>   arm64: kdump: Remove some redundant checks in map_mem()
> 
>  .../admin-guide/kernel-parameters.txt         | 10 ++-----
>  arch/arm64/mm/init.c                          | 28 +++++++++++++++++--
>  arch/arm64/mm/mmu.c                           | 25 ++++++++---------
>  3 files changed, 39 insertions(+), 24 deletions(-)
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
