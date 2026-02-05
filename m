Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D34EA7945
	for <kexec@archiver.kernel.org>; Thu,  5 Feb 2026 03:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m0YhAEtCzGzoYGvZg42KcYgs+OHxXA5AmpEhewJRkE0=; b=oOvSBIK9EKnpSM0tH/fxLaDMjf
	Hrxnldd9u5PDfGuQCS4cib2E+T+jx+FQasxDqJMx9UDEPHe6k7rJVieN46/4SRVasfo/ru8exGA9s
	eJmy559hYM9yAYdDd8G4Dll5T2OfZIAZP4HL+ndDROdioWbUefBdTbYJUZKkh4gBsypc1RQzF/RJu
	+VRV2RgC+vk0yhbPkJRAY3e4+mE6p6mJImfDNC5/H7Qit6ZSZrEW7Pe4CszbfdfGacQNzk+In++xN
	4uh9tCEYujN1AUfmzBvu2vj+YuaMXYc0r02/DRHoUg0sjgPCJmM2tr4hEhvmlx4JI+bfeo3K5ZCJL
	tDB6N+gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnpqU-00000009M2r-0T0v;
	Thu, 05 Feb 2026 03:15:54 +0000
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnpqQ-00000009M2O-0b7l;
	Thu, 05 Feb 2026 03:15:52 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m0YhAEtCzGzoYGvZg42KcYgs+OHxXA5AmpEhewJRkE0=;
	b=mrg81Ley9PfGVLZQRfso+yz1ManXQbV+PfgxLEEqszlmqVu7nf5ibUS3D3jz2hxv4nVKl3Pxy
	u1f26cRtxz6qdg+Sa5H47rkNKtSL2+fw1FqsGBvUi1egGqaUWoOeHZW1xEPRfIPMfxyDybkK+me
	y6AzQqnzHgyAcWGTJDZFXnA=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4f62L33nmhz1prQr;
	Thu,  5 Feb 2026 11:11:07 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id A0B3540561;
	Thu,  5 Feb 2026 11:15:44 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Feb 2026 11:15:41 +0800
Message-ID: <113f1d02-69df-b28e-edb9-514d284c6b29@huawei.com>
Date: Thu, 5 Feb 2026 11:15:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 1/3] crash: Exclude crash kernel memory in crash core
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, <corbet@lwn.net>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
	<kees@kernel.org>, <elver@google.com>, <arnd@arndb.de>,
	<lirongqing@baidu.com>, <fvdl@google.com>, <leitao@debian.org>,
	<rppt@kernel.org>, <cfsworks@gmail.com>, <osandov@fb.com>, <ardb@kernel.org>,
	<ryan.roberts@arm.com>, <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
	<bjorn@rivosinc.com>, <songshuaishuai@tinylab.org>,
	<samuel.holland@sifive.com>, <kevin.brodsky@arm.com>,
	<junhui.liu@pigmoral.tech>, <vishal.moola@gmail.com>, <coxu@redhat.com>,
	<jbohac@suse.cz>, <liaoyuanhong@vivo.com>, <brgerst@gmail.com>,
	<fuqiang.wang@easystack.cn>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
References: <20260204093728.1447527-1-ruanjinjie@huawei.com>
 <20260204093728.1447527-2-ruanjinjie@huawei.com>
 <4dc944c7-20ad-4e92-b05e-28a9e0c5a2b8@linux.ibm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <4dc944c7-20ad-4e92-b05e-28a9e0c5a2b8@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_191551_056511_2B3DD426 
X-CRM114-Status: GOOD (  24.73  )
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



On 2026/2/4 20:32, Sourabh Jain wrote:
> 
> 
> On 04/02/26 15:07, Jinjie Ruan wrote:
>> The exclude of crashk_res, crashk_low_res and crashk_cma memory
>> are almost identical across different architectures, so handling them
>> in the crash core would eliminate a lot of duplication, so do
>> them in the common code.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   arch/arm64/kernel/machine_kexec_file.c     | 12 -------
>>   arch/loongarch/kernel/machine_kexec_file.c | 12 -------
>>   arch/powerpc/kexec/ranges.c                | 16 ++-------
>>   arch/riscv/kernel/machine_kexec_file.c     |  5 +--
>>   arch/x86/kernel/crash.c                    | 39 ++--------------------
>>   kernel/crash_core.c                        | 28 ++++++++++++++++
>>   6 files changed, 34 insertions(+), 78 deletions(-)
>>

