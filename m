Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5D7C531D0
	for <kexec@archiver.kernel.org>; Mon, 27 Jul 2026 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mB3rVl4J/0dZRKiZaqA8l1qOdT57Rk7hhvrQccsk7m4=; b=uGP6l7uOy0Rc03smNz1RdejZgT
	xFbVrlOO/UGTVHaqJAGZshrJzz94t3sA6yuCAnLQEsMIye4IZTgKt/fcr2zBU3h/DxTK3CpEhcPzV
	PBsdAiUgdp6rThGIXnMZ9njXHeX2VHkOy4dd7WQm9lJR4sje63VdHJa1RYNGjQgertuQMpGhbUQqL
	In1GYsaTLH2y7FK7CIBLNTGL+qPcPLXmcyGtRej/kpYzbeYJ14loipxbRfvjCtgfsSaD0sEFOX9kW
	todOpGZEqRB2fL/uE64onsG+QkglFDShrBofu5OoJyILtT3czr33dGw/ocPMvQWH57N4uA0okLspl
	gLFESFMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woLIA-00000002qFe-39mx;
	Mon, 27 Jul 2026 13:22:50 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woLI8-00000002qEc-3B6r
	for kexec@lists.infradead.org;
	Mon, 27 Jul 2026 13:22:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mB3rVl4J/0dZRKiZaqA8l1qOdT57Rk7hhvrQccsk7m4=; b=oHxrOk0dF/P4m32D0E6tqtoBi4
	IRjcQOCZ/9k1CGQtRAQsNUYaicVPx8mhPiS7+ODexGP5CZfYto4bM7GCcr0LHGHc6o/Pz7Sj15aDw
	hlDvzUv+jTmXKYUmSu7M7LUGovRMwDSbcFwG/s4WtLcBBFzbJ/sJjdOSNegXZvouf/GWRYQZaCSSW
	mwpE3Stkyotby4ASAsARSjzl3m2ovpL0w2/Y4KVg7KVTpUyn1EwH0fMWmSqgpiY0KqpfLajHWfrmv
	oXtbj4EDVmUmWCEdZr+63Q+Khpuarq6kDfZdqotB1WuIZI4si7StacMH6JweoAhZt4ahwuBwEuNVm
	74DW9rCw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woLHn-006vOX-1M;
	Mon, 27 Jul 2026 13:22:27 +0000
Date: Mon, 27 Jul 2026 06:22:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	rneu@meta.com, riel@surriel.com, caggio@meta.com, anilagrawal@meta.com, 
	rmikey@meta.com, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 0/3] efi: mm/memory-failure: keep hardware-poisoned
 pages out of the next kexec
Message-ID: <amdVuOO_6aCxMkA2@gmail.com>
References: <20260717-hwpoison-kho-v1-0-9c5eda551998@debian.org>
 <amDHmNWfQ8eid9jH@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amDHmNWfQ8eid9jH@thinkstation>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_062248_799059_CEE7F053 
X-CRM114-Status: GOOD (  38.77  )
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

