Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C53C05027
	for <kexec@archiver.kernel.org>; Fri,  3 Feb 2023 17:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QLrX1UC1CZx8tyeh6Rh5WLsqEtBb4lzsChTU6B8B/s8=; b=bYR+Lz8NQr24Pi
	8RZzwWhMODJhkopqyjcm213Ro62ujI0lE9hcVVACtC97cYdtco1aUaIskyGlK+I5JOdy6aWccHYRV
	+TIg/byA+DCPNcTT89pXZJybuPJwZA+IH1bmIVY7xMOftLqC/X8l88+2g5nmzH3WoSbLwOebLWpTU
	3BLANzEUK7PsRkO/WcHJnW/f1Wmwpx+HQy1cUgZvAW66rM9AUE0E5nnj2ym2cmgC79tkEZIyY2RrC
	3xcjdnG6xWcU4CDE499mHpWAAO9Cjuds/K86X5FZERaeXrVxh8IflUhoRJWPE3beKJRUtF5QGspG3
	MlPIhVJztl/iKxq6LswQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pO0Ch-0037vr-F3; Fri, 03 Feb 2023 17:50:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pO0Ce-0037uM-4v; Fri, 03 Feb 2023 17:50:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5497961FA3;
	Fri,  3 Feb 2023 17:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A4BC433EF;
	Fri,  3 Feb 2023 17:50:18 +0000 (UTC)
Date: Fri, 3 Feb 2023 17:50:15 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org
Subject: Re: [PATCH v2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y91JV7wNu1QQh1Ag@arm.com>
References: <20230203075723.114538-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230203075723.114538-1-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_095024_282656_490F6354 
X-CRM114-Status: GOOD (  19.39  )
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

On Fri, Feb 03, 2023 at 03:57:23PM +0800, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region top down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region. Please see the details in
> Documentation/admin-guide/kernel-parameters.txt.
> 
> While we observed an unexpected case where a reserved region crosses the
> high and low meomry boundary. E.g on a system with 4G as low memory end,
> user added the kernel parameters like: 'crashkernel=512M,high', it could
> finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> The crossing 4G boudary of crashkernel high region will bring issues:
> 
> 1) For crashkernel=x,high, if getting crashkernel high region across
> 4G boudary, then user will see two memory regions under 4G, and one
> memory region above 4G. The two crashkernel low memory regions are
> confusing.

Looking at your patch, I just realised that the 4G boundary between
'low' and 'high' reservations is not always true. On RPi4, that would be
1GB, the limit of ZONE_DMA. Are there user-space tools that rely on this
32-bit boundary? If they do, they'd get confused on RPi4, not sure they
have the notion of the actual ZONE_DMA that the kernel has enabled. If
we do want ,high to mean always 4G or higher, we'd need to change the
logic a bit so that the search_base starts from 4G rather than
CRASH_ADDR_LOW_MAX. We could leave the latter when ,high was not
specified.

> 2) If people explicityly specify "crashkernel=x,high crashkernel=y,low"
> and y <= 128M, when crashkernel high region crosses 4G boudary and the
> part below 4G of crashkernel high reservation is bigger than y, the
> expected crahskernel low reservation will be skipped. But the expected
> crashkernel high reservation is shrank and could not satisfy user space
> requirement.

I guess if the user passes both high and low, we should honour that and
ignore any y <= 128M checks.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
