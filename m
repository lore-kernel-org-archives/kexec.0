Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9638DCD4F47
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hZY77WY1R4lZKqkiJYVx90NM7cypXm7b/K/Dl6ostWU=; b=iaZ07SATjd0YcGW3PtI3OLiiD4
	bcgNni6t0QlFLz6/2SP2Df1BgQrt0BWLAjn2ASanyk+dAlF4EFEQoEhFMtvtWKd0qumZMkDQwwaCj
	ZPB8XLPVOqDPKxOm5bBTWgiL9kS4DZMK0tyIbd7kq9wyfmiV08bhdnTylLsNss95hVcl2yJL1jQn3
	3VdCUh8CjMT6bk9P6X5L/46yw67fMOOdM/2H++1vpXoCq/p1HIJ/zGr13bmsLvYVFRIrUC1VEueq6
	7dfcEzdQ4xYzC2TSlwqKINVpic3wkuN9uZgTCM1Do95zl1DXYmZL2iPIVSqw42N7ZMQQPUoNi9Pj+
	4rMCT7Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMrLM-000000001Bo-1EeB;
	Tue, 12 May 2026 17:56:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOqp-0000000DKUw-3b27;
	Mon, 11 May 2026 11:31:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hZY77WY1R4lZKqkiJYVx90NM7cypXm7b/K/Dl6ostWU=; b=jf3k3vPKpYFGz5dCFf+bos0NFo
	16tV9Bs8TrOFsV8eOCQVLsErLlZWgUjBPnVYeWoq9TJpCjUMKpJF93URl8pFn95nVJuYTphKxvsEp
	2LTvmfzKMmTU8cJ1Pg1hUFei1sZIEgJ7RI5Fa+bYQgyNqoPm1zsM45Ay+2jI+iXQO0lW+CxTle67F
	PJuxM9t+dZKoD7fUud1CPAvZ2DHJB6A4MrRWvduDVFAUW0/ss4QZ5ABxfcrrOY84FAvJLQ/kdTXqq
	maf/klmK3d3oFYhCcQQLAC3Gqts246494SDO7vgyh5cV9HSaDQfPD/w1m7IKi5zxZX9OjIm0slTeU
	gL2dtSfQ==;
Received: from canpmsgout08.his.huawei.com ([113.46.200.223])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOqh-0000000BTgS-2SLB;
	Mon, 11 May 2026 11:31:04 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hZY77WY1R4lZKqkiJYVx90NM7cypXm7b/K/Dl6ostWU=;
	b=A7gfGf9I2mWtoGk1twpeKdsTWxHRCoqkxK6h8sqAufJacFPxPk7J5UV8oj4BBjTyooxVD2Cki
	IZBX0lyWqVPhijn1Ra4jjJgWV2oQvMFsHXLFq2R6ycKWvoUQXNa+lNIZBbmfXSzS+9wfOLM4NXI
	bc1oxF4bSdMbsjNUg+iYH3U=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gDcm00dzbzmV6w;
	Mon, 11 May 2026 19:23:12 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B9494048B;
	Mon, 11 May 2026 19:30:49 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 May 2026 19:30:44 +0800
Message-ID: <79c14bee-b1f5-4d70-8345-6582d6cf0128@huawei.com>
Date: Mon, 11 May 2026 19:30:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/15] arm64: kexec_file: Fix potential buffer
 overflow in prepare_elf_headers()
To: Breno Leitao <leitao@debian.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <pmladek@suse.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <lirongqing@baidu.com>, <paulmck@kernel.org>,
	<sourabhjain@linux.ibm.com>, <coxu@redhat.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <osandov@fb.com>, <cfsworks@gmail.com>,
	<tangyouling@kylinos.cn>, <ritesh.list@gmail.com>, <adityag@linux.ibm.com>,
	<guoren@kernel.org>, <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>,
	<wangruikang@iscas.ac.cn>, <namcao@linutronix.de>, <chao.gao@intel.com>,
	<seanjc@google.com>, <fuqiang.wang@easystack.cn>, <ardb@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <lizhengyu3@huawei.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20260511030454.1730881-1-ruanjinjie@huawei.com>
 <20260511030454.1730881-5-ruanjinjie@huawei.com> <agGkvrg06KNDNfDi@gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <agGkvrg06KNDNfDi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_123101_208554_DF05BF5C 
X-CRM114-Status: GOOD (  19.85  )
X-Mailman-Approved-At: Tue, 12 May 2026 10:56:26 -0700
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



On 5/11/2026 5:46 PM, Breno Leitao wrote:
> On Mon, May 11, 2026 at 11:04:43AM +0800, Jinjie Ruan wrote:
>> There is a race condition between the kexec_load() system call
>> (crash kernel loading path) and memory hotplug operations that can
>> lead to buffer overflow and potential kernel crash.
>>
>> During prepare_elf_headers(), the following steps occur:
>> 1. The first for_each_mem_range() queries current System RAM memory ranges
>> 2. Allocates buffer based on queried count
>> 3. The 2st for_each_mem_range() populates ranges from memblock
>>
>> If memory hotplug occurs between step 1 and step 3, the number of ranges
>> can increase, causing out-of-bounds write when populating cmem->ranges[].
>>
>> This happens because kexec_load() uses kexec_trylock (atomic_t) while
>> memory hotplug uses device_hotplug_lock (mutex), so they don't serialize
>> with each other.
>>
>> Add the explicit bounds checking to prevent out-of-bounds access.
> 
> It seems you have a TOCTOU type of issue, and this seems to be shrinking
> the window, but not fully solving it?

Hi Breno,

Thanks for your comments regarding the TOCTOU issue.

You are correct that the current bounds checking only "shrinks the
window" and prevents a kernel crash, but doesn't fully guarantee header
consistency if a race occurs.

In my local environment, this race is extremely difficult to reproduce,
but it is theoretically possible.

To address this properly for arm64, I am considering two steps:

- For this patch: I will change the return value to -EAGAIN and keep the
bounds check. This ensures that even if a race happens, the kernel
remains safe (no OOB access), and user-space is notified to retry.

- Long-term solution: A better way to solve this is to implement ARM64
CRASH_HOTPLUG support (similar to x86). With crash hotplug, the kernel
will automatically re-generate the crash headers whenever a memory
hotplug event occurs. This makes the TOCTOU during the initial
kexec_load less critical, as any transient inconsistency will be
immediately corrected by the subsequent hotplug handler.

Does it make sense to you to use this patch as a safety guard first, and
then I (or someone else) follow up with the full CRASH_HOTPLUG support
for arm64 as [1]?

[1]:
https://lore.kernel.org/all/20260402081459.635022-1-ruanjinjie@huawei.com/

Best regards,
Jinjie

> 
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Breno Leitao <leitao@debian.org>
>> Cc: stable@vger.kernel.org
>> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
>> Closes: https://sashiko.dev/#/patchset/20260323072745.2481719-1-ruanjinjie%40huawei.com
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/kernel/machine_kexec_file.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>> index e31fabed378a..a67e7b1abbab 100644
>> --- a/arch/arm64/kernel/machine_kexec_file.c
>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>> @@ -59,6 +59,11 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>>  	cmem->max_nr_ranges = nr_ranges;
>>  	cmem->nr_ranges = 0;
>>  	for_each_mem_range(i, &start, &end) {
>> +		if (cmem->nr_ranges >= cmem->max_nr_ranges) {
>> +			ret = -ENOMEM;
> 
> -ENOMEM seems to be the the wrong errno. This isn't an allocation
> failure; it's a transient race. -EBUSY or -EAGAIN would be more honest


