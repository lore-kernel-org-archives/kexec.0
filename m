Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055CEC6FD1C
	for <kexec@archiver.kernel.org>; Sat, 25 Mar 2023 02:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=f4TJmHnzYiUsslyal1nhnq710G2AvMTXfpXas2SBgzs=; b=DwDfP++cW0v9EBke8jEFcZQfZL
	hQCQ1Zej9PDIFFK5iTqjAs7bd8Ow4WycQvmN5Gr2Moj8RMcX2jhqRbxQq9QDBkrRMekAyaaTAADJk
	idg5d78sF/NmdPxkb9VrHuejPDurRGYduHCbHC/IbfGNxIQCLkU6Bkk/nEEYavasTJNqdJ9JXOllR
	zjLnioq3OtIIcDeclLvVR32AGSeAoaaPb36rL89+tX0RZrj/HZgEONDgzAy4qBoRwvGxnRkCa4+yU
	0aWg770sZNb/VPSWL24X0gT7VRqoD4Qv/98iuIS3sZIyydEA00r2sOcZM2J7GG9l4K1XQ2PoRdn+L
	89mStIqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pftQT-005yV2-31;
	Sat, 25 Mar 2023 02:14:37 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pftQQ-005yUJ-20;
	Sat, 25 Mar 2023 02:14:36 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pk2cM4kqpzSp0c;
	Sat, 25 Mar 2023 10:10:59 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 10:14:28 +0800
Subject: Re: [PATCH 0/3] arm64: kdump : take off the protection on crashkernel
 memory region
To: Catalin Marinas <catalin.marinas@arm.com>, Baoquan He <bhe@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <horms@kernel.org>,
	<John.p.donnelly@oracle.com>, <will@kernel.org>, <kexec@lists.infradead.org>,
	<ardb@kernel.org>, <rppt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20230324131838.409996-1-bhe@redhat.com>
 <ZB3Zx85Ajnhzq3Pt@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <9ca6f729-989d-654a-83e6-c89d8f65c69d@huawei.com>
Date: Sat, 25 Mar 2023 10:14:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZB3Zx85Ajnhzq3Pt@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_191434_831559_50EAE5B1 
X-CRM114-Status: UNSURE (   9.95  )
X-CRM114-Notice: Please train this message.
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



On 2023/3/25 1:11, Catalin Marinas wrote:
> On Fri, Mar 24, 2023 at 09:18:35PM +0800, Baoquan He wrote:
>> Baoquan He (3):
>>   arm64: kdump : take off the protection on crashkernel memory region
>>   arm64: kdump: do not map crashkernel region specifically
>>   arm64: kdump: defer the crashkernel reservation for platforms with no
>>     DMA memory zones
>>
>>  arch/arm64/include/asm/kexec.h    |  6 -----
>>  arch/arm64/include/asm/memory.h   |  5 ----
>>  arch/arm64/kernel/machine_kexec.c | 20 --------------
>>  arch/arm64/mm/init.c              |  6 +----
>>  arch/arm64/mm/mmu.c               | 43 -------------------------------
>>  5 files changed, 1 insertion(+), 79 deletions(-)
> 
> This series works for me and it has a negative diffstat as well (though
> I'm sure people will try to bring it back ;)).

After the write protection is removed, it is recommended that crc32 check
be added. However, it can be added later.

> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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
