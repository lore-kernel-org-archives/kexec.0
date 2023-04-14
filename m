Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF87C77B61
	for <kexec@archiver.kernel.org>; Fri, 14 Apr 2023 02:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cIxJ3XvkSigwS0zpn4FjgrE7Z0/4unQXTw5Q7pYCZgQ=; b=cGrI2YZgYUwVX07HzQ0pc8IhFH
	uDU+UPnOelsf34dRxaDymf9PrC3XXome9f55YYuC4aKDk37ksYu2foKiucA7EIexxck9YGJ44ktv0
	k3dYbV6/nO2ZPx9xKGPCij5IvsLqBd8MJ6GHew+q2u/FnMfWALaM9/n1c0UA7YzswV8ZvGj2jkLYj
	a4SNmBYg2BxI586TfOWtrC1ZkEayWVtWEVAqx/jbAyFj7BjG6c78kujFiM3tCAAIw8KDB6VtvFmY2
	lMMsc41xMmLHGUNNViT1I7Uf9OY8GhuqRR9veqviBeZOGc4zAtfOufIxz5jFtXxmN6kHb6M1cxudQ
	10HOyxqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pn9AF-0087BY-39;
	Fri, 14 Apr 2023 02:27:51 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pn9AD-00878w-0G;
	Fri, 14 Apr 2023 02:27:50 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PyKzN1lFDzKyTr;
	Fri, 14 Apr 2023 10:25:04 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 10:27:40 +0800
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
To: Catalin Marinas <catalin.marinas@arm.com>, Baoquan He <bhe@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <horms@kernel.org>,
	<John.p.donnelly@oracle.com>, <will@kernel.org>, <kexec@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20230407022419.19412-1-bhe@redhat.com>
 <ZC+Axh1G/+NyIdwg@MiWiFi-R3L-srv> <ZDabRr/yyakrrDDO@arm.com>
 <ZDezLrWSg7qd5K08@MiWiFi-R3L-srv> <ZDgSCfLMtL9heS8J@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <1ab19701-b72f-34f8-8feb-662a7dc59580@huawei.com>
Date: Fri, 14 Apr 2023 10:27:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZDgSCfLMtL9heS8J@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_192749_305722_B6A4FED5 
X-CRM114-Status: GOOD (  10.69  )
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



On 2023/4/13 22:30, Catalin Marinas wrote:
> On Thu, Apr 13, 2023 at 03:45:50PM +0800, Baoquan He wrote:
>> I am OK with this version, or the version with min(SZ_4G,
>> arm64_dma_phys_limit), or v4. Please help point out if I got your idea
>> correctly. Thanks a lot.
> 
> I think we should stick to this patch. The disabling of the ZONE_DMA(32)
> is fairly specialised and you are right that we should not introduce an
> artificial 4GB crashkernel boundary on such systems. The slight
> confusion may be that ,high triggers a search above 4GB where there's
> not such boundary but this would match the documentation anyway.
> 

Agreed, so careful.

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
