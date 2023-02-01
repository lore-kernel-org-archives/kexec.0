Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E6CC38142
	for <kexec@archiver.kernel.org>; Wed,  1 Feb 2023 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gnDrdRUYFm1CEu5FtaQWAttGTGyQLqjuYTt9b1+leAo=; b=XU8UVukIlxUkNk
	MD5I5kyOP9g/xdo2al0Uz7GBUR7gvTKAetUztreoY3GnkZeKbMsNCrB8GSlSJ+KnpgH8ZmOEhJ2g8
	4hity8T6y4ZZ+zgKLJFMhvgpLHp+ysG0++AF1wKzQbdFbkHz4dotKtM3poGXv40AqDdco7yOnEElh
	F7djNZLhJ1hniWPFG577mI/kOS5tBTQnzEZ4/mWAEHTXLAkFE2KypnLGG2jQYIwkdSz2/JmyAkt1z
	TvUMdyyaLc7P81bk1JirCqTT6SZTNpd7i8OEjIKR165IMJc+6k5fskBCsVovVbD3gtKe5TIrfgyog
	Zw4TmoK5scV3iortEL4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNGaa-00CyBG-HL; Wed, 01 Feb 2023 17:08:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNGaX-00CyAC-EZ; Wed, 01 Feb 2023 17:08:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B2D2D6187D;
	Wed,  1 Feb 2023 17:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8840DC433D2;
	Wed,  1 Feb 2023 17:07:58 +0000 (UTC)
Date: Wed, 1 Feb 2023 17:07:55 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y9qca12Y/oCxcaFW@arm.com>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-2-bhe@redhat.com>
 <Y9AXKgJvUuilsWUX@arm.com>
 <Y9n/PTEv7oOObuLi@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9n/PTEv7oOObuLi@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_090801_555896_3C223533 
X-CRM114-Status: GOOD (  29.93  )
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

On Wed, Feb 01, 2023 at 01:57:17PM +0800, Baoquan He wrote:
> On 01/24/23 at 05:36pm, Catalin Marinas wrote:
> > On Tue, Jan 17, 2023 at 11:49:20AM +0800, Baoquan He wrote:
> > > On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> > > suitable memory region up down. If the 'xM' of crashkernel high memory
> > > is reserved from high memory successfully, it will try to reserve
> > > crashkernel low memory later accoringly. Otherwise, it will try to search
> > > low memory area for the 'xM' suitable region.
> > > 
> > > While we observed an unexpected case where a reserved region crosses the
> > > high and low meomry boundary. E.g on a system with 4G as low memory end,
> > > user added the kernel parameters like: 'crashkernel=512M,high', it could
> > > finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> > > This looks very strange because we have two low memory regions
> > > [4G-126M, 4G] and [1G, 1G+128M]. Much explanation need be given to tell
> > > why that happened.
> > > 
> > > Here, for crashkernel=xM,high, search the high memory for the suitable
> > > region above the high and low memory boundary. If failed, try reserving
> > > the suitable region below the boundary. Like this, the crashkernel high
> > > region will only exist in high memory, and crashkernel low region only
> > > exists in low memory. The reservation behaviour for crashkernel=,high is
> > > clearer and simpler.
> > 
> > Well, I guess it depends on how you look at the 'high' option: is it
> > permitting to go into high addresses or forcing high addresses only?
> > IIUC the x86 implementation has a similar behaviour to the arm64 one, it
> > allows allocation across boundary.
> 
> Hmm, x86 has no chance to allocate a memory region across 4G boundary
> because it reserves many small regions to map firmware, pci bus, etc
> near 4G. E.g one x86 system has /proc/iomem as below. I haven't seen a
> x86 system which doesn't look like this.
> 
> [root@ ~]# cat /proc/iomem 
[...]
> fffc0000-ffffffff : Reserved
> 100000000-13fffffff : System RAM

Ah, that's why we don't see this problem on x86.

Alright, for consistency I'm fine with having the same logic on arm64. I
guess we don't need the additional check on whether the 'high'
allocation reserved at least 128MB in the 'low' range. If it succeeded
and the start is below 4GB, it's guaranteed that it got the full
allocation in the 'low' range. I haven't checked whether your patch
cleaned this up already, if not please do in the next version.

And as already asked, please fold the comments with the same patch, it's
easier to read.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