On Wed, Jul 22, 2026 at 02:50:18PM +0100, Kiryl Shutsemau wrote:
> On Fri, Jul 17, 2026 at 07:03:02AM -0700, Breno Leitao wrote:
> > Problem:
> > ========
> > 
> > When a page is hard-offlined due to an uncorrectable memory error (multi
> > bit ECC), memory_failure() sets PG_hwpoison, unmaps it, removes it from
> > the buddy allocator. This information is not carried to the next kernel
> > that is kexeced. The new kernel kexecs and trip over that bad memory
> > bank _again_.
> > 
> > Why now:
> > ========
> > 
> > Several industry trends make this increasingly important:
> > 
> >     1) DRAM is getting more expensive
> >     2) soldered / on-package memory (LPDDR, HBM) is becoming more common, so a
> >        failing part can no longer simply be swapped;
> >     3) memory is kept in service far longer (at Meta, DRAM lifetime is being
> >        drastically extended).
> >     4) It is more and more common to kexec instead of full reboot
> >     5) Increase of memory per system with CXL
> > 
> > Proposed Solution:
> > ==================
> > 
> > Carry the poisoned frames to the next kernel in a new EFI configuration
> > table, LINUX_EFI_POISONED_MEMORY, modeled on the existing
> > LINUX_EFI_MEMRESERVE table.
> > 
> > EFI configuration tables already survive kexec: firmware hands the EFI
> > system table to every kernel in the chain, so a table installed once is
> > seen by all successors without a new handover channel.
> > 
> > The mechanism is architecture independent, so x86 and arm64 use the same
> > code.
> > 
> > The EFI stub installs an empty table while EFI boot service is up. A
> > configuration table can only be created there; the running kernel can only
> > append to it.
> > 
> > Each hard-offlined frame is appended; an unpoison "removes" its entry
> > so a frame that is good again is not carried forward.
> > 
> > The next kernel walks the inherited table early in
> > efi_config_parse_tables(), before memblock and the buddy allocator are
> > up, and memblock_reserve()s every recorded frame. The bad RAM is never
> > handed out.
> 
> The allocator is only half of the problem. kexec segment placement
> doesn't know about any of this: kexec_file picks destinations from
> System RAM resources (memblock on arm64), and poisoned frames are only
> ever removed from buddy. So the next kernel image, initrd or purgatory
> can be placed on top of a poisoned frame -- the relocation memcpy then
> consumes the poison and the machine checks during the very kexec this
> series is supposed to protect. Same for the table's own list pages:
> overwrite one at placement time and the next kernel parses garbage.


Agreed, and thanks. This is real and, I think, largely separable from
the cross-kexec table -- the running kernel already knows its own
poisoned frames via PG_hwpoison, so excluding them at load time protects
the immediate kexec without depending on anything carried across the
boot. I'd like to tackle it as an independent change, let me do a PoC
and see how much change it is. I suspect it is less than this one (and
probably nice to have even if this series doesn't end up anywhere)

> Hooking num_poisoned_pages_inc() also means soft-offlined pages are
> recorded. Those are functional pages, offlined predictively. Turning
> them into permanent losses for every kernel down the kexec chain does
> not seem right. I would record hard failures only.

Yea, it seems that action_result() is what we want instead of
num_poisoned_pages_inc()

> On the data structure: I am not an expert on DRAM failure modes, so I
> went reading. The field studies [1] say roughly a quarter of DRAM
> faults are multi-bit structures (row/column/bank), and the address
> interleaving means one such fault shows up to the OS as many separate
> 4K pages. A row fault lands in a window of tens of KB to about a MB; a
> column fault is one bad line per row, strided across the bank's entire
> footprint -- potentially thousands of pages scattered over gigabytes,
> reported one MCE at a time as they get touched. DDR5 on-die ECC hides
> most single-bit faults from the host, so the visible mix shifts toward
> these multi-bit modes over time.
> 
> If that is accurate, per-4K entries have no natural bound, and every
> entry becomes a separate scattered memblock_reserve() in every future
> boot.
> 
> I would consider a bitmap with one bit per 2M instead, modeled on
> struct efi_unaccepted_memory: the stub sizes it from the EFI memory map
> at cold boot, the running kernel sets a bit on hard offline, clears it
> on unpoison, and the next kernel reserves set units. It is one
> fixed-size allocation, so the whole grow-and-link machinery and the
> chain-parsing trust problem go away, and a row fault collapses into one
> or two bits.

Thanks for digging into the failure modes -- that matches my
understanding, and the bounded, chain-free bitmap is appealing for
exactly the reasons you give: a row fault collapsing to a bit or two,
one fixed allocation, and no cross-kernel chain to trust.

Let me hack a PoC with a bitmap and check how it looks like, let's see
if that looks like smoother.

--breno

