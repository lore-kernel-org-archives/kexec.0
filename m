Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9D8E67493
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 03:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IZ6SmTX3wd//KgfDA8IIueZjyTIBmtbz4jb/4A9XymA=; b=0INny/DFnMER0p
	X1oEK8qpic0lBBg7c+G99AIlSY6mj2c5bOErZYIi6LCI5OnRYp0b63zQhIi2DgFTibvpNJD5clOCE
	wwDeEcS/j0wMF+sc3Ea8YNr/Epkc+sav2b1Ym83mGaU76bUyGPLC0zpzyN5cqBNhcTktLvEFsoriE
	xTq7pjta34jqBL1FhTCG0rFM2ZbRvZqYk2xaycN+xc294AjLvVrE9sC9HQm+NpkEnffaAtYcoR/th
	1p4uzKmUMEDMurTZhKfroPXiLj7Wtkp00EPVyxVuYsgaaFk9VOBVvBCkEr36BaSa+6SugzBJR5ABb
	lTwMjBbZ0uIhli9jH1bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6iUr-00000005g5h-3qp7;
	Fri, 01 Nov 2024 03:38:49 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6iUp-00000005g3e-0MzN
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 03:38:49 +0000
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XfmgD4GmKz1HLgC;
	Fri,  1 Nov 2024 11:34:00 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id EF921140136;
	Fri,  1 Nov 2024 11:38:30 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Nov 2024 11:38:30 +0800
Message-ID: <f79d2587-2588-598f-f9b2-2e3548067d92@huawei.com>
Date: Fri, 1 Nov 2024 11:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] fs/proc: Fix compile warning about variable
 'vmcore_mmap_ops'
Content-Language: en-US
To: Qi Xi <xiqi2@huawei.com>, <bobo.shaobowang@huawei.com>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <holzheu@linux.vnet.ibm.com>,
	<akpm@linux-foundation.org>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
References: <20241031185235.8bb482766ab10d2ab19fd3f6@linux-foundation.org>
 <20241101032306.8344-1-xiqi2@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241101032306.8344-1-xiqi2@huawei.com>
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200008.china.huawei.com (7.202.181.35)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_203847_340341_0231ED15 
X-CRM114-Status: GOOD (  12.97  )
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



On 2024/11/1 11:23, Qi Xi wrote:
> When build with !CONFIG_MMU, the variable 'vmcore_mmap_ops'
> is defined but not used:
> 
>>> fs/proc/vmcore.c:458:42: warning: unused variable 'vmcore_mmap_ops'
>      458 | static const struct vm_operations_struct vmcore_mmap_ops = {
> 
> v2: use ifdef instead of __maybe_unused

Changelogs should go after the '---' line, otherwise they
end up in the git history.

> 
> Fixes: 9cb218131de1 ("vmcore: introduce remap_oldmem_pfn_range()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/lkml/202410301936.GcE8yUos-lkp@intel.com/
> Signed-off-by: Qi Xi <xiqi2@huawei.com>
> ---
>  fs/proc/vmcore.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 1fb213f379a5..9ed1f6902c8f 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -455,10 +455,6 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
>  #endif
>  }
>  
> -static const struct vm_operations_struct vmcore_mmap_ops = {
> -	.fault = mmap_vmcore_fault,
> -};
> -
>  /**
>   * vmcore_alloc_buf - allocate buffer in vmalloc memory
>   * @size: size of buffer
> @@ -486,6 +482,11 @@ static inline char *vmcore_alloc_buf(size_t size)
>   * virtually contiguous user-space in ELF layout.
>   */
>  #ifdef CONFIG_MMU
> +
> +static const struct vm_operations_struct vmcore_mmap_ops = {
> +	.fault = mmap_vmcore_fault,
> +};
> +
>  /*
>   * remap_oldmem_pfn_checked - do remap_oldmem_pfn_range replacing all pages
>   * reported as not being ram with the zero page.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
