Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68BEC61DD3
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 01:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t9UK13JKhSsPM/Vc9steoJSl+OnutIzRnlZukeamK+o=; b=gygD3GgZv+F2aeL3dQcTVkSqLm
	U9znIPidb9D8uDKXoHvgyKy/E0VSOs27aL19Kvw6puuvbKGeKNWO47LdVJiung+tUloF8j2+xCY/K
	qq6d6ekRdEgcfu6k6BnhFztgP8fuPX030d3H8o3siJ52VeXps5JhhKdU5LQmVSt7CnNZjlmzrMQ7e
	ueWWSWE0/sfs1p83PeG1KbO5lzAtsc5m3Jdz/mRNeiA9UlRiCvKQWT5xsS5timyUD/VQvMyH8F7AE
	OGyPdC34xzG9tdf1RAkuKD6KsS1Zx3m4OexwW0ynhto7dxi4k8hKUeCcEk27q7okD6jsXCqVBbskB
	vsOVgW1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1Zdq-0000000Dctj-2BmM;
	Wed, 02 Sep 2026 01:19:54 +0000
Received: from [113.46.200.227] (helo=canpmsgout12.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1Zdo-0000000Dcsu-0dgt;
	Wed, 02 Sep 2026 01:19:53 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=t9UK13JKhSsPM/Vc9steoJSl+OnutIzRnlZukeamK+o=;
	b=JSc/QrUEAnbPE7s6EK6aHXX4FMrI/ak+7N46GxWAYjo+hv4+e8IRFqw3R57vf10ZXvwgmTnw1
	5LsKKvi+A3v/zJR4bWOVaYI3bbjz5k4AHVvkI67n+bm/COW12+QwJBDOanQFb2mbBv/tq3BctvX
	qaDBA0HnMSM+ut7AmVDhzas=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hZPjt2PDTznTVd;
	Wed,  2 Sep 2026 09:08:18 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id B4C9C40565;
	Wed,  2 Sep 2026 09:19:31 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Sep 2026 09:19:29 +0800
Message-ID: <96ba8924-b857-4dbc-9161-4c464901f974@huawei.com>
Date: Wed, 2 Sep 2026 09:19:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] crash: Simplify CRASH_MAX_MEMORY_RANGES handling
To: Mike Rapoport <rppt@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<gshan@redhat.com>, <jic23@kernel.org>, <james.morse@arm.com>,
	<ardb@kernel.org>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <coxu@redhat.com>, <tangyouling@kylinos.cn>,
	<hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ionut.nechita@windriver.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-16-ruanjinjie@huawei.com>
 <178829364021.3691424.12328056849597833403.b4-review@b4>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <178829364021.3691424.12328056849597833403.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_181952_580516_55F0D932 
X-CRM114-Status: GOOD (  11.13  )
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



在 2026/9/2 4:14, Mike Rapoport 写道:
> Hi,
> 
>> Set CRASH_MAX_MEMORY_RANGES to 0 when MEMORY_HOTPLUG is disabled, then
>> remove the now unnecessary IS_ENABLED(CONFIG_MEMORY_HOTPLUG) checks in
>> powerpc and x86 arch_crash_get_elfcorehdr_size().
>>
>> No functional change intended.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>
>> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
>> index fc0105c7af4c3..c47e3f867ea1f 100644
>> --- a/arch/powerpc/kexec/crash.c
>> +++ b/arch/powerpc/kexec/crash.c
>> @@ -474,9 +474,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>  	unsigned long phdr_cnt;
>>  
>>  	/* A program header for possible CPUs + vmcoreinfo */
>> -	phdr_cnt = num_possible_cpus() + 1;
>> -	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> -		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
>> +	phdr_cnt = num_possible_cpus() + 1 + CONFIG_CRASH_MAX_MEMORY_RANGES;
>>  
>>  	return elf64_phdr_size(phdr_cnt);
>>  }
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 99eb8583d9321..116410ac90fb4 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -407,9 +407,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>  	unsigned int sz;
>>  
>>  	/* kernel_map, VMCOREINFO and maximum CPUs */
>> -	sz = 2 + num_possible_cpus();
>> -	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> -		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
>> +	sz = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
>>  	sz *= sizeof(Elf64_Phdr);
>>  	return sz;
>>  }
>> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
>> index a97ed9605602f..e6251dfe451a8 100644
>> --- a/kernel/Kconfig.kexec
>> +++ b/kernel/Kconfig.kexec
>> @@ -160,7 +160,8 @@ config CRASH_HOTPLUG
>>  
>>  config CRASH_MAX_MEMORY_RANGES
>>  	int "Specify the maximum number of memory regions for the elfcorehdr"
>> -	default 8192
>> +	default 8192 if MEMORY_HOTPLUG
>> +	default 0 if !MEMORY_HOTPLUG
> 
> This only sets the default, but a user can change the value explicitly.

You're right. Let me drop this patch for now. Thanks for the review!

> 


