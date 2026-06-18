Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1D0C5DF74
	for <kexec@archiver.kernel.org>; Sat, 15 Aug 2026 07:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=elgYJ9FctEuOCR5N0/Evesj9qTtWETUXJRRIi/jFI38=; b=J2G7MyJurKYUodsQOjvmxjztSY
	g6lapr95v5aF1OW+a+BKTmQNdQr1ZR75UspRP/abJin3H+eqjUnVQAmhEJ7E3UBkPdVZ77r7eNeJ+
	v9UkzdIqY4ajaNi+e/54raU/Su+5kEsRyqoQDz2RWa7/djgHURCNEGsc/PMjOH9cbArwoMwdw2OaW
	ovx23txom9JV+amN7MF95udhI1EM8ogrflYm9uQ0zPfsGuGVA6kl7d35BIaQtD5N3ILZn2mVKMH0Y
	zUtBUxdUWOV9PV4a80pOGPlfawcKQBC4PXxwwJcQYrljksbqz/84O4XmTYrpRwXq0cXpwm28CfpA1
	JOVNEPJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv95K-00000003cwW-2Qr9;
	Sat, 15 Aug 2026 07:45:42 +0000
Received: from canpmsgout11.his.huawei.com ([113.46.200.226])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa1oy-00000000Ua1-09DF;
	Thu, 18 Jun 2026 01:45:34 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=elgYJ9FctEuOCR5N0/Evesj9qTtWETUXJRRIi/jFI38=;
	b=mKZIAMgrv0yhhqfotPRGtcu6nLs4Chv0duVXxR76TfyQ3YmTy1nupn328cT3+Yi8uyhE+9n3j
	uc7hX8yW3e8zJNd2aoWbAUFQRgY3AFqjEchvsWtvpFlpDHyb9xAegYA4dU42PHQBl0b7E74Ye3c
	bNyffaauQdereWE6+Bi3IAM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ggjyS3PN2zKm62;
	Thu, 18 Jun 2026 09:37:20 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id DADF3402AB;
	Thu, 18 Jun 2026 09:45:21 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Jun 2026 09:45:17 +0800
Message-ID: <6437c0e3-d5c5-44b1-9157-b30bae2a6335@huawei.com>
Date: Thu, 18 Jun 2026 09:45:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/10] arm64/riscv: Add support for crashkernel CMA
 reservation
To: Mike Rapoport <rppt@kernel.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <rdunlap@infradead.org>,
	<peterz@infradead.org>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <leitao@debian.org>, <coxu@redhat.com>,
	<Liam.Howlett@oracle.com>, <ryan.roberts@arm.com>, <osandov@fb.com>,
	<jbohac@suse.cz>, <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
	<sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <ardb@kernel.org>, <chenjiahao16@huawei.com>,
	<guoren@kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20260608073459.3119290-1-ruanjinjie@huawei.com>
 <ajLr53EK6mJbng-7@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ajLr53EK6mJbng-7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_184532_375388_C8B31CF7 
X-CRM114-Status: GOOD (  12.35  )
X-Mailman-Approved-At: Sat, 15 Aug 2026 00:45:39 -0700
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



On 6/18/2026 2:48 AM, Mike Rapoport wrote:
> Hi Jinjie,
> 
> On Mon, Jun 08, 2026 at 03:34:49PM +0800, Jinjie Ruan wrote:
>> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
>> and crashk_cma memory are almost identical across different architectures,
>> This patch set handle them in crash core in a general way, which eliminate
>> a lot of duplication code.
>>
>> And add support for crashkernel CMA reservation for arm64 and riscv.
>>
>> This patch set is rebased on v7.1-rc1.
> 
> Please rebase this set on v7.2-rc1 once that's out.
> 
> I'm going to queue it in the liveupdate tree then to expose to the wider
> testing.
> 
> Meanwhile it would be great to chase riscv and x86 maintainers for acks :)

Thanks! That sounds great.

I will rebase this patch set on v7.2-rc1 as soon as it is out and send v17.

In the meantime, I will CC and reach out to the RISC-V and x86
maintainers to request their reviews and Acks.

Best regards,
Jinjie

> 


