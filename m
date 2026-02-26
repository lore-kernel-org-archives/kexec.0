Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD4CFC591C
	for <kexec@archiver.kernel.org>; Thu, 26 Feb 2026 09:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cArUbXgPd0s4ZtREeL/7x46kP7PE/lat666eUsS6sDM=; b=ItnheGESydT+ZJQD2w6Ze4vbOl
	tSIjZZfXUH09Rj1ejGGldFB8W3GJvfu2aHV5faKxIkgdw2WGTMu2TKxc/umDmsHuUuSGp56iIUeS9
	x7gJTrEThy1BAbx685PmhA/q0dTkkfVzr3o2Se7ss3+rEwseBBRFGYa25PMQmvTE4xZb5DY6kKoTi
	N+lBNSfyxqmzQa+ixp5oJC0jktRbFHlGeDmnWS1EaaiYUTQsdpnngMowditMvN9ukRm7hIsWENA7u
	9O3kw7M3BpQTXGdc1FqhwK0fZrogzXds73HKtRDYPSlUOowGR0CvrNCWOgJ9sX3R1AyKJpZ7wtgjy
	XFHyZpMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvXmm-00000005pLK-3WCS;
	Thu, 26 Feb 2026 09:35:56 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvXmj-00000005pJv-3pm9;
	Thu, 26 Feb 2026 09:35:55 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cArUbXgPd0s4ZtREeL/7x46kP7PE/lat666eUsS6sDM=;
	b=DWNv0GeHcKAOhD5xvaCowiagwlW275NAmdFdeG8qlLEXg0HK9DVne1d75o15RGyJa7vwcAWO6
	vwEOtoSqxVKaatv+CDrTZSmvfXkTGoof3Dzf35VFrW/nnCipbp9TUQ6QsuUvS03Qv/DbB9CjEPb
	Q7rsPApKKIvJvhGOP5dZOd0=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fM5sq1r7Jz1BGGB;
	Thu, 26 Feb 2026 17:35:27 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cArUbXgPd0s4ZtREeL/7x46kP7PE/lat666eUsS6sDM=;
	b=DWNv0GeHcKAOhD5xvaCowiagwlW275NAmdFdeG8qlLEXg0HK9DVne1d75o15RGyJa7vwcAWO6
	vwEOtoSqxVKaatv+CDrTZSmvfXkTGoof3Dzf35VFrW/nnCipbp9TUQ6QsuUvS03Qv/DbB9CjEPb
	Q7rsPApKKIvJvhGOP5dZOd0=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fM5m15ySPz1T4Fg;
	Thu, 26 Feb 2026 17:30:25 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 11EC340567;
	Thu, 26 Feb 2026 17:35:19 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Feb 2026 17:35:15 +0800
Message-ID: <15ea8a98-2b0c-dd51-b0d4-911905b194c3@huawei.com>
Date: Thu, 26 Feb 2026 17:35:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v6 1/5] powerpc/crash: sort crash memory ranges before
 preparing elfcorehdr
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <rdunlap@infradead.org>, <pmladek@suse.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <paulmck@kernel.org>,
	<lirongqing@baidu.com>, <arnd@arndb.de>, <ardb@kernel.org>,
	<leitao@debian.org>, <rppt@kernel.org>, <cfsworks@gmail.com>,
	<ryan.roberts@arm.com>, <sourabhjain@linux.ibm.com>,
	<tangyouling@kylinos.cn>, <eajames@linux.ibm.com>, <hbathini@linux.ibm.com>,
	<ritesh.list@gmail.com>, <songshuaishuai@tinylab.org>,
	<samuel.holland@sifive.com>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
	<liaoyuanhong@vivo.com>, <fuqiang.wang@easystack.cn>, <jbohac@suse.cz>,
	<brgerst@gmail.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
References: <20260224085342.387996-1-ruanjinjie@huawei.com>
 <20260224085342.387996-2-ruanjinjie@huawei.com>
 <aaARRZh9k_0oG3Qo@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <aaARRZh9k_0oG3Qo@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_013554_314026_B00808C6 
X-CRM114-Status: GOOD (  12.73  )
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



On 2026/2/26 17:24, Baoquan He wrote:
> On 02/24/26 at 04:53pm, Jinjie Ruan wrote:
>> From: Sourabh Jain <sourabhjain@linux.ibm.com>
>>
>> During a memory hot-remove event, the elfcorehdr is rebuilt to exclude
>> the removed memory. While updating the crash memory ranges for this
>> operation, the crash memory ranges array can become unsorted. This
>> happens because remove_mem_range() may split a memory range into two
>> parts and append the higher-address part as a separate range at the end
>> of the array.
>>
>> So far, no issues have been observed due to the unsorted crash memory
>> ranges. However, this could lead to problems once crash memory range
>> removal is handled by generic code, as introduced in the upcoming
>> patches in this series.
>>
>> Currently, powerpc uses a platform-specific function,
>> remove_mem_range(), to exclude hot-removed memory from the crash memory
>> ranges. This function performs the same task as the generic
>> crash_exclude_mem_range() in crash_core.c. The generic helper also
>> ensures that the crash memory ranges remain sorted. So remove the
>> redundant powerpc-specific implementation and instead call
>> crash_exclude_mem_range_guarded() (which internally calls
>> crash_exclude_mem_range()) to exclude the hot-removed memory ranges.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan he <bhe@redhat.com>
>> Cc: Jinjie Ruan <ruanjinjie@huawei.com>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> 
> You should add your own Signed-off-by since you sent it out.

Ack, I'll add my Signed-off-by in the next revision.
Thanks,

> 
>> ---
>>  arch/powerpc/include/asm/kexec_ranges.h |  4 +-
>>  arch/powerpc/kexec/crash.c              |  5 +-
>>  arch/powerpc/kexec/ranges.c             | 87 +------------------------
>>  3 files changed, 7 insertions(+), 89 deletions(-)
> ......snip...
> 
> 

