Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39A0CDE001
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XLPUSysPsLS/lTKrhCAv+kKmeICUhhnEXQzcaQ5iT/8=; b=L3K5weVCt04xRprQGSUJ4CchxF
	g7fqWsTHa9RS1eHV98+twf3llztvHMDEtUOdjepswJBt4ET/LHutusSGALWYk6BCaTYBpijaS9UKB
	ZNESFHoH1NFmlYKq/EPQJvlE3ZKBGUC2vuPudNi2XjKhHPx1O/3uhi7b/8ZP9jTQ3YNwAw9a18f+H
	t9O+B/itCJ8TB2q8r8EFdgDMsqhKATFkk+69VLkbGYbqghjEhT5cU9gbfI5zYcopbjfcv5EYM8AOG
	rWbHaasjKTV8h/OPUt4ju1M3n1mSj2cmjFWMSMNmgM0aFVDGXVnW5mZr4LHJbYj0MUO5D7nvJNRhR
	mZGFNXng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcPPz-00000007zHc-2qUR;
	Wed, 24 Jun 2026 15:21:35 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcPPx-00000007zH4-3Ufa
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 15:21:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XLPUSysPsLS/lTKrhCAv+kKmeICUhhnEXQzcaQ5iT/8=; b=HNCXnnkTcOqmURs4era2o+oyPQ
	R95RjQgQp5Gd46soX4YTZnI5PbWMolzSfvvdQxwIRQBO71SbJtSF20kWYfSBJA4aaq0r4zZ4U0R88
	RHrr1xF7FY5R57GV3Lt/E/wz6FA8wH5cTJltnIxJHFr6ppD3OGW+n9DAJZ0jMPWJ5qjyChrkjEzmO
	a/sZ6e59LSjS6zFIMHob8/4mFgm2n5jsaq6nYH5Upamqj1H8mA+MEkcKTBX2fBiqsUXLPwGzfzvBb
	4OqN27CfeKikgqU3rmspDNJI6ayK2dZRBc+O0jOGnCRrdZKt6h1sU+dxBukVj3FIuXj5TzhSB/UfT
	4oiuOXZA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wcPPl-002W2H-2I;
	Wed, 24 Jun 2026 15:21:21 +0000
Date: Wed, 24 Jun 2026 08:21:16 -0700
From: Breno Leitao <leitao@debian.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, nao.horiguchi@gmail.com, 
	linmiaohe@huawei.com, david@kernel.org, lance.yang@linux.dev, 
	akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pratyush@kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, rneu@meta.com, riel@surriel.com, 
	caggio@meta.com
Subject: Re: mm/hwpoison: persist poisoned PFN list across kexec via KHO [RFC]
Message-ID: <ajvzUg8KK9gtFTYe@gmail.com>
References: <ajut_LDQGYCShApx@gmail.com>
 <aju5_WjBtagTOSJw@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aju5_WjBtagTOSJw@thinkstation>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_082133_874006_1CF49298 
X-CRM114-Status: GOOD (  23.97  )
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

Hello Kiryl, 

First of all, thanks for the review and topics raised!

On Wed, Jun 24, 2026 at 01:04:19PM +0100, Kiryl Shutsemau wrote:
> On Wed, Jun 24, 2026 at 03:39:38AM -0700, Breno Leitao wrote:
> >   * Consumer: early in the next boot (fs_initcall_sync, before the
> >     buddy allocator has handed anything out) it restores that array
> >     and re-runs memory_failure() on each PFN, re-offlining the frame
> >     and rebuilding the full hwpoison state (PG_hwpoison, counters,
> >     HardwareCorrupted).
> 
> fs_initcall_sync is not before buddy hands anything out - buddy has been
> live since memblock_free_all() in start_kernel(), and every initcall before
> this one has allocated freely. So this is recovery, not prevention: you may
> be running memory_failure() against a frame already in use, possibly by a
> kernel allocation.

Agreed - that wording was wrong. It is recovery, not prevention, and running
memory_failure() against an already-allocated (possibly kernel) frame is the
not ideal, but, still better than what we have today.

> Two windows are missed entirely:
> 
>   - memblock allocations between setup_arch() and memblock_free_all()
>     (page tables, mem_map[], percpu) can land on the bad frame.
> 
>   - The kernel image itself: KASLR picks its location in the
>     decompressor/stub, long before any initcall. The next kernel can end
>     up running *on* the bad frame.
> 
> So I don't think this should be a memory_failure() replay. The frames need
> to leave the next kernel's view at the memory-map level, before memblock
> and KASLR.

Agreed, this is the ideal right approach.

> > Possible solutions
> > ==================
> ...
> > 
> > 2. e820 / EFI memory map (E820_TYPE_UNUSABLE). Tempting because the
> >    frame would simply never become RAM (no allocator race at all).
> >    But: it is x86-only (no arm64 equivalent in the same mechanism;
> >    this series is tested on arm64);
> 
> (+Ard. I might get some details around EFI wrong.)
> 
> This isn't accurate, and I think it's the right direction for EFI
> platforms. EFI_UNUSABLE_MEMORY is honored on both arches today, no new
> consumer code:
> 
>   - arm64: reserve_regions() marks non-usable memory nomap.

Is it true for non-UEFI arm64 hosts?

>   - x86: do_add_efi_memmap() maps it to E820_TYPE_UNUSABLE.
> 
> And it closes the KASLR window for free, because the image is only placed in
> EFI_CONVENTIONAL_MEMORY on both (x86 process_efi_entries(), arm64
> randomalloc.c). So the bad frame is invisible to both the allocator and
> KASLR, which is exactly what fs_initcall_sync can't give you.
> 
> There's also LINUX_EFI_MEMRESERVE (efi_mem_reserve_persistent()) -
> cross-arch, reserved pre-buddy in efi_init() - and looks otherwise fine, but
> it's parsed too late to keep KASLR off the frame.

Thanks, I am wondering if we piggy-back on this EFI_UNUSABLE_MEMORY (or
something similar), than we don't need to use KHO at all, basically just marked
the page as EFI_UNUSABLE_MEMORY at poison time, and rely on kexec to avoid
passing this page forward.

Thanks for the discussion,
--breno

