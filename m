Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FECCDB47C
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 10:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=67dLv1ARffmQNc6drLJbLB9TAVgbqaZwOnvrBi9FNR4=; b=bk0A/YvQXCcf8FDW0I6CW8HLXR
	Ebh2IfIA+YfakusDi5NI0LdpVSzrw86skKOTEIO8Ywzd8Oz45BN9ZPZnFA3Q9WzuOYRPfp5K0l7vY
	GdS2Cr0GNltYPTFCaGwDe1IOZIMqT5VLGwV5ic0DOTmzN+W7a3MalYQd0XSwtSn70ambZpa8kZ6g2
	SW8oBGbmBvWiARYsxrieMyTiy6Z53MWPn8OQhaJvVBImI6Dy82lID76aLf7Vy8NMTIicOUXme4MAC
	gcTedD6dkF+ZntOKxu8UeYEIg86aBrxqYZ+9Pf1bNxNFXuS7D0MrhrQ+Fx14+6ImhagcNP/XC4+l+
	P4ZWsa0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcL1h-00000007cQa-02zV;
	Wed, 24 Jun 2026 10:40:13 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcL1e-00000007cNn-2NQO
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 10:40:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=67dLv1ARffmQNc6drLJbLB9TAVgbqaZwOnvrBi9FNR4=; b=XlcuTTL1Av9lAVIkaKrdeA2nhx
	B2YDzxqHpmfT6WVITgcX4+PMlKRf/KNGWaSmn4nMdsr4J10VYjuIJs5mStnsPgitvTu3h14MrzsCn
	OgVYVvwWm5jl8Wr+/MwYXAe4sYzJBB2W51V6ICKSx0D0h/6pDdQWvHuhrFp55xuGW/3HlDn0MuzFw
	nMUsU+YSccJkPsawAMe+2s7MYHhhaA7k0VSA5TXJ5wOIf/bF3EEkswH80N0IqfSToLqY5zvdx9q0H
	gyxlg+halBsfr1+oO9mjexIkJBd5BThK8CkunM5eR3BXMT3HKGASMhy9lstNpzYL50SHS70E8NDl8
	gBwCqSnw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wcL1E-002MpD-1q;
	Wed, 24 Jun 2026 10:39:44 +0000
Date: Wed, 24 Jun 2026 03:39:38 -0700
From: Breno Leitao <leitao@debian.org>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, david@kernel.org, 
	lance.yang@linux.dev, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
	pratyush@kernel.org
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, rneu@meta.com, 
	riel@surriel.com, caggio@meta.com, kas@kernel.org
Subject: mm/hwpoison: persist poisoned PFN list across kexec via KHO [RFC]
Message-ID: <ajut_LDQGYCShApx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_034010_720721_9AEBC430 
X-CRM114-Status: GOOD (  14.66  )
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

TL;DR: carry the hardware-poisoned page list across kexec using KHO, so the
next kernel doesn't hand out known-bad RAM.

The problem
===========

When a page is hard-offlined due to an uncorrectable memory error (multi bit
ECC), memory_failure() sets PG_hwpoison, unmaps it, removes it from the buddy
allocator and accounts it in num_poisoned_pages / HardwareCorrupted. All of
that lives in the running kernel's data structures, not in the hardware.

A kexec replaces the kernel image but not the physical DRAM. The next kernel
rebuilds mem_map[] from the firmware-provided memory map, sees the bad frame as
ordinary system RAM, and the buddy allocator hands it back out on the next
kernel. The known-bad cell is silently back in circulation, and the next
access faults again - potentially in a context that is harder to recover than
the original (e.g. a kernel allocation rather than a killable user page).

This matters most where kexec is frequent and machines are long-lived: live
kernel update on large fleets. Poison knowledge accumulates over uptime and is
thrown away on every update.

This is the case at Meta and in many hyperscalers.


Possible solutions
==================

1. Do nothing (status quo). The next kernel hands out known-bad
   RAM, and hope for the best. 

2. e820 / EFI memory map (E820_TYPE_UNUSABLE). Tempting because the
   frame would simply never become RAM (no allocator race at all).
   But: it is x86-only (no arm64 equivalent in the same mechanism;
   this series is tested on arm64);

3. Firmware / platform page retirement (PPR, BMC page-offline, CXL
   device poison lists). This is the correct layer for *cross power
   cycle* persistence and is complementary to this work. But it is
   per-platform, out of OS control, not universally available, and
   cannot carry OS-discovered or software-simulated poison
   (MADV_HWPOISON, the injector). kexec can also happen long before
   firmware retirement takes effect.

4. reserve_mem= / memmap= on the command line. Automatically sent reserved_mem=
   for the next kexec kernel cmdline.

5. A bespoke kexec segment / setup_data blob. This reinvents what
   KHO already provides - preserved memory plus an FDT handoff to
   the next kernel - which is the upstream-blessed generic mechanism
   for exactly this kind of state.

This PoC
========

  * Makes hardware-poisoned pages survive a kexec, using KHO (Kexec
    HandOver) to carry the poison list between kernels.

  * Producer: hooks num_poisoned_pages_inc()/_sub() - the single
    chokepoint for every poison/unpoison event - and records each
    poisoned PFN into a vmalloc array that KHO preserves across the
    kexec, described by a small versioned "hwpoison" subtree.

  * Consumer: early in the next boot (fs_initcall_sync, before the
    buddy allocator has handed anything out) it restores that array
    and re-runs memory_failure() on each PFN, re-offlining the frame
    and rebuilding the full hwpoison state (PG_hwpoison, counters,
    HardwareCorrupted).

  * The replay feeds back through the producer, so the list
    re-publishes itself and survives an arbitrary chain of kexecs.


Open questions
==============

  * Is there any alternative I am not seeing?

  * Is a dedicated "hwpoison" subtree the right granularity, or
    should this live under a broader RAS/KHO umbrella?

  * Trusting the inherited list: should the next kernel bound the count /
    validate PFNs against its own memory map before replaying?

Limitations
===========

  * Poison events before KHO init (fs_initcall) cannot be published;
    academic in practice as MCEs do not fire that early.

  * Per-page only. Cross-power-cycle retirement of a whole DIMM
    is not covered.

I've got a PoC working, and it is available in here, in case you are interested
in the details I am playing with

  https://github.com/leitao/linux/tree/b4/hwpoison

