Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F55C4452A
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 14:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z4gSt9cswUv2DtOGtLXPRqtGUR2VcGmgfvQCElRP9mg=; b=KFobC8a6CQN1GtU7yUlPMSgP/K
	EMtve44RgotzsoEeEbRDOYd3N7yqXdJ0vWaypmOdYJQvWp6wwuX0/n4O7XMkBHoN2vkMJdw8Nct/N
	zJfhqkOcUQnpXdKEvTxwF2OUdp/PSfaTNmVWp9upLEYlrgackt+UmkPxg984rnpT2We3rzQ39jjMr
	AMtxIsmzJhViBzapy6e5r4FzFetR8I89HPTNWtjqUTLqjBSa+WQ/I7zIq0EL959NHDbCSWwE6LGZh
	kiSkIN/OfLh1elgX4Jvo81KWWR5sICMB95Z/vQkEQHoieFN1ZZeupubOWTPU8RtdajC9cppGf5UgP
	ChJctYMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpB9-000000070jR-0q0X;
	Mon, 20 Jul 2026 14:41:11 +0000
Received: from out-170.mta0.migadu.com ([91.218.175.170])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpB5-000000070gu-1z8q
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 14:41:09 +0000
Date: Mon, 20 Jul 2026 22:40:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784558454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4gSt9cswUv2DtOGtLXPRqtGUR2VcGmgfvQCElRP9mg=;
	b=Pqo2xgJ5RDdj6NXs/jgeISfkdIg7i7qMUGkyZrTO/p1VM+BbXJW/RIUSk3umeDw8GfcuOR
	BQyPX9vHf6jSgJDsYezil7V5AOtFS0ol0tf8WF9flnT6iDNrezuc4gIkTJvqvd/XeVKzlm
	rjkJqxcCecDN47qIrUxa/KE9LXp2OPA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Mike Rapoport <rppt@kernel.org>, Pnina Feder <pnina.feder@mobileye.com>
Cc: Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <al4yeHrkDHFoo6A0@MiWiFi-R3L-srv>
References: <20260622211430.4008899-1-pnina.feder@mobileye.com>
 <akybBoCAm-kJbfHL@kernel.org>
 <20260720091927.GA1736709@horms.kernel.org>
 <al4X300UObXawEIJ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <al4X300UObXawEIJ@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_074108_259750_CAAB1E23 
X-CRM114-Status: GOOD (  34.38  )
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

On 07/20/26 at 03:43pm, Mike Rapoport wrote:
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
> 
> > Let me know how you would like to proceed.
> 
> I'm going to wait for Baoquan's review and once that's done I'll pick up
> the kernel bits.

Oh, sorry, I just noticed this series, but a quick look give me a hint
of 'No, I don't like it.' We have had Crash utility, Drgn, now a new one
comes up. I have some concerns to Pnina:

1. Exporting maple tree internals (maple_node, maple_range_64,
   maple_arange_64, maple_metadata) as vmcoreinfo ABI is problematic.
   These are private implementation details, not stable structures like
   task_struct. Any refactoring of the maple tree will silently break
   the userspace tool. 

2. Without DWARF/BTF, the debugging scope is inherently limited — no
   kernel stack backtrace, no symbol resolution, no variable access.
   That's essentially "ps + /proc/PID/maps" from a vmcore. Have you
   considered enabling CONFIG_DEBUG_INFO_BTF on your platforms instead?
   BTF is compact (typically < 1 MB) and would give drgn full access
   without needing vmlinux debug packages. That seems like a better
   return-on-investment than maintaining ~40 new vmcoreinfo exports.

3. Beyond the technical concerns, I wonder about adoption. vmcore-tasks
   targets a fairly narrow use case — platforms without DWARF/BTF, where
   you still have vmcore but can't ship vmlinux. Is Mobileye currently
   the only consumer? Are you guys already using it widely and fully?
   If this lands but doesn't see broader uptake, the ~40 exports risk
   becoming dead weight in vmcoreinfo — nobody actively uses them, but
   kernel changes still need to keep them consistent, or they silently
   rot and give users wrong results. 

Regards,
Baoquan






