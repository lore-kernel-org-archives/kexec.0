Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16284C44515
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 09:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2xlv9UPOXY4FPesU3+Oc7TRyQqsHVLIjZMiUOIzWc+4=; b=kyqAz2vjZ8jl4NVY4nllVldLzh
	wfdLPL9AX4MDu9qUV6ZoGJHOkQWUjwsEZWY4itrI1V5sAjqtrGmEynEwxV+Eqoj05Qq2GKd46j+9n
	3cVE7RRVhTY0oit8lmIntvNOjMuB/WZK0au/gDFLZXp+EBTNCPU579rTrNugksRPVscBrxThrwoqC
	nU2rZmub2wC7scad10dlkJ9NRWF8RwOPXn7GV0H0qb9ReKzzcY16BEUlcbCh8dE7BMZhkVSRkXXoi
	6NTV9ODwExdH2tUZVgdeo4Y1kTUQofWjyBbaY2RKqtP3qP+bz//X0l91rub+mmlCKH4pFfQIUvQ/4
	mDiFEwyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlk9u-00000006HiM-38vt;
	Mon, 20 Jul 2026 09:19:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlk9t-00000006Hi4-2h1B;
	Mon, 20 Jul 2026 09:19:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EBC22408C8;
	Mon, 20 Jul 2026 09:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB07B1F000E9;
	Mon, 20 Jul 2026 09:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784539172;
	bh=2xlv9UPOXY4FPesU3+Oc7TRyQqsHVLIjZMiUOIzWc+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T0kNNdIe5uGMUq6ImNPNOQIsbEwTt2oae4ZHmIIZsJNHA9zzjf/D3tiOvsQs4FS1U
	 dr8gbtzrmsZHH+Qw2n6AZKtwIVTfT/y18RazaKAWBXjta9rqW9kikc+fWUwVxgs9Rr
	 x9HKzDUvYQrT3l+ciGl0Um/+ohKJx/ZgMuVJUl2aIDo58vf2MTMbcG2fJDKVBF/rTv
	 HnlaPEGUBpZsV+sphEh0+ED35bXTfQctS3i9SuHoDoIkpdadyxwTcdjyiWRrnQDAlh
	 BcBfwOvkxU1R1IioHND8Kt8dmOOoExrJ0p/MTnuNfg5ZxCtYb4Qh/BmSBCECoxL6TT
	 MyHIRJohyG+hg==
Date: Mon, 20 Jul 2026 10:19:27 +0100
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
Message-ID: <20260720091927.GA1736709@horms.kernel.org>
References: <20260622211430.4008899-1-pnina.feder@mobileye.com>
 <akybBoCAm-kJbfHL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akybBoCAm-kJbfHL@kernel.org>
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

On Tue, Jul 07, 2026 at 09:21:58AM +0300, Mike Rapoport wrote:
> (adding new Baoquan's email)
> 
> Hi Pnina,
> On Tue, Jun 23, 2026 at 12:14:26AM +0300, Pnina Feder wrote:
> > This series extends vmcoreinfo with struct offsets and sizes needed by
> > the vmcore-tasks userspace tool to extract per-task state from a vmcore
> > dump without requiring kernel debug symbols (DWARF/BTF).
> > 
> > The vmcore-tasks tool reads /proc/vmcore (or a saved vmcore file) and
> > reconstructs, for each task:
> >   - task name, pid, state, flags
> >   - VMA list (start, end, flags, backing file)
> >   - user register state (saved on the kernel stack at kernel entry)
> >   - user-space backtrace with VMA/filename mapping
> >   - kernel dmesg buffer
> > 
> > This provides a lightweight post-mortem crash analysis capability for
> > production environments where full debug info (DWARF/BTF) is not
> > available.
> > 
> > The companion userspace tool is submitted to kexec-tools:
> >   https://lore.kernel.org/all/20260622205550.1087163-1-pnina.feder@mobileye.com/
> 
> Sorry for the delay, this fell between the cracks somehow.
> 
> The kernel side looks fine overall, but to merge it there should be an
> agreement from the userspace side maintainers that vmcore-tasks is
> something they are wishing to accept.

Hi Mike, all,

Sorry for the extended delay.

I will send some minor feedback to the user-space tool patchset
but overall, yes, this is something I would be happy to accept.

I don't want to create a chicken-and-egg type problem here.
But it's probably worth mentioning that usually features
hit the kernel before the corresponding code is accepted
into kexec-tools.

Let me know how you would like to proceed.

