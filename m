Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B910C43602
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 11:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pkBGpLmtsEEeRaJhMIRqkL1GKSIf2XGxguwcqieH/g4=; b=TX/ZJxrityBSZ5jiD+NwLNpeM9
	7StF0TNpJLZopL9jwXnyzSZ6PCs9FkJPHXjDY8jKbwU+r3uNwBWCS52oUPtybtQFcVSTnyamqD9xR
	TuAxM+5J83obYwbIaG/nyF0Gg2xCG63oN7lGKNT/CidHvDzBuVKejlE8RnpLwm4uGt5MIo581zRPk
	Vbd1cQTdS5GzvAEZ5lACH3tWHrT1IXEYrMyVvosDFy1Dke/vX+0FLIyWiAUfq4SNMFAWjjAgrng2k
	n7ejWnLzR6FGJg7Qd5ebxf1SfEmUi5QDONFelQZ386EkUGoWOxPHCfVuJyfURCXgVzQVzURR63UXk
	sAbq3KJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weWIi-0000000Gn5v-1NnY;
	Tue, 30 Jun 2026 11:06:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weWIg-0000000Gn5D-3bxe;
	Tue, 30 Jun 2026 11:06:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4E8D1600C3;
	Tue, 30 Jun 2026 11:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C171F000E9;
	Tue, 30 Jun 2026 11:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817606;
	bh=pkBGpLmtsEEeRaJhMIRqkL1GKSIf2XGxguwcqieH/g4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZQIEMpuUmQZkczHS1IWJqPDhkgBj56796odq3/JvTLVjcNHHc31D/nttFgIixltDD
	 fvh/NWoOmlY1pRVfm4kSh17IeHaesxP4GLpUn/HExfYszLJWNcgrt7bQIPBs1VJ9ie
	 E+X/tXsHlnOljHy/HM6tm2+dq7ONAjO6ZtbVU4IbwuQuU2RjR27PHLYoftDiigEuLR
	 YlNl5z2+Y+CDger9PLjYw/Yd8Kbz124TcBuYx71ie/F4xSgfGU6bbg5zzSVPHwHufU
	 /JR39e288Aj2Vg90vyf64D4pAv0ul+QBW9QTUOyCPHglNRMUMMKm0Ot02y5ILAMhI4
	 hzNU9Pif1F/1w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: chenhuacai@kernel.org,  kernel@xen0n.name,  pjw@kernel.org,
  palmer@dabbelt.com,  aou@eecs.berkeley.edu,  robh@kernel.org,
  saravanak@kernel.org,  bhe@redhat.com,  rppt@kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  loongarch@lists.linux.dev,  linux-riscv@lists.infradead.org,
  devicetree@vger.kernel.org,  kexec@lists.infradead.org,
  iommu@lists.linux.dev,  zhaomeijing@lixiang.com,
  catalin.marinas@arm.com,  will@kernel.org,  alex@ghiti.fr,
  akpm@linux-foundation.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  ruirui.yang@linux.dev,  m.szyprowski@samsung.com,
  robin.murphy@arm.com
Subject: Re: [PATCH v4 08/10] arm64: kdump: exclude non-dumpable reserved
 memory regions from vmcore
In-Reply-To: <20260630074715.4126796-9-chenwandun1@gmail.com> (Wandun Chen's
	message of "Tue, 30 Jun 2026 15:47:12 +0800")
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
	<20260630074715.4126796-9-chenwandun1@gmail.com>
Date: Tue, 30 Jun 2026 13:06:40 +0200
Message-ID: <2vxzik70i8xr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Jun 30 2026, Wandun Chen wrote:

> From: Wandun Chen <chenwandun@lixiang.com>
>
> Reserved memory regions are excluded from vmcore by default unless
> marked dumpable. Honor the dumpable flag to filter out device firmware
> regions (e.g., GPU, DSP, modem) reserved via device tree, since they
> typically contain data not useful for kernel crash analysis and can
> significantly increase vmcore size.
>
> Use of_reserved_mem_kdump_exclude() to perform the exclusion, and
> pre-size the crash_mem array via of_reserved_mem_kdump_nr_ranges().
>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> Acked-by: Will Deacon <will@kernel.org>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

