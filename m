Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C605FC3A5A7
	for <kexec@archiver.kernel.org>; Wed,  7 Dec 2022 01:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=r8q8eZNogxQTB+t/f7BZTYfS8WQRrp4+dliqznIcx7k=; b=LNFmIdCbaL6tTsjlccDaBW/xG2
	JBn0NPzRfhjhOWcZ3ORxIQFyVjijyj2gpjQWok6Zau8gXMOrwnaGWJmFlUmDfF1vaG0xIQ5Eedquv
	DXz5MH2ShyhWpz1caIt+ZnDJBJLVcejUBWd8FDGDOJyOd3bs+Gxuz9i9bqcWqXzy5alHAwvstUMTh
	PcmPUcUuZJxm5hcVm8stxMkjuQsvfoN1Cte/882NskFQzmixIdVqdp7e65LyV/VAD3WZSHO/5iiT5
	iasg+P8XuYEKCSW/bF82YB1MGkE73lSBfq2zAWQNAXiglc2gb+iP1/RGqZiIB3IP1MpPfoysoM5FY
	aaSG0hnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2jBk-007QCG-Vx; Wed, 07 Dec 2022 01:25:32 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2jBe-007Q2e-Vs; Wed, 07 Dec 2022 01:25:29 +0000
Received: from kwepemm600010.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NRfhS69xNzRpRj;
	Wed,  7 Dec 2022 09:24:24 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 09:25:14 +0800
Subject: Re: [PATCH 1/2] RISC-V: kexec: Fix memory leak of fdt buffer
To: Palmer Dabbelt <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
	<liaochang1@huawei.com>, <rdunlap@infradead.org>,
	<u.kleine-koenig@pengutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
	<lizhengyu3@huawei.com>, Palmer Dabbelt <palmer@dabbelt.com>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>
References: <20221104095658.141222-1-lihuafei1@huawei.com>
 <167027930833.25586.2671834159281320615.b4-ty@rivosinc.com>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <e1826450-296d-733e-c99d-318af7a236b0@huawei.com>
Date: Wed, 7 Dec 2022 09:24:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <167027930833.25586.2671834159281320615.b4-ty@rivosinc.com>
Content-Language: en-US
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_172527_224179_ACA2BB86 
X-CRM114-Status: GOOD (  11.18  )
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



On 2022/12/6 6:28, Palmer Dabbelt wrote:
> On Fri, 4 Nov 2022 17:56:57 +0800, Li Huafei wrote:
>> This is reported by kmemleak detector:
>>
>> unreferenced object 0xff60000082864000 (size 9588):
>>   comm "kexec", pid 146, jiffies 4294900634 (age 64.788s)
>>   hex dump (first 32 bytes):
>>     d0 0d fe ed 00 00 12 ed 00 00 00 48 00 00 11 40  ...........H...@
>>     00 00 00 28 00 00 00 11 00 00 00 02 00 00 00 00  ...(............
>>   backtrace:
>>     [<00000000f95b17c4>] kmemleak_alloc+0x34/0x3e
>>     [<00000000b9ec8e3e>] kmalloc_order+0x9c/0xc4
>>     [<00000000a95cf02e>] kmalloc_order_trace+0x34/0xb6
>>     [<00000000f01e68b4>] __kmalloc+0x5c2/0x62a
>>     [<000000002bd497b2>] kvmalloc_node+0x66/0xd6
>>     [<00000000906542fa>] of_kexec_alloc_and_setup_fdt+0xa6/0x6ea
>>     [<00000000e1166bde>] elf_kexec_load+0x206/0x4ec
>>     [<0000000036548e09>] kexec_image_load_default+0x40/0x4c
>>     [<0000000079fbe1b4>] sys_kexec_file_load+0x1c4/0x322
>>     [<0000000040c62c03>] ret_from_syscall+0x0/0x2
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] RISC-V: kexec: Fix memory leak of fdt buffer
>       https://git.kernel.org/palmer/c/96df59b1ae23
> [2/2] RISC-V: kexec: Fix memory leak of elf header buffer
>       https://git.kernel.org/palmer/c/cbc32023ddbd
> 
> These are on for-next.  They'd probably be fine fixes candidates had I gotten
> to them in time, but it's pretty late and a leak during kexec doesn't seem like
> a show-stopper.  They'll get backported anyway, but this way they get an extra
> week in linux-next just to see.
> 

I have no problem with it being merged into the -next branch. Thanks Palmer!

> Best regards,
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
