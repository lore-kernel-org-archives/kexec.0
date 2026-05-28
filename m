Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B549CD6E64
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u5ZL+hZHbV/pTWWeaWLQdg762ZQtOkbcULKixMOn0bQ=; b=5CAco53T7JbDODrBLI+BiUgezF
	EB8SY8BNiKfjn49mCGpm3U76AsC8qx/A//8tE9Pha9RWYFoNRHHEX7cbdrUv8Xc41+A2dfwuQzrOA
	R+ZxDB0dTXPbc5geWpTH6ce1KteSzFPuqAYUecI5eK03bJL58+/pl8vk1tqOwfJ3zWMBUf3L+bqIZ
	aXAa/jGHSRva0wFdmzKmfawkBxlt+q3enaiPF+SvdiAwhDzXHbuxKfg7YSrg9tZjuvv+C8i9bro0E
	wuf47mxCpi1q3J7TbrWgulEP0LrDEC27m0IIwxRbl87LDK9yq+Rn89SoEWT19seaoTwBman8PW1Iv
	k1MzDsdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQrr-0000000DIW3-3D3h;
	Tue, 02 Jun 2026 15:17:23 +0000
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSVL9-00000005HJx-1hSk;
	Thu, 28 May 2026 07:39:41 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=u5ZL+hZHbV/pTWWeaWLQdg762ZQtOkbcULKixMOn0bQ=;
	b=1WB2GNzIiq2qfSiouaY2eBpNlTCp9CXSIQnP/DR+JRdUP9LOzMG39nBxhaSnx3i1EvTkk0koF
	MP95rV5mkYXdTAj5/1AL8Fatw2aQLMSIwUnEOl/84G4vPpz+9p58t8kHNA5P7Gcj6jk63HEJBED
	bJc80/B28puWomV5/AKUkWE=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gQyq556rjzcb23;
	Thu, 28 May 2026 15:31:45 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 13B044056A;
	Thu, 28 May 2026 15:39:34 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 15:39:28 +0800
Message-ID: <8aaa1d2e-09cc-4d58-b90e-1869d1bf55b2@huawei.com>
Date: Thu, 28 May 2026 15:39:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/17] arm64/riscv: Add support for crashkernel CMA
 reservation
To: Mike Rapoport <rppt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
	<saravanak@kernel.org>, <akpm@linux-foundation.org>, <bhe@redhat.com>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <pmladek@suse.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <thuth@redhat.com>, <ardb@kernel.org>,
	<masahiroy@kernel.org>, <mark.rutland@arm.com>, <maz@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <sourabhjain@linux.ibm.com>,
	<yeoreum.yun@arm.com>, <coxu@redhat.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
	<ritesh.list@gmail.com>, <songshuaishuai@tinylab.org>,
	<junhui.liu@pigmoral.tech>, <vishal.moola@gmail.com>, <kas@kernel.org>,
	<debug@rivosinc.com>, <namcao@linutronix.de>, <liaoyuanhong@vivo.com>,
	<fuqiang.wang@easystack.cn>, <seanjc@google.com>, <guoren@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <lizhengyu3@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20260525084932.934910-1-ruanjinjie@huawei.com>
 <CAAhV-H4NA7vgyxKnK+N_3C6pWBnwXc2URUyLh_h1m-MO=MnsGQ@mail.gmail.com>
 <ahQ0WRiMsB011tym@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ahQ0WRiMsB011tym@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_003940_521672_9DDD9D16 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 02 Jun 2026 08:17:11 -0700
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



On 5/25/2026 7:36 PM, Mike Rapoport wrote:
> Hi Huacai,
> 
> On Mon, May 25, 2026 at 06:14:52PM +0800, Huacai Chen wrote:
>> On Mon, May 25, 2026 at 4:50 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>>
>>> Jinjie Ruan (16):
>>>   riscv: kexec_file: Fix crashk_low_res not exclude bug
>>>   powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
>>>   arm64: kexec: Fix image->elf_headers memory leak during retry loop
>>>   x86/kexec: Fix potential buffer overflow in prepare_elf_headers()
>>>   arm64: kexec_file: Fix potential buffer overflow in
>>>     prepare_elf_headers()
>>>   riscv: kexec_file: Fix potential buffer overflow in
>>>     prepare_elf_headers()
>>>   LoongArch: kexec: Fix potential buffer overflow in
>>>     prepare_elf_headers()
>>>   crash: Add crash_prepare_headers() to exclude crash kernel memory
>>>   arm64: kexec_file: Use crash_prepare_headers() helper to simplify code
>>>   x86/kexec: Use crash_prepare_headers() helper to simplify code
>>>   riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
>>>   LoongArch: kexec: Use crash_prepare_headers() helper to simplify code
>>>   crash: Use crash_exclude_core_ranges() on powerpc
>>>   arm64: kexec: Add support for crashkernel CMA reservation
>>>   riscv: kexec: Add support for crashkernel CMA reservation
>>>   arm64/crash: Add crash hotplug support
>> I have some bikesheedings about the subjects. Can we unify the prefix formats?
>> x86/kexec, arm64: kexec_file, riscv: kexec_file, LoongArch: kexec .....
> 
> It might look weird in the series, but powerpc and x86 use '/' and arm64 and
> riscv use ':' so in the logs in arch/ this would be actually fine.
> 
> With the only exception of arm64/crash that should have been arm64: crash:

Thanks, will update it in next version.

>  
>> Huacai
> 


