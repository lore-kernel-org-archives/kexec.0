Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7CAC44515
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 12:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/iig1PBFdcY5HjlDuDU/ADsRJNO/Hx2Bt7lB9eeE+YM=; b=CMVWHP6JQkQe08Z+PlYBQ2rDzY
	ZJFGXGqKKp5dSCIqvMzY/sCOpkn62FzOmR1+S4EbqPMWBgen+Kl26xkBfMZwohMbnMxhJGokFQgVc
	qXr2MvyaOKZT7quXO9H6wyDk2BIWb7eh1EbZGUFOK29iBEoed+/8t4cch1Rj/ZpquNLROi+gwRpZv
	Po5YAXyFj2QbJR4aC3m7JVgREb1sTZ8plz53EHnflByxCojuuqvKZ/wYT5d81safQwL3NOq0bdjdc
	aZ3xu8Zdk5TR6MsHWYpLZimEQLB22TJn6smCbLAHUlO8wWx4Gtzw7YRDGfneTY0FENTQLM7E0bn6f
	PJe+s4kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlnL7-00000006isx-0klt;
	Mon, 20 Jul 2026 12:43:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlnL5-00000006isj-1lcj;
	Mon, 20 Jul 2026 12:43:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2233F4304A;
	Mon, 20 Jul 2026 12:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02101F000E9;
	Mon, 20 Jul 2026 12:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784551399;
	bh=/iig1PBFdcY5HjlDuDU/ADsRJNO/Hx2Bt7lB9eeE+YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C2KGFoH7pJ83K2lvgvwaBViS832LyhVDhzK+gYrDm//Wacyhb8iZjL6FL/5KoOAMm
	 gykvbdJUUb8za46mKM+vvkIg75ktBdDRFMkeQ60bebVECAM8LDq551QWsi39nubm3M
	 f0bijeVlQZ1l1URXOCz12bRAfczsKWTk2v4FkqSsevjPw5CK0fF9tLUvxrlQtJLm9e
	 CQm61a93+a14hp896s1BJ5I03BijR+dPV0Y++8FEUmKQwsku4NPfG9tYKkPhoZCxzE
	 sxkqhBBJeq0tGuVKZ09aiBZId7G9P9Tll+X4kkYj9Q06IJ98xwWPngvKWL8xQV0gAD
	 ACWxcsOpSTR6w==
Date: Mon, 20 Jul 2026 15:43:11 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Simon Horman <horms@kernel.org>
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
Message-ID: <al4X300UObXawEIJ@kernel.org>
References: <20260622211430.4008899-1-pnina.feder@mobileye.com>
 <akybBoCAm-kJbfHL@kernel.org>
 <20260720091927.GA1736709@horms.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720091927.GA1736709@horms.kernel.org>
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

Hi Simon,

On Mon, Jul 20, 2026 at 10:19:27AM +0100, Simon Horman wrote:
> On Tue, Jul 07, 2026 at 09:21:58AM +0300, Mike Rapoport wrote:
> > On Tue, Jun 23, 2026 at 12:14:26AM +0300, Pnina Feder wrote:
> > > This series extends vmcoreinfo with struct offsets and sizes needed by
> > > the vmcore-tasks userspace tool to extract per-task state from a vmcore
> > > dump without requiring kernel debug symbols (DWARF/BTF).
> > > 
> > > The vmcore-tasks tool reads /proc/vmcore (or a saved vmcore file) and
> > > reconstructs, for each task:
> > >   - task name, pid, state, flags
> > >   - VMA list (start, end, flags, backing file)
> > >   - user register state (saved on the kernel stack at kernel entry)
> > >   - user-space backtrace with VMA/filename mapping
> > >   - kernel dmesg buffer
> > > 
> > > This provides a lightweight post-mortem crash analysis capability for
> > > production environments where full debug info (DWARF/BTF) is not
> > > available.
> > > 
> > > The companion userspace tool is submitted to kexec-tools:
> > >   https://lore.kernel.org/all/20260622205550.1087163-1-pnina.feder@mobileye.com/
> > 
> > Sorry for the delay, this fell between the cracks somehow.
> > 
> > The kernel side looks fine overall, but to merge it there should be an
> > agreement from the userspace side maintainers that vmcore-tasks is
> > something they are wishing to accept.
> 
> Hi Mike, all,
> 
> Sorry for the extended delay.
> 
> I will send some minor feedback to the user-space tool patchset
> but overall, yes, this is something I would be happy to accept.
> 
> I don't want to create a chicken-and-egg type problem here.
> But it's probably worth mentioning that usually features
> hit the kernel before the corresponding code is accepted
> into kexec-tools.

Sorry if I wasn't clear. 

I didn't mean that the feature should be merged into kexec-tools before
merging the kernel bits. I just wanted to make sure there's no fundamental
issue from kexec-tools perspective.

> Let me know how you would like to proceed.

I'm going to wait for Baoquan's review and once that's done I'll pick up
the kernel bits.

-- 
Sincerely yours,
Mike.

