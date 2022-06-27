Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A96C433EF
	for <kexec@archiver.kernel.org>; Mon, 27 Jun 2022 09:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QcwWW3B9mVibJL0COkHkcg2iAUnJdfXUwLaNXluURsE=; b=sKmTrWXwhVmQhDtRmjuRlpSZt7
	9zCcVYAq7VF6ZbYQuzOvlCkksCpVdEpAdcUBoNu9EzM/2sADZEgOryQis6Lyagmbf5WfYE6KXRygb
	bUkMGjbaWsn27WkXjgxEVkFesBwD+9GwZuNRGAZha2h+pF8NYwu+ll/OEmqX+C0xlFsMvpDFvjrU6
	OI2nPX1Bx2cHk6qYpHeABXgmChA6TAc+V/BYMPWBWU0lORMjJ+A9mjGn84PK0rYRALJC9+yEW7YHj
	3Ty3enn0oK8gR/Dmhdg1OiDvF004zIeqpL44W4mZxZJ0xn8MwY7Rs3D8iClXKHki4QEDpa1gnQQjN
	AFk/QsIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5l0Z-00HI8f-KT; Mon, 27 Jun 2022 09:26:15 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5ksX-00HEBG-Fy; Mon, 27 Jun 2022 09:18:00 +0000
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LWhsP34JVz1L8j0;
	Mon, 27 Jun 2022 17:15:37 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 17:17:50 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 17:17:49 +0800
Subject: Re: [PATCH 5/5] arm64: kdump: Don't defer the reservation of crash
 high memory
To: Baoquan He <bhe@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>
CC: Kefeng Wang <wangkefeng.wang@huawei.com>, Ard Biesheuvel
	<ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Eric
 Biederman" <ebiederm@xmission.com>, Rob Herring <robh+dt@kernel.org>, "Frank
 Rowand" <frowand.list@gmail.com>, <devicetree@vger.kernel.org>, Dave Young
	<dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Will Deacon
	<will@kernel.org>, <linux-arm-kernel@lists.infradead.org>, Jonathan Corbet
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Chen Zhou
	<dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>, "Dave
 Kleikamp" <dave.kleikamp@oracle.com>, liushixin <liushixin2@huawei.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com> <YrIIJkhKWSuAqkCx@arm.com>
 <YrLUREAoBMSZo7RR@MiWiFi-R3L-srv> <YrRzvO5F0dumsbAU@arm.com>
 <Yrkbak66vYT55H4x@MiWiFi-R3L-srv>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e3318551-4134-245a-c060-86ab81eb3e68@huawei.com>
Date: Mon, 27 Jun 2022 17:17:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Yrkbak66vYT55H4x@MiWiFi-R3L-srv>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_021757_933558_9EA4D82F 
X-CRM114-Status: GOOD (  18.61  )
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



On 2022/6/27 10:52, Baoquan He wrote:
> On 06/23/22 at 03:07pm, Catalin Marinas wrote:
>> On Wed, Jun 22, 2022 at 04:35:16PM +0800, Baoquan He wrote:
>>> On 06/21/22 at 07:04pm, Catalin Marinas wrote:
>>>> The problem with splitting is that you can end up with two entries in
>>>> the TLB for the same VA->PA mapping (e.g. one for a 4KB page and another
>>>> for a 2MB block). In the lucky case, the CPU will trigger a TLB conflict
>>>> abort (but can be worse like loss of coherency).
>>>
>>> Thanks for this explanation. Is this a drawback of arm64 design? X86
>>> code do the same thing w/o issue, is there way to overcome this on
>>> arm64 from hardware or software side?
>>
>> It is a drawback of the arm64 implementations. Having multiple TLB
>> entries for the same VA would need additional logic in hardware to
>> detect, so the microarchitects have pushed back. In ARMv8.4, some
>> balanced was reached with FEAT_BBM so that the only visible side-effect
>> is a potential TLB conflict abort that could be resolved by software.
> 
> I see, thx.
> 
>>
>>> I ever got a arm64 server with huge memory, w or w/o crashkernel setting 
>>> have different bootup time. And the more often TLB miss and flush will
>>> cause performance cost. It is really a pity if we have very powerful
>>> arm64 cpu and system capacity, but bottlenecked by this drawback.
>>
>> Is it only the boot time affected or the runtime performance as well?
> 
> Sorry for late reply. What I observerd is the boot time serious latecy
> with huge memory. Since the timestamp is not available at that time,
> we can't tell the number. I didn't notice the runtime performance.

There's some data here, and I see you're not on the cc list.

https://lore.kernel.org/linux-mm/1656241815-28494-1-git-send-email-guanghuifeng@linux.alibaba.com/T/

> 
> .
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
