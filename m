Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4E1CA5FCE
	for <kexec@archiver.kernel.org>; Mon,  5 Oct 2026 09:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CkUUeGIh3kP4fIVJghcEaOrcbgIUgfDuIpCQTsYKpyo=; b=f93FXOb3q6jMZfHZYMvzjHt92u
	8iGjViInkNkow7FXaw+I34/2qRC+9acw9feiQsTjfFCU2X+I8fxjXnXmREOJiWSxvUzJ1TMUUS3x8
	wmOz42QzwHa1MxXzoU+ST544Gyhor+NJfCLZ/J0ztALr0141bhmxxyMA3Rr+rhqyDaHsIU8ae0+B8
	aeqLCaAHBNamUyQqagZ7G9W83CuOZHBKBAiA6ZLOYzvVb380FD6yDAZ/GrFaTfxILIC2ri+riINE+
	cFH10/mN3IB0HV3TMWR3RdvIhlf0xbFZGqkSYPJ2yG03tSK27jMa2r6JMeSeuC52VBDBFcIxHmcUs
	NZaaBpWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDewt-0000000G0OP-1uUn;
	Mon, 05 Oct 2026 09:25:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDews-0000000G0OJ-0fuN
	for kexec@lists.infradead.org;
	Mon, 05 Oct 2026 09:25:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3F45F60235;
	Mon,  5 Oct 2026 09:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F2B1F000FF;
	Mon,  5 Oct 2026 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791192329;
	bh=CkUUeGIh3kP4fIVJghcEaOrcbgIUgfDuIpCQTsYKpyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FJV0reNDGvu7DY11soQZV1gb5UdplgsuFI33QImxR8yoJsZx4IbrISNf0obiGSLEw
	 xP7qFWGncT085atN2IwdSmGV383pGxjetlhZ69f1Ipi7RTUm2aseNfxcv7s0NBgG7b
	 T8dNpvPU/Ay2VKbi0+upMUNyi+H5F/83/1kC/2nAqXd/4LJ5+Wm3nlFmotUMutxlV6
	 kgmO/xBcj7AtN2aLAU2BotQ48s7O3LHzFLYo+cWkpGs1ALRBMaILoG2PpZuCaj7s/q
	 eMq3ZqyLQ4OI9gW9ccTp7+HW84iD63ThdKnJNQZ0eEepYm2LqE/2PF1gCNNvdQJu41
	 NGGYBtBmhqkOA==
Date: Mon, 5 Oct 2026 10:25:26 +0100
From: Simon Horman <horms@kernel.org>
To: Joseph Cathcart <josephc@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org,
	eoin.mcnamara@ibm.com, iii@de.ibm.com
Subject: Re: [PATCH v2] kexec-tools/s390: add --reuseinitrd support
Message-ID: <20261005092526.GE184916@horms.kernel.org>
References: <20260820101350.4413-1-josephc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820101350.4413-1-josephc@linux.ibm.com>
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

On Thu, Aug 20, 2026 at 12:13:50PM +0200, Joseph Cathcart wrote:
> Currently, the --reuseinitrd param is not supported on s390. This
> prevents testing kexec in environments such as virtme-ng, which by
> default does not store the initrd on disk.
> 
> When --reuseinitrd is specified, fetch retained initrd memory range
> from /proc/iomem and fill new kernel parmarea directly with retained
> initrd base and size, rather than memory range of a new ramdisk.
> 
> Add die() cases for when user uses --reuseinitrd:
>         - in addition to --ramdisk or --initrd
>         - while booting a crash kernel.
>         - with kexec-file-load syscall (default syscall)
>         - and no initrd entry is found in /proc/iomem
> 
> Signed-off-by: Joseph Cathcart <josephc@linux.ibm.com>

Sorry if this is a duplicate.
But it seems that I applied this patch some time ago
but forgot to send out a notification about that.

So, FTR, this patch was applied as:

- kexec-tools/s390: add --reuseinitrd support
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=43c5cba85ad2


