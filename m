Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E038EB64DA
	for <kexec@archiver.kernel.org>; Tue,  4 Jul 2023 03:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ssymgmHhroSnum6/tSB3h/4UUGeAMMv0nLr5c7+nI1E=; b=PjkSi6iLhK3meZ
	uA/1r68TBGhdkRetvvfLqrAlUyOVKaK5JSDvUfaRT4vNhwAAX59rs3gbnnqhZuKEfglhFbLEpjqt3
	iTYPnyDSsvRjjBu/iy3YKS8GJFc/9dtl64KIvMpptmkcRDHy/icIfE7mfO6ao7Til8/wOMvCxTuYJ
	ATndDLju6JE/QAKFBqtvGE70r0tnLEXff1/sk6+JSrYm5+PgEDCcfgMz6YSRPdJi+4KjcvMODRzZG
	gYhRgMkllL5GWsr0IdQtjx5TN9tfV/EG7fBH/X3vayFAQSGJ2mFzGYtZLDtgBA+rAhLOXPBIqin45
	ALf0iE/PHPcR90hsWx8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGX4V-00C4Zi-2p;
	Tue, 04 Jul 2023 03:51:23 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGX4S-00C4XS-12;
	Tue, 04 Jul 2023 03:51:22 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qw82s464lz1HCqB;
	Tue,  4 Jul 2023 11:50:45 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 4 Jul
 2023 11:51:09 +0800
Message-ID: <f6764156-ec85-ad0a-f0b7-030f24f4dee4@huawei.com>
Date: Tue, 4 Jul 2023 11:51:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v5 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <thunder.leizhen@huawei.com>, <horms@kernel.org>
References: <20230511085139.1039088-1-chenjiahao16@huawei.com>
 <20230511085139.1039088-2-chenjiahao16@huawei.com>
 <ZHwKFADVXyNYJBCp@MiWiFi-R3L-srv>
 <852b8777-3c6e-f76b-0413-1c66629f33cd@huawei.com>
 <5c80666c-e6e2-8fa6-50b6-89536315925e@huawei.com>
 <ZKD3tEBknEiF4PZK@MiWiFi-R3L-srv>
From: "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZKD3tEBknEiF4PZK@MiWiFi-R3L-srv>
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_205120_556898_6C0211E8 
X-CRM114-Status: GOOD (  16.74  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


On 2023/7/2 12:06, Baoquan He wrote:
> On 07/01/23 at 05:51pm, chenjiahao (C) wrote:
> ......
>> I have sent v6 patches, implementing the logic above. That fixes the
>> retrying
>>
>> logic and should be aligned with Arm64 code.
> Hmm, it has improved much, while there's still issue which need be
> fixed. You missed the case that crsahkernel low is specified as zero
> explicitly. Obviously your v6 is not able to handle that well. Means
> your v6 is not aligned with the current arm64 code completely.
>
> crashkernel=xM,high crashkernel=0M,low
>
>>
>> Please let me know if there is any problem remains.
> Earlier, I posted below RFC patchset to try to unify the
> crashkernel=,high support on x86, arm64 and risc-v, the generic arch.
> Wondering what you think about it. risc-v can be added in with very few
> change to get the crahskernel=,high support.
>
> [RFC PATCH 0/4] kdump: add generic functions to simplify crashkernel crashkernel in architecture
>
> Surely, the crashkernel=,high support can be added independently in
> advance. Later my patchset can unify them and remove the duplicated code
> in risc-v. It's up to you and risc-v maintainers/reivewers to take one.
> Anyway, I will add comment to your v6 to point out the issue.

It would be great if crashkernel parsing and reserving logic could be
unified on multiple architectures, the code would be more straightforward
and easy to use. I will have a more in-depth review of your RFC patchset
later.

Meanwhile, I will continue to update my patchset on risc-v, just wishing
to complement this feature earlier. When your unify solution get applied,
simply remove the duplicate part is OK. Before that, I will update my
risc-v code and further align with the Arm64 logic.

Thanks for your carefully review, I will fix the issue above and send
v7 patchset soon.

Thanks,
Jiahao

>
> Thanks
> Baoquan
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
