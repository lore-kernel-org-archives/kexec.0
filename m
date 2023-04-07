Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448C3C6FD1D
	for <kexec@archiver.kernel.org>; Fri,  7 Apr 2023 12:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=H8gd7W1DZtl23+uEbBpXuWOdsi314UByYbFKRc8K8Pg=; b=Af4xQrkO4CgZ9ij6dRS8FZmKnF
	RHGs+x61nSkfR9kfj4YKjK9NkzBiKdbPkmVo+a4JCjG1EV+T8Y1axARcxoaYu6fsczDAq/MVyW+sJ
	ECH341jWrVDHRe5wO2Ls+iZtXZ41CiiUrRb8S72Z7z4sc3Nsr6vdcK2KsxK64uOEaHK1BCL/zryBv
	Q+AWYL+rf+5kY7Z7CnjSmJMrsgJ36tVwk6rOyaXOk1JURH3t6AqJd8s2ZbI8c/hyxi6aJKtPPzwnX
	rOTH/LiTfkmkOy80CPBU4uDaQgMLTFBRrz31GoFha2KV4anibr2u5U1ymWQnItNMx0yEL6YrciDQu
	UWSR3NoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pklgO-00AEJI-1P;
	Fri, 07 Apr 2023 12:59:12 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pklgK-00AEHx-12;
	Fri, 07 Apr 2023 12:59:10 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PtJHY3gVrzSmPS;
	Fri,  7 Apr 2023 20:55:05 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 7 Apr 2023 20:58:54 +0800
Subject: Re: [PATCH -next v3 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
To: Simon Horman <horms@kernel.org>, Chen Jiahao <chenjiahao16@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <bhe@redhat.com>
References: <20230406220206.3067006-1-chenjiahao16@huawei.com>
 <20230406220206.3067006-2-chenjiahao16@huawei.com>
 <ZDAGi2/+1q0oEUZ5@kernel.org>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ee6434f7-8e94-bae5-7d63-4b9bce3aec24@huawei.com>
Date: Fri, 7 Apr 2023 20:58:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZDAGi2/+1q0oEUZ5@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_055908_755270_7B5272BB 
X-CRM114-Status: GOOD (  19.12  )
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



On 2023/4/7 20:03, Simon Horman wrote:
> On Fri, Apr 07, 2023 at 06:02:05AM +0800, Chen Jiahao wrote:
>> On riscv, the current crash kernel allocation logic is trying to
>> allocate within 32bit addressible memory region by default, if
>> failed, try to allocate without 4G restriction.
>>
>> In need of saving DMA zone memory while allocating a relatively large
>> crash kernel region, allocating the reserved memory top down in
>> high memory, without overlapping the DMA zone, is a mature solution.
>> Here introduce the parameter option crashkernel=X,[high,low].
>>
>> One can reserve the crash kernel from high memory above DMA zone range
>> by explicitly passing "crashkernel=X,high"; or reserve a memory range
>> below 4G with "crashkernel=X,low".
>>
>> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> 
> ...
> 
>> @@ -1180,14 +1206,37 @@ static void __init reserve_crashkernel(void)
>>  		return;
>>  	}
>>  
>> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>>  				&crash_size, &crash_base);
>> -	if (ret || !crash_size)
>> +	if (ret == -ENOENT) {
>> +		/*
>> +		 * crashkernel=X,[high,low] can be specified or not, but
>> +		 * invalid value is not allowed.
> 
> nit: Perhaps something like this would be easier to correlate with the
>      code that follows:
> 
> 		/* Fallback to crashkernel=X,[high,low] */

The description "crashkernel=X,[high,low] can be specified or not" is not
correct, because crashkernel=X,high must be specified when walking into this
branch. So use Simon's comments or copy arm64's comments(it's written for
parse_crashkernel_low()).

> 
> 
>> +		 */
>> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
>> +		if (ret || !crash_size)
>> +			return;
>> +
>> +		/*
>> +		 * crashkernel=Y,low is valid only when crashkernel=X,high
>> +		 * is passed and high memory is reserved successful.
> 
> nit: s/successful/successfully/

Seems like the whole "and high memory is reserved successful" needs to be deleted.
Only the dependency between the two boot options should be described here,
regardless of whether their memory is successfully allocated.

> 
>> +		 */
>> +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
>> +		if (ret == -ENOENT)
>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +		else if (ret)
>> +			return;
>> +
>> +		search_start = search_low_max;
>> +	} else if (ret || !crash_size) {
>> +		/* Invalid argument value specified */
>>  		return;
>> +	}
> 
> ...
> .
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
