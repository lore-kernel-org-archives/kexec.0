Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A0DC52D71
	for <kexec@archiver.kernel.org>; Fri,  9 Aug 2024 10:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q/g84I18DN66wnRrK/t3kyI7xQ5W7rK4SsQ3Jw/p1LY=; b=EoxR4WaZaOTRU8
	XQuoqB0R/kjzGdFvfx13zDRMWrerYvecSnK9GhIMfZ3lA+nmaFWTbsB6klMrNwqSANRX2wvuWItDb
	JKqwvLYr6geo5Zs0fP9dWGn8/1HIwsiCdMDpoO6FRbBA/HItgfl8aFzDCWJrVgF7dckLAKEzpGSOv
	RwFtZnX1p4gKOzoNDfY6G6pHQrpElA5F4CzgL8ifmbV59B8IPcdzlewo5PZgxN3jXpLCIQZfeslLP
	yAlO+XQPqfySz67oRoAf7CbQw6ojhRgXfoPEmf3zIJ6boXDFOi4dHlt+dx0fbr0+xTDUGdNur1aun
	GhU3CRJOQ81iFwpT6lSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scMf0-0000000Avwv-01nc;
	Fri, 09 Aug 2024 10:15:50 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scMeo-0000000Avqq-1w7T;
	Fri, 09 Aug 2024 10:15:46 +0000
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WgKTk4Tpqz20lGn;
	Fri,  9 Aug 2024 18:12:26 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 7379A18002B;
	Fri,  9 Aug 2024 18:15:25 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 18:15:24 +0800
Message-ID: <abf192cf-e1ba-dd28-93f3-46fd7a07fef1@huawei.com>
Date: Fri, 9 Aug 2024 18:15:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Baoquan He <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<chenjiahao16@huawei.com>, <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	Will Deacon <will@kernel.org>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
 <ZqywtegyIS/YXOVv@MiWiFi-R3L-srv> <ZrJ1JkyDVpRRB_9e@arm.com>
 <ZrJ60vopeGDXFZyK@arm.com> <e01df216-0225-ef49-8eb3-2ccdcb424785@huawei.com>
 <ZrXmqyhalkcY-wpx@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZrXmqyhalkcY-wpx@arm.com>
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_031538_989301_42D50201 
X-CRM114-Status: GOOD (  27.10  )
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



On 2024/8/9 17:51, Catalin Marinas wrote:
> On Thu, Aug 08, 2024 at 03:56:35PM +0800, Jinjie Ruan wrote:
>> On 2024/8/7 3:34, Catalin Marinas wrote:
>>> On Tue, Aug 06, 2024 at 08:10:30PM +0100, Catalin Marinas wrote:
>>>> On Fri, Aug 02, 2024 at 06:11:01PM +0800, Baoquan He wrote:
>>>>> And I don't like the idea crashkernel=,high failure will fallback to
>>>>> attempt in low area, so this looks good to me.
>>>>
>>>> Well, I kind of liked this behaviour. One can specify ,high as a
>>>> preference rather than forcing a range. The arm64 land has different
>>>> platforms with some constrained memory layouts. Such fallback works well
>>>> as a default command line option shipped with distros without having to
>>>> guess the SoC memory layout.
>>>
>>> I haven't tried but it's possible that this patch also breaks those
>>> arm64 platforms with all RAM above 4GB when CRASH_ADDR_LOW_MAX is
>>> memblock_end_of_DRAM(). Here all memory would be low and in the absence
>>> of no fallback, it fails to allocate.
>>>
>>> So, my strong preference would be to re-instate the current behaviour
>>> and work around the infinite loop in a different way.
>>
>> Hi, baoquan, What's your opinion?
>>
>> Only this patch should be re-instate or all the 3 dead loop fix patch?
> 
> Only the riscv64 patch that that removes the ,high reservation fallback
> to ,low. From this series:
> 
> https://lore.kernel.org/r/20240719095735.1912878-1-ruanjinjie@huawei.com/
> 
> the first two fixes look fine (x86_32). The third one (arm32), not sure
> why it's in the series called "crash: Fix x86_32 memory reserve dead
> loop bug". Does it fix a problem on arm32? Anyway, I'm not against it
> getting merged but I'm not maintaining arm32. If the first two patches
> could be merged for 6.11, I think the arm32 one is more of a 6.12
> material (unless it does fix something).
> 
> On the riscv64 patch removing the high->low fallback to avoid the
> infinite loop, I'd rather replace it with something similar to the
> x86_32 fix in the series above. I suggested something in the main if
> block but, looking at the x86_32 fix, for consistency, I think it would
> look better as something like:
> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index d3b4cd12bdd1..64d44a52c011 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -423,7 +423,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
>  			search_end = CRASH_ADDR_LOW_MAX;
>  			search_base = 0;
> -			goto retry;
> +			if (search_end != CRASH_ADDR_HIGH_MAX)
> +				goto retry;
>  		}
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  			crash_size);
> 
> In summary, just replace the riscv64 fix with something along the lines
> of the diff above (or pick whatever you prefer that still keeps the
> fallback).

Hi, Andrew

Could you please help to remove the riscv64 fix from your mm tree as
Catalin suggested? we will give the new patch sooner.

> 
> Thanks.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
