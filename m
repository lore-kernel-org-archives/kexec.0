Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA76EC4451C
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 11:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OJ9YfaBFSXj+Hk6UH0eG4jUTBf/umVD52Blq68hhcTs=; b=M7HG0LoP8Gfz+6xjZk6Ku4nN6A
	URktfQjVBQYppi28JNkf7mnJ2TxQrgioXCpXKEMrpGsHWx6JTvrArIB8uBEajlzk7gPSHVP1kxVPr
	C+gKgEcer7aRp+BeuJT95dPV6xnTxyLaJ79I1E2hPYKrPOcttSIk/lj+UhZh/8f8Ck7F5HbBj4J4h
	7tccVS3QoT+WXiVy0tKKJU+8RKtlSc7auO4TvGjvMsU/GguJWSlyvamb+4IAPsyGxU8nvJ4xVZlJ5
	4aWwE+Zu2c44G/Xo0+4GAuLtPiKYnbkq8Ypj2Jx93WStZgyDiikRgozYxRGNzNowZupmJQbZ8gVsZ
	ROeDsWPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm8Pq-00000009HzC-2Rbe;
	Tue, 21 Jul 2026 11:13:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm8Po-00000009Hyi-3LeJ;
	Tue, 21 Jul 2026 11:13:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EA5D96001A;
	Tue, 21 Jul 2026 11:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954BC1F000E9;
	Tue, 21 Jul 2026 11:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784632415;
	bh=OJ9YfaBFSXj+Hk6UH0eG4jUTBf/umVD52Blq68hhcTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HhpYzzM/oimKKYM+22iuflbObTtTZTtdDQiTiyxYtxAy56bVm2RUMe/378V24lMCy
	 N9e8S8m+u3CgY8ts4zAtzzn/7vOUZMXBdf24qhCZv9/TwkwwqyROndhV2evLOQdqu8
	 HBoTX5g3VolANyAmdxRBf+OKSdf8wzTD4gVePThB5rnLNMi21tyuQah/hjS+xzmi6O
	 +V6KY+DG0MFNy6G9jhnjGbGb6gjRw/JJMT1JAVLM8HYueumFcgncpSyOhJzG/H7zL+
	 pCiAXWPO74jZeBAiR5ITzdAOIhaTIq1nFewaleXIqgld/by6+2YLS8eesfYNZWbUK3
	 W+mvBX/jSsBVg==
Date: Tue, 21 Jul 2026 12:13:30 +0100
From: Simon Horman <horms@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pnina Feder <pnina.feder@mobileye.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Alexandre Ghiti <alex@ghiti.fr>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/4] vmcore-tasks: export per-task metadata to vmcoreinfo
Message-ID: <20260721111330.GA1768252@horms.kernel.org>
References: <20260622211430.4008899-1-pnina.feder@mobileye.com>
 <akybBoCAm-kJbfHL@kernel.org>
 <20260720091927.GA1736709@horms.kernel.org>
 <al4X300UObXawEIJ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al4X300UObXawEIJ@kernel.org>
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

On Mon, Jul 20, 2026 at 03:43:11PM +0300, Mike Rapoport wrote:
> Hi Simon,
> 
> On Mon, Jul 20, 2026 at 10:19:27AM +0100, Simon Horman wrote:
> > On Tue, Jul 07, 2026 at 09:21:58AM +0300, Mike Rapoport wrote:
> > > On Tue, Jun 23, 2026 at 12:14:26AM +0300, Pnina Feder wrote:
> > > > This series extends vmcoreinfo with struct offsets and sizes needed by
> > > > the vmcore-tasks userspace tool to extract per-task state from a vmcore
> > > > dump without requiring kernel debug symbols (DWARF/BTF).
> > > > 
> > > > The vmcore-tasks tool reads /proc/vmcore (or a saved vmcore file) and
> > > > reconstructs, for each task:
> > > >   - task name, pid, state, flags
> > > >   - VMA list (start, end, flags, backing file)
> > > >   - user register state (saved on the kernel stack at kernel entry)
> > > >   - user-space backtrace with VMA/filename mapping
> > > >   - kernel dmesg buffer
> > > > 
> > > > This provides a lightweight post-mortem crash analysis capability for
> > > > production environments where full debug info (DWARF/BTF) is not
> > > > available.
> > > > 
> > > > The companion userspace tool is submitted to kexec-tools:
> > > >   https://lore.kernel.org/all/20260622205550.1087163-1-pnina.feder@mobileye.com/
> > > 
> > > Sorry for the delay, this fell between the cracks somehow.
> > > 
> > > The kernel side looks fine overall, but to merge it there should be an
> > > agreement from the userspace side maintainers that vmcore-tasks is
> > > something they are wishing to accept.
> > 
> > Hi Mike, all,
> > 
> > Sorry for the extended delay.
> > 
> > I will send some minor feedback to the user-space tool patchset
> > but overall, yes, this is something I would be happy to accept.
> > 
> > I don't want to create a chicken-and-egg type problem here.
> > But it's probably worth mentioning that usually features
> > hit the kernel before the corresponding code is accepted
> > into kexec-tools.
> 
> Sorry if I wasn't clear. 
> 
> I didn't mean that the feature should be merged into kexec-tools before
> merging the kernel bits. I just wanted to make sure there's no fundamental
> issue from kexec-tools perspective.

Thanks, it is clear :)

> > Let me know how you would like to proceed.
> 
> I'm going to wait for Baoquan's review and once that's done I'll pick up
> the kernel bits.

I see that conversation is now active.

Thanks to all.

