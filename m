Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A774CD37B0
	for <kexec@archiver.kernel.org>; Mon, 18 Sep 2023 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jil25OVBXruQXf49HmuVPPKobsEFLaiEZCB+wSCIYLM=; b=tSJrst7vhzs+K9FIcqMvokdxDr
	+mJnbdVDHA3oJjEuP08Xvq0Hvv82n1rC/64Jyjvu4yREA7eJSkKOQ/tWTFL+U0L+dkvcW6xWfhznn
	sPBemRFKTdYeru/tu1eTJj92Zj9KSa1+WCOF4SV7/LnhrmWYKk+ddg+MtkojSBdWAKtBVniGHunrv
	2j/n/XF9Nof7UQriGs2mUhoc0CNTb3Rbb22Gb+18YnMLbuSwoowEHvjI1yr4V9mRAvZuuoh3nxqXb
	4HTVZDJo/cVNEodEzbEV5i6LLIQraA1D1YfqlUnXgOh+o2EXsthx7T7DomK7IMxIvg00vhpmq25C5
	oyoJ1fLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiDZS-00FRTM-1U;
	Mon, 18 Sep 2023 12:41:46 +0000
Received: from [45.249.212.51] (helo=dggsgout11.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiDZO-00FRMH-2S;
	Mon, 18 Sep 2023 12:41:44 +0000
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rq4D03gRtz4f3lDf;
	Mon, 18 Sep 2023 20:41:20 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgD3jd1wRQhlbw0hAw--.6340S3;
	Mon, 18 Sep 2023 20:41:22 +0800 (CST)
Subject: Re: [PATCH v3 3/9] crash_core: change parse_crashkernel() to support
 crashkernel=,high|low parsing
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, thunder.leizhen@huawei.com,
 catalin.marinas@arm.com, chenjiahao16@huawei.com, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 x86@kernel.org
References: <20230914033142.676708-1-bhe@redhat.com>
 <20230914033142.676708-4-bhe@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <69917722-0788-30f4-b28e-cb0a41881f35@huaweicloud.com>
Date: Mon, 18 Sep 2023 20:41:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230914033142.676708-4-bhe@redhat.com>
Content-Language: en-US
X-CM-TRANSID: gCh0CgD3jd1wRQhlbw0hAw--.6340S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4UCF4UCr1UKFy3Xw15XFb_yoW5Aw1Dpr
	yrCa15GrW7JFn7Kw1fAr9xurWrAw40ya429F9akryrAF9rtFnxKr1UWw1UWr1j9r98CFW2
	yFWFvFZxKa4jv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_054143_274587_4C53B78A 
X-CRM114-Status: GOOD (  21.15  )
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



On 2023/9/14 11:31, Baoquan He wrote:
> Now parse_crashkernel() is a real entry point for all kinds of
> crahskernel parsing on any architecture.
> 
> And wrap the crahskernel=,high|low handling inside
> CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION ifdeffery scope.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/crash_core.h |  6 ++++++
>  kernel/crash_core.c        | 36 +++++++++++++++++++++++++++++++++---
>  2 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 6156355ef831..d8050a7eab01 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -79,6 +79,12 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len);
>  void final_note(Elf_Word *buf);
>  
> +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE  (128UL << 20)
> +#endif
> +#endif
> +
>  int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base,
>  		unsigned long long *low_size, bool *high);
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index cca1d76e8255..dce2f5874fea 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -283,6 +283,9 @@ static int __init __parse_crashkernel(char *cmdline,
>  /*
>   * That function is the entry point for command line parsing and should be
>   * called from the arch-specific code.
> + *
> + * If crashkernel=,high|low is supported on architecture, non-NULL values
> + * should be passed to parameters 'low_size' and 'high'.
>   */
>  int __init parse_crashkernel(char *cmdline,
>  			     unsigned long long system_ram,
> @@ -296,10 +299,37 @@ int __init parse_crashkernel(char *cmdline,
>  	/* crashkernel=X[@offset] */
>  	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
>  				crash_base, NULL);
> -	if (!high)
> -		return ret;
> +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +	/*
> +	 * If non-NULL 'high' passed in and no normal crashkernel
> +	 * setting detected, try parsing crashkernel=,high|low.
> +	 */
> +	if (high && ret == -ENOENT) {
> +		ret = __parse_crashkernel(cmdline, 0, crash_size,
> +				crash_base, suffix_tbl[SUFFIX_HIGH]);
> +		if (ret || !*crash_size)
> +			return -EINVAL;
>  
> -	return 0;
> +		/*
> +		 * crashkernel=Y,low can be specified or not, but invalid value
> +		 * is not allowed.
> +		 */
> +		ret = __parse_crashkernel(cmdline, 0, low_size,
> +				crash_base, suffix_tbl[SUFFIX_LOW]);
> +		if (ret == -ENOENT) {
> +			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +			ret = 0;
> +		} else if (ret) {
> +			return ret;
> +		}
> +
> +		*high = true;
> +	}
> +#endif
> +	if (!*crash_size)
> +		ret = -EINVAL;
> +
> +	return ret;
>  }
>  
>  int __init parse_crashkernel_high(char *cmdline,
> 

-- 
Regards,
  Zhen Lei


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
