Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73260C624D0
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 10:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5muCGImxQEXCs9mgbU84wjK603R7oDB3KGXYhDYZoIc=; b=DCE7CuFk2NoDe4L7YyPz1zDZue
	qG1P+dLd8x7dFD8DGYZPAOiCkDTGtOU/6LVOU5+Hm5bLnb827zZjVy2KefvaqvOurXACOYbHPrS7z
	YoSYI4ltCAs9LY0I5lXF2rZDwMX72j5lPYH8akjZsPKo4pC0Pa1o1tDbHKb+7TTiaBWKzOoLSNmiw
	V6ZUsVEqYShwvGHVwUIhtquzPAKGOZmzhfk14lzCyQ8L+80cxojTiaTWR/hNXYwFS+By3WMBXZQw6
	JVNpzhyTxl/YKmSJDHGBnrsSJIaoP3psaIi/Bpd+OsO42HL5R8WbSxPaxBFMJ97pLqHhX6A8zdj+u
	CKYj9TPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1hmV-0000000EIxy-2hzk;
	Wed, 02 Sep 2026 10:01:23 +0000
Received: from canpmsgout12.his.huawei.com ([113.46.200.227])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1hmT-0000000EIxB-0nKW;
	Wed, 02 Sep 2026 10:01:22 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5muCGImxQEXCs9mgbU84wjK603R7oDB3KGXYhDYZoIc=;
	b=1OKXC1WlAcuXvATuYy9843J+ts23aqDRPtEBmymokcm2wcDFN7n+VLXs5YlFtuuOI17YRGOle
	AE1kaDyBL8Psb6qsvqP6GD+2KaR9IZFlJSaA9VKKZKh4vJ8pLjxN4lSw5BvQVM6ddEVaTK1WC49
	5AuTsqZ1V1GNz92YBNN1IQA=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hZdHw4T64znTwN;
	Wed,  2 Sep 2026 17:50:04 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C74E54057A;
	Wed,  2 Sep 2026 18:01:17 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Sep 2026 18:01:15 +0800
Message-ID: <d12302b0-f0b3-4df6-963c-bf25b6e720c7@huawei.com>
Date: Wed, 2 Sep 2026 18:01:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/17] x86/crash: Use num_possible_cpus() for
 elfcorehdr size
To: Sourabh Jain <sourabhjain@linux.ibm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <mark.rutland@arm.com>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<gshan@redhat.com>, <jic23@kernel.org>, <james.morse@arm.com>,
	<ardb@kernel.org>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<coxu@redhat.com>, <tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>,
	<adityag@linux.ibm.com>, <ionut.nechita@windriver.com>,
	<liaoyuanhong@vivo.com>, <seanjc@google.com>, <fuqiang.wang@easystack.cn>,
	<makb@juniper.net>, <piliu@redhat.com>, <ebiggers@kernel.org>,
	<jbouron@amazon.com>, <mclapinski@google.com>, <me@linux.beauty>,
	<graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-13-ruanjinjie@huawei.com>
 <99b1121d-4277-4764-8c3a-b3f6d9a47ab0@linux.ibm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <99b1121d-4277-4764-8c3a-b3f6d9a47ab0@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_030121_545687_35F1E08A 
X-CRM114-Status: GOOD (  15.68  )
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



在 2026/9/2 14:14, Sourabh Jain 写道:
> Hello Jinjie,
> 
> This patch makes the below patch redundant..
> https://lore.kernel.org/all/20260826073527.21487-2-
> ionut.nechita@windriver.com/
> 
> I suggest dropping the first patch from the above series and including
> the second patch from that series in this patch series with the updated
> comment.

Agreed. This approach makes sense to me.

I will update it in v4.

> 
> - Sourabh Jain
> 
> 
> On 26/08/26 14:55, Jinjie Ruan wrote:
>> Use num_possible_cpus() instead of CONFIG_NR_CPUS to calculate the
>> elfcorehdr buffer size, matching what crash_prepare_elf64_headers()
>> already uses for the actual header content.
>>
>> This avoids over-allocation when the system has fewer possible CPUs
>> than the compile-time limit, and aligns x86 with PowerPC.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   arch/x86/kernel/crash.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index a3bf786286d4..afe2aea19f47 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -369,9 +369,9 @@ int crash_load_segments(struct kimage *image)
>>        * maximum CPUs and maximum memory ranges.
>>        */
>>       if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> -        pnum = 2 + CONFIG_NR_CPUS + CONFIG_CRASH_MAX_MEMORY_RANGES;
>> +        pnum = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
>>       else
>> -        pnum += 2 + CONFIG_NR_CPUS;
>> +        pnum += 2 + num_possible_cpus();
>>         if (pnum < (unsigned long)PN_XNUM) {
>>           kbuf.memsz = elf64_phdr_size(pnum);
>> @@ -429,7 +429,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>       unsigned int sz;
>>         /* kernel_map, VMCOREINFO and maximum CPUs */
>> -    sz = 2 + CONFIG_NR_CPUS;
>> +    sz = 2 + num_possible_cpus();
>>       if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>>           sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
>>       sz *= sizeof(Elf64_Phdr);
> 


