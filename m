Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F07C2BD09
	for <kexec@archiver.kernel.org>; Tue,  9 Jul 2024 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0eahge8nxBoNPBuqM+kWCf/LOg4HkG/kB3OVy48in9M=; b=jgAxPLf6I+fKEV
	HoZ+XOh9zwKb/nH4JGi2M45C2G2Lvfn6Jfd3pSi+hApzvPYh6Vrb9HS/7RPiQ6giQgJiSt0UnXV15
	w2/jxf63R1e4x1mgytaN02vVJtXQ8JDWMPn3pkpK57/nqHJyzlthxklhx2durCrGJb7k7GM+rKAHe
	AhD8BMp4y3kd9x4OaWjMjOGVMrTviatff9WSDnVGi3YRcHtfalBwE9gpK7got3eYQpDFghDLKBsQ3
	dkbXfaukL9+/bMFwMRD1/IgkScf1yvutgog46y4Iu12xfosL9cs7dgM+7uhqM2rz3o6FsLO5PliPo
	29IPxUTqrMg0LF6troHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR8ft-00000006v1k-1eY5;
	Tue, 09 Jul 2024 11:06:21 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR8fp-00000006uyy-2TWx;
	Tue, 09 Jul 2024 11:06:20 +0000
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WJJ7Y6nVDzcpHh;
	Tue,  9 Jul 2024 19:05:45 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id EA4E31400D1;
	Tue,  9 Jul 2024 19:06:11 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 19:06:10 +0800
Message-ID: <01869981-b1de-32cb-bd25-d6ea09752b3d@huawei.com>
Date: Tue, 9 Jul 2024 19:06:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/3] ARM: Use generic interface to simplify crashkernel
 reservation
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <linux@armlinux.org.uk>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<arnd@arndb.de>, <afd@ti.com>, <akpm@linux-foundation.org>,
	<rmk+kernel@armlinux.org.uk>, <linus.walleij@linaro.org>,
	<eric.devolder@oracle.com>, <gregkh@linuxfoundation.org>, <deller@gmx.de>,
	<javierm@redhat.com>, <robh@kernel.org>, <thunder.leizhen@huawei.com>,
	<austindh.kim@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
 <Zo0DCVXvCryDr7WN@MiWiFi-R3L-srv>
 <3157befe-431f-69ac-b9d3-7a8685ba3a4d@huawei.com>
 <Zo0TbmSnHbiz5YQn@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zo0TbmSnHbiz5YQn@MiWiFi-R3L-srv>
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_040617_846255_A9EDA1F1 
X-CRM114-Status: GOOD (  11.58  )
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



On 2024/7/9 18:39, Baoquan He wrote:
> On 07/09/24 at 05:50pm, Jinjie Ruan wrote:
>>
>>
>> On 2024/7/9 17:29, Baoquan He wrote:
>>> On 07/08/24 at 09:33pm, Jinjie Ruan wrote:
>>>> Currently, x86, arm64, riscv and loongarch has been switched to generic
>>>> crashkernel reservation. Also use generic interface to simplify crashkernel
>>>> reservation for arm32, and fix two bugs by the way.
>>>
>>> I am not sure if this is a good idea. I added the generic reservation
>>> itnerfaces for ARCH which support crashkernel=,high|low and normal
>>> crashkernel reservation, with this, the code can be simplified a lot.
>>> However, arm32 doesn't support crashkernel=,high, I am not sure if it's
>>> worth taking the change, most importantly, if it will cause
>>> misunderstanding or misoperation.
>>
>> Yes, arm32 doesn't support crashkernel=,high.
>>
>> However, a little enhancement to the generic code (please see the first
>> patch), the generic reservation interfaces can also be applicable to
>> architectures that do not support "high" such as arm32, and it can also
>> simplify the code (please see the third patch).
> 
> Yeah, I can see the code is simplified. When you specified
> 'crashkernel=xM,high', do you think what should be warn out? Because
> it's an unsupported syntax on arm32, we should do something to print out
> appropriate message.

Yes, you are right! In this patch it will print "crashkernel high memory
reservation failed." message and out for arm32 if you specify
'crashkernel=xM,high because "CRASH_ADDR_LOW_MAX" and
"CRASH_ADDR_HIGH_MAX" is identical for arm32. And it should also warn
out for other similar architecture.


> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