[...]

>> -static int crash_exclude_mem_range_guarded(struct crash_mem
>> **mem_ranges,
>> -                       unsigned long long mstart,
>> -                       unsigned long long mend)
>> +static int crash_realloc_mem_range_guarded(struct crash_mem
>> **mem_ranges)
>>   {
>>       struct crash_mem *tmem = *mem_ranges;
>>   @@ -566,7 +564,7 @@ static int
>> crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
>>               return -ENOMEM;
>>       }
>>   -    return crash_exclude_mem_range(tmem, mstart, mend);
>> +    return 0;
>>   }
>>     /**
>> @@ -604,18 +602,10 @@ int get_crash_memory_ranges(struct crash_mem
>> **mem_ranges)
>>               sort_memory_ranges(*mem_ranges, true);
>>       }
>>   -    /* Exclude crashkernel region */
>> -    ret = crash_exclude_mem_range_guarded(mem_ranges,
>> crashk_res.start, crashk_res.end);
>> +    ret = crash_realloc_mem_range_guarded(mem_ranges);
> 
> What if max_nr_ranges - nr_ranges = 1, then no realloc will happen here.
> And in
> elf_header_exclude_ranges we may not enough space to store additional
> memory ranges needed while excluding one or more CMA ranges.

You're absolutely right — if max_nr_ranges - nr_ranges == 1 we skip the
realloc, yet elf_header_exclude_ranges() can easily need more than one
extra slot.

Thanks for catching this.
Jinjie

> 
>>       if (ret)
>>           goto out;
>>   -    for (i = 0; i < crashk_cma_cnt; ++i) {
>> -        ret = crash_exclude_mem_range_guarded(mem_ranges,
>> crashk_cma_ranges[i].start,
>> -                          crashk_cma_ranges[i].end);
>> -        if (ret)
>> -            goto out;
>> -    }
>> -
>>       /*
>>        * FIXME: For now, stay in parity with kexec-tools but if RTAS/OPAL
>>        *        regions are exported to save their context at the time of

[...]

>>   +static int crash_exclude_mem_ranges(struct crash_mem *cmem)
>> +{
>> +    int ret, i;
>> +
>> +    /* Exclude crashkernel region */
>> +    ret = crash_exclude_mem_range(cmem, crashk_res.start,
>> crashk_res.end);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (crashk_low_res.end) {
>> +        ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
>> crashk_low_res.end);
>> +        if (ret)
>> +            return ret;
>> +    }
>>   +    for (i = 0; i < crashk_cma_cnt; ++i) {
>> +        ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
>> +                          crashk_cma_ranges[i].end);
>> +        if (ret)
>> +            return ret;
>> +    }
>>   +    return ret;
>> +}
>>     int crash_prepare_elf64_headers(struct crash_mem *mem, int
>> need_kernel_map,
>>                 void **addr, unsigned long *sz)
>> @@ -174,6 +197,11 @@ int crash_prepare_elf64_headers(struct crash_mem
>> *mem, int need_kernel_map,
>>       unsigned int cpu, i;
>>       unsigned long long notes_addr;
>>       unsigned long mstart, mend;
>> +    int ret;
>> +
>> +    ret = crash_exclude_mem_ranges(mem);
> 
> I think the assumption here is that mem should have enough space
> to hold the extra ranges created while excluding crash memory ranges.
> Right now, this is not happening on powerpc for the case I mentioned
> in the above comment.

Yes, as you mentioned above.

> 
> Also, if crashk_cma_cnt changes in the future, or if a new type of
> crash memory is added, then every architecture would need to adjust
> the mem allocation accordingly. Instead, could we handle this in
> generic code rather than in architecture-specific code, so that we
> always ensure mem has enough space?

I agree — hard-coding the worst-case count in every arch is a
maintenance trap.
Let's move the size calculation (and the realloc if needed) into the
generic crash core so that:

- New CMA regions or future crash-memory types are automatically
accounted for;

- Each architecture no longer has to play whack-a-mole with its private
array size.

Thanks for the suggestion.

> 
>> +    if (ret)
>> +        return ret;
>>         /* extra phdr for vmcoreinfo ELF note */
>>       nr_phdr = nr_cpus + 1;
> 

