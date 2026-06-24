Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ED0CDB479
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oSmnVUDEowNS7nXYHo4vlbwaFGW/DKpjdODnzdWCEgM=; b=T/Ld7AulzNiiS1CeouQnX88lCn
	9M9vMtU+178RpEpeF73Mxfcc9jI/+4L8gnbQqfR/GE6rvtVT6EvDjBPiVbzdPRmv66irecpOmlIKm
	GHQkRa4O+n5g7Yp96Lv+vbBf2QX77/u8xoHyivR6CYUVQXaLDGuQxwRJUGDGvOJASMinKwgdRXj6V
	plvd54zezWVQR5LNFE87AF3m36cNBCGfJ152pvcq5VD7NKvD0wRAyQ2MboOjsOxG8KVOdZM9JyloW
	+ghUrhjBsD4xRG9N+SVdotfLFQcoAu3lYxROTpXv81UJQepctq5m3jDIXNeNPPI4A/mX2qOnQ5Sjr
	ShQ3Iv4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcNpp-00000007pxQ-05Ev;
	Wed, 24 Jun 2026 13:40:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcNpn-00000007pxI-2EQI
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 13:40:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D6A5D43C7E;
	Wed, 24 Jun 2026 13:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE201F000E9;
	Wed, 24 Jun 2026 13:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782308406;
	bh=oSmnVUDEowNS7nXYHo4vlbwaFGW/DKpjdODnzdWCEgM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FJLyC/lXcGVoAgDPm/MD2U/3XWT73nrQxL90QOkHUYXK5sQEQHTDjeJD+Nl87FhMr
	 f0KGAs6COTewuS2gTfRSFXBfuqpPtGxhBoWuAEkV23kxmgX2gCQI2yVJxj38/kg+8M
	 jKhkeb2z4nbAiMyCnuzzZZuUpLv17TpqMQn2yv+4HgB/Seqywxhdq3iuk4Uve8Kpf3
	 Msz7r39Av4nCwic8Fu95AC28lsndXWtzv1Y8Nt4RFzWD+0hPyRbgiMimoIQfURvbgI
	 lnc8FZzgrVtFxC4lW8Z0hUcRB1uDtgDO0f5RtkgRqL7VmAa/H5sX116+HRrpFu8OH7
	 XSRQFHl4sDmWw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: nao.horiguchi@gmail.com,  linmiaohe@huawei.com,  david@kernel.org,
  lance.yang@linux.dev,  akpm@linux-foundation.org,  baoquan.he@linux.dev,
  rppt@kernel.org,  pratyush@kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  rneu@meta.com,  riel@surriel.com,  caggio@meta.com,
  kas@kernel.org
