Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84C5C433FE
	for <kexec@archiver.kernel.org>; Tue, 15 Nov 2022 13:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Ygz10nkSLeJtUtc1QJXxtvkQr6pCoRa2TliehCTkvxI=; b=QIuKAxqUTy7A/vzoGtxepzPpf0
	c+3MhWG1iV3qU8yojHUNmJ0VcQ+L4biPL+cn222AySkuf780J7wxBC0gahoL4+YCY2T28FticrEma
	da8bGrk7C4+e6YH4MTDHzl88wVTy9F7Uu9LRwXw51WaV3T5furVGOma0r6qM1DLLgKXHHIwHki3AA
	7+a/cfcA0QUGFpakbaXgw3Nfr6PxYs/j7T3Xl8CaOVoBJWsS5A6mG+qLLnOtXN1zhawgUpYPTzg4Z
	T8AxwZXuTIujmm9EVtFaRCAMMMjpZdOS5k7r17eWYhP+ykGeGSuNcG6QfCCFT3TY0Ih5smUED7Ub/
	wmoz3Bjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouwBt-00BWT7-JI; Tue, 15 Nov 2022 13:41:29 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouwBL-00BWQb-B4; Tue, 15 Nov 2022 13:40:57 +0000
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBS406tV1zRpHQ;
	Tue, 15 Nov 2022 21:40:32 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 21:40:51 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 21:40:50 +0800
Subject: Re: [PATCH v3 0/2] arm64: kdump: Function supplement and performance
 optimization
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He
	<bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou
	<dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>, "Dave
 Kleikamp" <dave.kleikamp@oracle.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <20221115115837.GE32523@willie-the-truck>
 <6c1751be-9957-0765-5e68-2eb78adc9a94@huawei.com> <Y3OUc1N7Kif1pnZv@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <39839221-8567-39ad-dade-8d1500df2e8b@huawei.com>
Date: Tue, 15 Nov 2022 21:40:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y3OUc1N7Kif1pnZv@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_054055_584812_BEBBD526 
X-CRM114-Status: GOOD (  10.88  )
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



On 2022/11/15 21:30, Catalin Marinas wrote:
> On Tue, Nov 15, 2022 at 08:18:21PM +0800, Leizhen (ThunderTown) wrote:
>> On 2022/11/15 19:58, Will Deacon wrote:
>>> On Mon, Jul 11, 2022 at 05:03:17PM +0800, Zhen Lei wrote:
>>>> v2 --> v3:
>>>> 1. Discard patch 3 in v2, a cleanup patch.
>>>
>>> Do you plan to respin this series, addressing the various comments on v3?
>>
>> Yes, I haven't figured out where to make DEFAULT_CRASH_KERNEL_LOW_SIZE generic.
> 
> Do we need to? I'd just go with something like 128MB, specific to arm64,
> and we can increase it later if anyone comes up with a good argument.

Okay, then v3's easy. I'll do it tomorrow. I've tried it before. 128M is enough.

> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
