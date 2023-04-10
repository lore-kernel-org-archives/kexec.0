Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD20C77B61
	for <kexec@archiver.kernel.org>; Mon, 10 Apr 2023 10:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NMQY6dsdrarUv9dxjC4F0oHucRfg6EqF4Ik6JZHM3so=; b=IeQWcSX1p7vbDa
	tW56FbWr7lQvYOt7FYX+NX016Z4DxG7OrHagG22XemCn1rQa/srEP4EWZIWSdHMbvft5PmoQn6sFH
	IcV7MzQMhhJ0rmBkX/YBC/weRbqLokRMSmZ6ik0XU7rZvco7R4C2wIFnVGG9o7eutZftokmziiC4K
	nQ9n/BpqoKfdCPOz2LsnPB9txLPkgtoyxDzFPc1X8cm5D/mM01Zm2Zc7dshL/3p5OD31EIXnBc1Df
	JKd/CZ6drZhOuyAp/BJPd0uFhTXNNmNfvYMda/biM5v762qMflladqI5Lmzz+ixXkBvmbR1595UpD
	xD8PDHHhKBB1psXwMQPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ploON-00EvYg-0T;
	Mon, 10 Apr 2023 10:04:55 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ploOJ-00EvXS-2G;
	Mon, 10 Apr 2023 10:04:53 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pw4HZ1ymSz17Rtt;
	Mon, 10 Apr 2023 18:01:14 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Apr
 2023 17:52:37 +0800
Message-ID: <20dd1890-273b-3a5b-7a4e-6feaf722cf8a@huawei.com>
Date: Mon, 10 Apr 2023 17:52:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v3 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Content-Language: en-US
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Simon Horman
	<horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <bhe@redhat.com>
References: <20230406220206.3067006-1-chenjiahao16@huawei.com>
 <20230406220206.3067006-2-chenjiahao16@huawei.com>
 <ZDAGi2/+1q0oEUZ5@kernel.org>
 <ee6434f7-8e94-bae5-7d63-4b9bce3aec24@huawei.com>
 <f87d33e7-3a30-35b1-8612-0ff1eae63807@huawei.com>
From: "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <f87d33e7-3a30-35b1-8612-0ff1eae63807@huawei.com>
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_030452_071030_F4E87A4A 
X-CRM114-Status: GOOD (  14.58  )
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


On 2023/4/8 10:00, Leizhen (ThunderTown) wrote:
>
> On 2023/4/7 20:58, Leizhen (ThunderTown) wrote:
>>
>> On 2023/4/7 20:03, Simon Horman wrote:
>>> On Fri, Apr 07, 2023 at 06:02:05AM +0800, Chen Jiahao wrote:
>>>> On riscv, the current crash kernel allocation logic is trying to
>>>> allocate within 32bit addressible memory region by default, if
>>>> failed, try to allocate without 4G restriction.
>>>>
>>>> In need of saving DMA zone memory while allocating a relatively large
>>>> crash kernel region, allocating the reserved memory top down in
>>>> high memory, without overlapping the DMA zone, is a mature solution.
>>>> Here introduce the parameter option crashkernel=X,[high,low].
>>>>
>>>> One can reserve the crash kernel from high memory above DMA zone range
>>>> by explicitly passing "crashkernel=X,high"; or reserve a memory range
>>>> below 4G with "crashkernel=X,low".
>>>>
>>>> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
>>> ...
>>>
>>>> @@ -1180,14 +1206,37 @@ static void __init reserve_crashkernel(void)
>>>>   		return;
>>>>   	}
>>>>   
>>>> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>>>> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>>>>   				&crash_size, &crash_base);
>>>> -	if (ret || !crash_size)
>>>> +	if (ret == -ENOENT) {
>>>> +		/*
>>>> +		 * crashkernel=X,[high,low] can be specified or not, but
>>>> +		 * invalid value is not allowed.
>>> nit: Perhaps something like this would be easier to correlate with the
>>>       code that follows:
>>>
>>> 		/* Fallback to crashkernel=X,[high,low] */
>> The description "crashkernel=X,[high,low] can be specified or not" is not
>> correct, because crashkernel=X,high must be specified when walking into this
>> branch. So use Simon's comments or copy arm64's comments(it's written for
>> parse_crashkernel_low()).
> I rethink it a little bit, if it's relative to crashkernel=X[@offset],
> that's also true.
>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

Sure, The commit should not be ambiguous like this, Simon's comment above is

a better option.


>>>
>>>> +		 */
>>>> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
>>>> +		if (ret || !crash_size)
>>>> +			return;
>>>> +
>>>> +		/*
>>>> +		 * crashkernel=Y,low is valid only when crashkernel=X,high
>>>> +		 * is passed and high memory is reserved successful.
>>> nit: s/successful/successfully/
>> Seems like the whole "and high memory is reserved successful" needs to be deleted.
>> Only the dependency between the two boot options should be described here,
>> regardless of whether their memory is successfully allocated.

The comment here is imprecise, since there is absolutely no check whether

the allocation is successful before "parse_crashkernel_low"


>>
>>>> +		 */
>>>> +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
>>>> +		if (ret == -ENOENT)
>>>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>>> +		else if (ret)
>>>> +			return;
>>>> +
>>>> +		search_start = search_low_max;
>>>> +	} else if (ret || !crash_size) {
>>>> +		/* Invalid argument value specified */
>>>>   		return;
>>>> +	}
>>> ...
>>> .
>>>
BR,

Jiahao


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