Subject: Re: mm/hwpoison: persist poisoned PFN list across kexec via KHO [RFC]
In-Reply-To: <ajut_LDQGYCShApx@gmail.com> (Breno Leitao's message of "Wed, 24
	Jun 2026 03:39:38 -0700")
References: <ajut_LDQGYCShApx@gmail.com>
Date: Wed, 24 Jun 2026 15:40:03 +0200
Message-ID: <2vxzse6ckqfg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Jun 24 2026, Breno Leitao wrote:

> TL;DR: carry the hardware-poisoned page list across kexec using KHO, so the
> next kernel doesn't hand out known-bad RAM.
>
> The problem
> ===========
>
> When a page is hard-offlined due to an uncorrectable memory error (multi bit
> ECC), memory_failure() sets PG_hwpoison, unmaps it, removes it from the buddy
> allocator and accounts it in num_poisoned_pages / HardwareCorrupted. All of
> that lives in the running kernel's data structures, not in the hardware.
>
> A kexec replaces the kernel image but not the physical DRAM. The next kernel
> rebuilds mem_map[] from the firmware-provided memory map, sees the bad frame as
> ordinary system RAM, and the buddy allocator hands it back out on the next
> kernel. The known-bad cell is silently back in circulation, and the next
> access faults again - potentially in a context that is harder to recover than
> the original (e.g. a kernel allocation rather than a killable user page).
>
> This matters most where kexec is frequent and machines are long-lived: live
> kernel update on large fleets. Poison knowledge accumulates over uptime and is
> thrown away on every update.

I don't know much about hardware page poisoning. From what I understand
of your description, it seems like the hardware fires off an event that
the kernel receives, and then the kernel stores the state, and hardware
"forgets" it. So what happens when something accesses the poisoned
memory anyway? Do we get another hwpoison event?

Also, what happens on cold reboot? If the HW does not remember bad
pages, won't the kernel be in the same position? How does it know the
bad pages on a cold boot?

>
> This is the case at Meta and in many hyperscalers.
>
>
> Possible solutions
> ==================
>
> 1. Do nothing (status quo). The next kernel hands out known-bad
>    RAM, and hope for the best. 
>
> 2. e820 / EFI memory map (E820_TYPE_UNUSABLE). Tempting because the
>    frame would simply never become RAM (no allocator race at all).
>    But: it is x86-only (no arm64 equivalent in the same mechanism;
>    this series is tested on arm64);
>
> 3. Firmware / platform page retirement (PPR, BMC page-offline, CXL
>    device poison lists). This is the correct layer for *cross power
>    cycle* persistence and is complementary to this work. But it is
>    per-platform, out of OS control, not universally available, and
>    cannot carry OS-discovered or software-simulated poison
>    (MADV_HWPOISON, the injector). kexec can also happen long before
>    firmware retirement takes effect.

I don't know enough about these two to say whether they are a good idea
or not. I'll let more competent people comment on that.

>
> 4. reserve_mem= / memmap= on the command line. Automatically sent reserved_mem=
>    for the next kexec kernel cmdline.

Does this scale at all? How many poisoned pages do you expect to see on
a big machine with say a few terabytes of RAM? Won't the commandline end
up being way too big?

>
> 5. A bespoke kexec segment / setup_data blob. This reinvents what
>    KHO already provides - preserved memory plus an FDT handoff to
>    the next kernel - which is the upstream-blessed generic mechanism
>    for exactly this kind of state.

Yeah, at that point you'd be better off using KHO directly. You won't
have to muck about with architecture specific bits.

>
> This PoC
> ========
>
>   * Makes hardware-poisoned pages survive a kexec, using KHO (Kexec
>     HandOver) to carry the poison list between kernels.
>
>   * Producer: hooks num_poisoned_pages_inc()/_sub() - the single
>     chokepoint for every poison/unpoison event - and records each
>     poisoned PFN into a vmalloc array that KHO preserves across the
>     kexec, described by a small versioned "hwpoison" subtree.

More of an implementation detail, but with vmalloc array, what if you
have too many poisoned pages?

We have two alternative data structures in KHO: the radix tree [0] and
KHO block [1]. I think the radix tree will be inefficient unless you
have a _lot_ of poisoned pages, but KHO block is likely going to work a
lot better because you don't have to define the buffer size up front.

>
>   * Consumer: early in the next boot (fs_initcall_sync, before the
>     buddy allocator has handed anything out) it restores that array

Why do you say so? Buddy is up and running after memblock_free_all(),
which happens from mm_core_init(), and memblock goes away entirely in
page_alloc_init_late(), which runs right after early initcalls but
before any other levels. See kernel_init_freeable().

Concrete example: hugetlb is initialized at subsys_initcall(), and
allocates all its 2M hugepages from buddy.

So I think you probably need to do this somewhere in
page_alloc_init_late(), after all the deferred struct pages are
initialized.

>     and re-runs memory_failure() on each PFN, re-offlining the frame
>     and rebuilding the full hwpoison state (PG_hwpoison, counters,
>     HardwareCorrupted).
>
>   * The replay feeds back through the producer, so the list
>     re-publishes itself and survives an arbitrary chain of kexecs.
>
>
> Open questions
> ==============
>
>   * Is there any alternative I am not seeing?
>
>   * Is a dedicated "hwpoison" subtree the right granularity, or
>     should this live under a broader RAS/KHO umbrella?

What's "RAS"?

A dedicated subtree sounds the best to me, but I think an alternate
option is to stick it into kexec-metadata. But I don't know what we'd
gain from doing so.

I _don't_ think it belongs in the base KHO ABI.

>
>   * Trusting the inherited list: should the next kernel bound the count /
>     validate PFNs against its own memory map before replaying?

Normally with KHO you assume the memory map does not change and the
previous kernel is trustworthy. You can try to do basic validation of
the memory map to ensure correctness, but I think in the end you just
_have_ to trust the previous kernel.

>
> Limitations
> ===========
>
>   * Poison events before KHO init (fs_initcall) cannot be published;
>     academic in practice as MCEs do not fire that early.
>
>   * Per-page only. Cross-power-cycle retirement of a whole DIMM
>     is not covered.
>
> I've got a PoC working, and it is available in here, in case you are interested
> in the details I am playing with
>
>   https://github.com/leitao/linux/tree/b4/hwpoison

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kho_radix_tree.h
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kho_block.h

-- 
Regards,
Pratyush Yadav

