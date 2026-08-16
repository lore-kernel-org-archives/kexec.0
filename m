Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A52C5B572
	for <kexec@archiver.kernel.org>; Sun, 16 Aug 2026 09:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8dRSSX2JAQZgwWhR5q7ZovzbG0pw2Sc7JhH34Ynua1Y=; b=X47PislS4gIjlP4U4BB01VZjPk
	KFskx/tgN7adLe0lhnR71E2i6/0FrasIIlAsQ5kUMs01aojQg35fn2kEoBMrvN2dlzsG2+Q48+jjN
	yOTuNKIY4aD6HZ64x2wTfdIbYPL54tRGwGeQCtyX7j27UiMk95E/4LkXDK6tykZi8OTTJ8So9NEsG
	85FILzH3fVNbcenCnPfZ1hx2YPOxVwwBcoPjDAPy248wlaSKVi7oxDHrnA7tGphBtsPvrqPLZQ6pd
	AUTXecOfUWdnySRYLMJUsV7CAyUSTa2CtsQocJ4oIU9HpiMJzbxL7VTX0Y1Ww7ERqOYzitVTKYCVW
	jCHYygOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvWly-00000004bDW-06tx;
	Sun, 16 Aug 2026 09:03:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvWlw-00000004bDQ-3VXd
	for kexec@lists.infradead.org;
	Sun, 16 Aug 2026 09:03:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D0C5D40962;
	Sun, 16 Aug 2026 09:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC681F00A3A;
	Sun, 16 Aug 2026 09:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786870995;
	bh=8dRSSX2JAQZgwWhR5q7ZovzbG0pw2Sc7JhH34Ynua1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HhlJuTsS9etJriQhma1EQG8iRFbEildqNTcjp8UrZmjCy1Y5uyZVhxDqZ2UN7jX45
	 /UmEPju6KkW9SBS0sH5Ao29HbZ3Z10Qj2m51ct1m2ZQdSxr52E1SOmc/9PSmIZ5wDb
	 yRgDcOXTgeBylHjxFIR/piJvlU9UmKKSX6aYLaeKITrReJxEZvEgDvnzqphs8kRwS0
	 J7NCjjOaJ6NbSIM4WTO4+qJMk8FkR0qvpthCeYfRt3PDxuOPZj/PgdnKVEsnwEj/7z
	 pMUB8xnDnnAlObV5tuwZEQrEkq71yXpl+HpnF+51DEptXpjFV4NruVV3/cD2WR1Cbl
	 43c1uP2lb/vHg==
Date: Sun, 16 Aug 2026 12:03:08 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Maxi Saparov <maxi.saparov@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, sdimitropoulos@coreweave.com,
	Maxi Saparov <masaparov@coreweave.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] kho: do not reserve scratch memory in the kdump kernel
Message-ID: <aoF8zPXiKpjt2Nsv@kernel.org>
References: <20260803193938.8778-1-maxi.saparov@gmail.com>
 <20260811161857.3096-1-maxi.saparov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811161857.3096-1-maxi.saparov@gmail.com>
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

Hi,

Please don't send vN+1 as a reply to vN next time.

On Tue, Aug 11, 2026 at 12:18:57PM -0400, Maxi Saparov wrote:
> From: Maxi Saparov <masaparov@coreweave.com>
> 
> If a kernel with CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y (or kho=on)
> does not receive a handover FDT, it reserves KHO scratch memory in
> kho_reserve_scratch().
> 
> The kdump kernel always takes this path. Since commit a6715d7ec472
> ("kho: skip KHO for crash kernel"), the kernel does not add KHO
> metadata to the crash kimage. As a result, the kdump kernel never
> receives a handover FDT and always reserves scratch memory.
> 
> The kdump kernel boots in the small crashkernel= memory reservation.
> On our x86 hosts, the kernel and initramfs make approximately 176 MB
> of early reservations. The scratch areas then use approximately
> 650 MB more of the crashkernel memory. When a large early allocation
> fails, the kdump kernel panics:
> 
>   bio: can't create integrity buf pool
> 
> A kdump kernel has nothing to hand over: its only task is to dump the
> memory of the old kernel and reboot. Fix is to disable KHO at the top of
> kho_memory_init() so that the kdump kernel does not reserve scratch
> memory.
> 
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxi Saparov <masaparov@coreweave.com>

I queued this patch for v7.4, it'll appear in the liveupdate tree after the
merge window.

> ---
> v2: Move the kdump check to the top of kho_memory_init() as an early return.
> v1: https://lore.kernel.org/all/20260803193938.8778-1-maxi.saparov@gmail.com/
> 
>  kernel/liveupdate/kexec_handover.c | 7 +++++++
>  1 file changed, 7 insertions(+)

-- 
Sincerely yours,
Mike.

