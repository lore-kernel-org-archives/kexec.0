Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBC7C3DA5D
	for <kexec@archiver.kernel.org>; Mon, 22 Jul 2024 01:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8b0yRBE1hDfZ8Kl/mI4ri71mpHPVyx+Md4KNmzBTnVU=; b=IuSElJWL0Z5utt
	TOwFrujqJkci5I+Zn8giynsE9mUdbt8JpG+O7GWztDA5Vrtm7hpM1TNkizoZpdsRyMU8FC2UhuLx0
	kTtHiXrBTDWq7tpRAYXoQ0f9737MnT8bW3l5AMfmEL54n4pADpbt9OKyUtAAYg+BSUt0suhtdG7h1
	wv27Dd+tr73SEghb6CF8HtxtHAzSmKsVALy3EX6o6lkzEQMqxeadNmanbDqphS52CV50VC9f5+uLa
	+UHm1b9e0bwEGM7ih8EHAqKbElIl4Utha8d8+g87Y+DoTxLgKgQuvPHsoIGqDvHnYSnxvRfooHJBj
	totgSoHHHZMQBYdMKaYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sViDp-000000082pH-2zIL;
	Mon, 22 Jul 2024 01:52:17 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sViDl-000000082o6-347P;
	Mon, 22 Jul 2024 01:52:15 +0000
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WS36y6jDgzxTYM;
	Mon, 22 Jul 2024 09:47:06 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id ECB2A140154;
	Mon, 22 Jul 2024 09:52:04 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 09:52:03 +0800
Message-ID: <22c694f8-0033-53e4-9526-7ad12b12efe7@huawei.com>
Date: Mon, 22 Jul 2024 09:52:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 3/3] ARM: Use generic interface to simplify crashkernel
 reservation
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>, <arnd@arndb.de>,
	<afd@ti.com>, <akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
	<eric.devolder@oracle.com>, <gregkh@linuxfoundation.org>,
	<javierm@redhat.com>, <deller@gmx.de>, <robh@kernel.org>,
	<thunder.leizhen@huawei.com>, <hbathini@linux.ibm.com>,
	<tangyouling@kylinos.cn>, <chenjiahao16@huawei.com>,
	<kexec@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
References: <20240719095735.1912878-1-ruanjinjie@huawei.com>
 <20240719095735.1912878-4-ruanjinjie@huawei.com>
 <Zp24C4ZkWI4g21FK@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zp24C4ZkWI4g21FK@MiWiFi-R3L-srv>
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_185214_178793_4B37283F 
X-CRM114-Status: GOOD (  11.82  )
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



On 2024/7/22 9:38, Baoquan He wrote:
> On 07/19/24 at 05:57pm, Jinjie Ruan wrote:
>> Currently, x86, arm64, riscv and loongarch has been switched to generic
>> crashkernel reservation, which is also ready for 32bit system.
>> So with the help of function parse_crashkernel() and generic
>> reserve_crashkernel_generic(), arm32 crashkernel reservation can also
>> be simplified by steps:
>>
>> 1) Add a new header file <asm/crash_reserve.h>, and define CRASH_ALIGN,
>>    CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX in it;
>>
>> 2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
>>    reserve_crashkernel_generic();
>>
>> 3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
>>    arch/arm/Kconfig.
>>
>> The old reserve_crashkernel() can be removed.
>>
>> Following test cases have been performed as expected on QEMU vexpress-a9
>> (1GB system memory):
>>
>> 1) crashkernel=4G,high				// invalid
>> 2) crashkernel=1G,high				// invalid
>> 3) crashkernel=1G,high crashkernel=0M,low	// invalid
>> 4) crashkernel=256M,high			// invalid
>> 5) crashkernel=256M,low				// invalid
>> 6) crashkernel=256M crashkernel=256M,high	// high is ignored, ok
>> 7) crashkernel=256M crashkernel=256M,low	// low is ignored, ok
>> 8) crashkernel=256M,high crashkernel=256M,low	// invalid
>> 9) crashkernel=256M,high crashkernel=4G,low	// invalid
>> 10) crashkernel=256M				// ok
>> 11) crashkernel=512M				// ok
>> 12) crashkernel=256M@0x88000000			// ok
>> 13) crashkernel=256M@0x78000000			// ok
>> 14) crashkernel=512M@0x78000000			// ok
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> v4:
>> - Remove the Tested-by as suggested.
>> v3:
>> - Update the commit message.
>> ---
>>  arch/arm/Kconfig                     |  3 ++
>>  arch/arm/include/asm/crash_reserve.h | 24 +++++++++++
>>  arch/arm/kernel/setup.c              | 63 ++++------------------------
>>  3 files changed, 36 insertions(+), 54 deletions(-)
>>  create mode 100644 arch/arm/include/asm/crash_reserve.h
> 
> LGTM,
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
> By the way, you may need respost the parsed crashkernel value limitation
> checking patch for arm32 and i386.

Thank you for the kind reminder. I'll rebase and resend it later.

> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
