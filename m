Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AECECAAD5
	for <kexec@archiver.kernel.org>; Mon,  5 Sep 2022 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yNVkY1i+eWlo74no/++hwCKLRvoKkcsIPz4H4gGIbdY=; b=HUJ1phtH7WYCMW
	TeLWnJvNSeLxnUve15EGZFdjgAgt8HnrkNEY2qgJHZgpRZw56TmDqFb+1OMGx9QZaC7HzCnis6LXK
	fOLGZYteqcN+VqIVAERYSw+XEVXILTwKQ2i/c1go6IhnTRR7LVABCnZ2yA86VNvtYXHr5B16LoeI1
	PdMMAuCsQRZPJK3Emn6QT8hv5F1/ykpKlJTWAiw0TdS4ZLklRLmrwMq5Sj8xMcmoe2gSB48hc1Ozx
	AO/OZwgidkrsBoimoCX9YwR1qhdJxrnQB510Tq84+tmWH3eSx3vqXdCJ1ZrCu5P00TcFbvl3OoGGK
	7oJKP/iWTNcQm4SIKcUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVG5r-007jEn-C6; Mon, 05 Sep 2022 17:41:07 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV9Lz-000Gso-Rp; Mon, 05 Sep 2022 10:29:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 200CDB81085;
	Mon,  5 Sep 2022 10:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AD6C433D6;
	Mon,  5 Sep 2022 10:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662373756;
	bh=WlJQ2stKL5wf+I/xSf6BcWn5KmuI9TkM3tH0O9cnh3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZpIQhpmFit4FkPay59RFIocVuFZ4MW1FVM5Vjy4riQQTd1torqq3lf1ps2t2H15zy
	 12P12r1QtqRDQGSojls6fVzEhQdjVb1JGl8b3ERFSl4FJR+54jo2gu2cqrcd5Du1rH
	 2ZAr6fq3Nmw9mC706pAvdJoljWjvo+16vEw6PvewRgARpH6SNS0U/h36iNbL2K1svJ
	 Qyq3ugBNsht1uf8/AIbjEzg8ay3S+T8ilc+8pbeA0Fil04a2+0vJJOt5uwOvRW6tng
	 WDBmBUq0f4RIeTmd5B62vjMvS7i/LpvyrYp4LBOi4rAfI46jRGKsxgKp6V02xcDrl5
	 9j/soiF9+NlAg==
Date: Mon, 5 Sep 2022 13:28:58 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com, ardb@kernel.org,
	guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
	will@kernel.org, linux-mm@kvack.org, thunder.leizhen@huawei.com,
	wangkefeng.wang@huawei.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <YxXPannyTqBZInAt@kernel.org>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org>
 <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
 <YxBeS0G+F+fsBgod@kernel.org>
 <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_032920_675194_617F6517 
X-CRM114-Status: GOOD (  14.24  )
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

On Thu, Sep 01, 2022 at 08:25:54PM +0800, Baoquan He wrote:
> On 09/01/22 at 10:24am, Mike Rapoport wrote:
> 
> max_zone_phys() only handles cases when CONFIG_ZONE_DMA/DMA32 enabled,
> the disabledCONFIG_ZONE_DMA/DMA32 case is not included. I can change
> it like:
> 
> static phys_addr_t __init crash_addr_low_max(void)
> {
>         phys_addr_t low_mem_mask = U32_MAX;
>         phys_addr_t phys_start = memblock_start_of_DRAM();
> 
>         if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
>              (phys_start > U32_MAX))
>                 low_mem_mask = PHYS_ADDR_MAX;
> 
>         return low_mem_mast + 1;
> }
> 
> or add the disabled CONFIG_ZONE_DMA/DMA32 case into crash_addr_low_max()
> as you suggested. Which one do you like better?
> 
> static phys_addr_t __init crash_addr_low_max(void)
> {
>         if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
> 		return PHYS_ADDR_MAX + 1;
> 
>         return max_zone_phys(32);
> }
 
I like the second variant better.

-- 
Sincerely yours,
Mike.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
