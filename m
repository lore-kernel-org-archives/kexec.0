Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502C6C6FD20
	for <kexec@archiver.kernel.org>; Fri, 24 Mar 2023 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pBupqWt5hxbx6S8vOWvteKDan/bVoTbsgYLEw4FTX2E=; b=bpzaXgvepYNC1d
	pA4FoYwraNSGZZY3eN+e47KzpzJ0DyWYx/BobjwWBoTDaWw2l0VOiS9dFb1dfOxwZX5lRy2qtemvF
	BpC5CAai49j8IP9Ylr2wL1nrzNOMUfRy1FHgHm31hNqvloX7qhuBSH/h64H6JRTIatzueDgYXro5h
	SmGgtiRA78MrYwhhzdXGEtdQe93+SnyGSclYCOkN3hEClDEBHI+V+RFPhUP0HKvYroA3B+m7I53vt
	X/0aaJzAUdfZcDqprtdrihPCc7LXtV+4bWGqFBhtbCRtmp9Tjs/SidKGtWbw5EBfG+8ufta4ba6U7
	6TFB4HVO/HG2OgSWvz4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfkxA-0053fz-2C;
	Fri, 24 Mar 2023 17:11:48 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfkx7-0053f7-2b;
	Fri, 24 Mar 2023 17:11:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BB47DB82580;
	Fri, 24 Mar 2023 17:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFFFC433EF;
	Fri, 24 Mar 2023 17:11:38 +0000 (UTC)
Date: Fri, 24 Mar 2023 17:11:35 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org, kexec@lists.infradead.org, ardb@kernel.org,
	rppt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64: kdump : take off the protection on
 crashkernel memory region
Message-ID: <ZB3Zx85Ajnhzq3Pt@arm.com>
References: <20230324131838.409996-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230324131838.409996-1-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_101145_993360_A29DD215 
X-CRM114-Status: GOOD (  10.37  )
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

On Fri, Mar 24, 2023 at 09:18:35PM +0800, Baoquan He wrote:
> Baoquan He (3):
>   arm64: kdump : take off the protection on crashkernel memory region
>   arm64: kdump: do not map crashkernel region specifically
>   arm64: kdump: defer the crashkernel reservation for platforms with no
>     DMA memory zones
> 
>  arch/arm64/include/asm/kexec.h    |  6 -----
>  arch/arm64/include/asm/memory.h   |  5 ----
>  arch/arm64/kernel/machine_kexec.c | 20 --------------
>  arch/arm64/mm/init.c              |  6 +----
>  arch/arm64/mm/mmu.c               | 43 -------------------------------
>  5 files changed, 1 insertion(+), 79 deletions(-)

This series works for me and it has a negative diffstat as well (though
I'm sure people will try to bring it back ;)).

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
