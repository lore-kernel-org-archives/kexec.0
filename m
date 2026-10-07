Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CD9CA5FFF
	for <kexec@archiver.kernel.org>; Wed,  7 Oct 2026 06:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SHTNYtREyl/jHXCf21L5IlTPz5bWxE9lwwBn75z0B7g=; b=b9VTEIWsteqi7CPilia/6qSL4m
	v+Egs69i+TuLQSsk8wx9OGcY/u7nlv458Gf56vJeAQJbDuGpQnS9LO/uZqDNvan+cB6aq+0ALibCo
	Y/9oltoEYo/a+NXiUUM6n+31JVvGcsxIx3wviq9lqEr8dkK7qdCj99TTCYJxfPFV3sTUDlU9RFl1L
	+/rvWVjHFmgoUaLp5IdHCoT4Rbvn3pO9MQ6aQ0axxX+ewHZOXLn5Ohaj6kkHMmzNpkRHaC95pjDJG
	NlHfZeNcIyxyW3qJ7eyR2zeXbqrcK9ERXjtu4bFvYAFp03A2X6CL+P3V6WG+f3IevxuD7VruzVpSJ
	6g23s/Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEKsi-00000001kgw-07Ld;
	Wed, 07 Oct 2026 06:12:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEKsg-00000001kgn-3KVF
	for kexec@lists.infradead.org;
	Wed, 07 Oct 2026 06:11:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E082D601FB;
	Wed,  7 Oct 2026 06:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788F71F0089B;
	Wed,  7 Oct 2026 06:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791353517;
	bh=SHTNYtREyl/jHXCf21L5IlTPz5bWxE9lwwBn75z0B7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GUXRZ7/pbe/AJpkN5e5FcdLKuJgDihokRM9FwbQxVdtvp+2LRSkZRdVJpTE58W4V6
	 NadEbJJreUG5ZHlSm5lZ/kScR9TQREkuTlYMfmadYLCnnhcsFnoxqr2OiLnEUNZWuq
	 ezVr4PgORcyU4YJMkI9wQr6DJOzeoucauYENm7ogq5W1+ZswY3InNw/cE9J6Qp5m7D
	 cvQCMK5tlmnYwkiHKEmF5ux/U5Wfqstw1sIxE2ErO9W6TbmevR9YrLXjkXZrkcTvuD
	 NW0AbPYQSCmA2pBAFsyhQ7q7ZYL7z/j4tXZa8uou3/iBwv4XtuDPfDM2G1wFOlRTFC
	 ONz6uDRN7u2yA==
Date: Wed, 7 Oct 2026 08:11:50 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Chris Bainbridge <chris.bainbridge@canonical.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Miu <jasonmiu@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [BUG] KHO handover hangs when memmap reserves PMEM
Message-ID: <asXipik00P2Oa1Zo@kernel.org>
References: <asE0R_f2r2TL-3Sy@px13>
 <asTTo3AFzQoqZLoP@kernel.org>
 <asU2AD6DxGSD0ek4@px13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asU2AD6DxGSD0ek4@px13>
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

On Tue, Oct 06, 2026 at 07:02:22PM +0100, Chris Bainbridge wrote:
> On Tue, Oct 06, 2026 at 12:55:31PM +0200, Mike Rapoport wrote:
> > On Sat, Oct 03, 2026 at 06:02:27PM +0100, Chris Bainbridge wrote:
> > > Hello,
> > > 
> > > I am reporting a regression in KHO handover.
> > > 
> > > In the most recent Ubuntu 26.10 beta mini-ISO releases (2026-09-18 onwards),
> > > the first kernel reserves RAM for the downloaded ISO with a memmap directive
> > > such as memmap=<size>!4G, then kexecs a second kernel. On affected kernels, the
> > > first kernel reaches "kexec_core: Starting new kernel", but the second kernel
> > > produces no further output and QEMU spins at 100% CPU. On unaffected kernels,
> > > the second kernel starts and finds /dev/pmem0 with the expected "Persistent
> > > Memory (legacy)" range in /proc/iomem.
> > 
> > TO make sure I understand this correctly, you enable KHO in the builds of
> > the installer kernel and then the installer command line explicitly enables
> > KHO.
> 
> Yes.
> 
> > Is there anything you actually preserve with KHO when kexec'ing the second
> > kernel?
> 
> No. kho=off is a valid workaround for the mini ISO.

I'd even say that setting CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=n and even
CONFIG_KEXEC_HANDOVER=n is a reasonable choice for a distro kernel.

We don't have CONFIG_EXPERIMENTAL anymore, otherwise kho and luo would be
gated by it.

> I only reported it as a regression here because this was working until
> the bisected commit was merged. If this is intended behaviour then it is
> not a problem.

Thanks for the clarification. 

This is a bug, but since it happens for a combination of an opt-in option
(kho) and a hack (memmap=) I consider it low priority.

-- 
Sincerely yours,
Mike.

