Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D14AD2ED0F
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HqjEZVVpEWVpvNsRDimy5H0O4JUtkAM1U7A7eHcD2eI=; b=hnCZNm3+MA/f1kO1iQ6wfbdb+l
	qNJNL5bfZjn3MPlRN3Q/5/HgkbgdIKoLICXnrHTBDUNP857yuNLxIhfdO/esisDqoR42guFoggE8w
	ahmIrHthF2BkEzj4vBzR/1E8GxQNhCHeK3wLu/QGS32r3S4+6ygZ10Bi5L4AWaYDt9bG3pCHyHlIj
	eKKNGo0hd7dPjZMhJJErA6TtQ54Lhy8mhP08q0eik2gma6ghp34TIqwaY0MjSny3TVw43Fw6R7BPf
	0l0JrENO61IyVlY2jZL3fWyLGQPsC+6zHNirwx6i6i8he4RczsFgYQwIy5imNrCWTZ8CoXk/QI1KE
	zwAuG6JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viDMx-000000043Nf-2lM2;
	Tue, 20 Jan 2026 15:10:11 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viDMw-000000043NT-2H7U
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 15:10:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9AD4160018;
	Tue, 20 Jan 2026 15:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66953C16AAE;
	Tue, 20 Jan 2026 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768921809;
	bh=oZZE0N+eBzoJVtvYCEh6PCsNcP68xQvWg7NAAt/aY4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NfGHLI45keW1oS6vBkgEIO9GCPODJHiejXbFWjBkYXTa7lCQEhDMG+rFsNRnDa1c5
	 WlQuGK9Juf4eWvh7ID25y0EiEKtjfISl/eF3p3aWTDO1OkyptIRm6CAV3QFQCzqhvs
	 6Qj9ZTw4gVI7jh7FaInMwjIaqYxzUJAH0nSd9JZ06g0UveLNxRInRXwhmGvJix+djJ
	 ocjjG/YHQxDUC55tVn4EAM+YV4dp+unGxRBiKqYSxA9x2UuWXP+n2PMMA1W9uJXeB9
	 pvSSISbUERSf8ie+ZxEaSwlgAVQp4hvZzmsEr8kvRcyYW1keLvA3lhtU2isgrICOPP
	 mrhGRknlXuaWQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  akpm@linux-foundation.org,  rppt@kernel.org,
  graf@amazon.com,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  ricardo.neri-calderon@linux.intel.com,  kernel-team@meta.com
Subject: Re: [PATCH v4] kho: validate preserved memory map during population
In-Reply-To: <z2lraqiivexvfvokff4gmqyvbpswmfwhbkhv4u7lo3nnnyz346@mibnt7dkrvey>
	(Breno Leitao's message of "Mon, 19 Jan 2026 10:54:09 -0800")
References: <20251223140140.2090337-1-pasha.tatashin@soleen.com>
	<jixxiqeajngwox3nh2u3pwf2rivhmqxxmpyttqxu32pixshyde@4jdn5jvg5hvk>
	<2vxzo6mt7cl3.fsf@kernel.org>
	<z2lraqiivexvfvokff4gmqyvbpswmfwhbkhv4u7lo3nnnyz346@mibnt7dkrvey>
Date: Tue, 20 Jan 2026 15:10:05 +0000
Message-ID: <2vxzzf68e2wi.fsf@kernel.org>
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

On Mon, Jan 19 2026, Breno Leitao wrote:

> On Fri, Jan 16, 2026 at 04:21:28PM +0000, Pratyush Yadav wrote:
>> > On Tue, Dec 23, 2025 at 09:01:40AM -0500, Pasha Tatashin wrote:
>> >> If the previous kernel enabled KHO but did not call kho_finalize()
>> >> (e.g., CONFIG_LIVEUPDATE=n or userspace skipped the finalization step),
>> >> the 'preserved-memory-map' property in the FDT remains empty/zero.
>> >> 
>> >> Previously, kho_populate() would succeed regardless of the memory map's
>> >> state, reserving the incoming scratch regions in memblock. However,
>> >> kho_memory_init() would later fail to deserialize the empty map. By that
>> >> time, the scratch regions were already registered, leading to partial
>> >> initialization and subsequent list corruption (freeing scratch area
>> >> twice) during kho_init().
>> >
>> > While trying my new patchset [0] on top of this patch, I got the
>> > following issue:
>> >
>> > 	[    0.000000] KHO: disabling KHO revival: -2
>> >
>> > Trying to solve it, I come up with a change in kho_get_mem_map_phys() to
>> > distinguish no memory and error, see the patch attached later.
>> >
>> > This is what I used to test [0] on top of linux-next. Is this useful?
>> >
>> > Link: https://lore.kernel.org/all/20260108-kho-v3-1-b1d6b7a89342@debian.org/ [0]
>> >
>> > thanks
>> > --breno
>> >
>> > commit 5d7855fede8110d74942e1b67056ba589a1cb54a
>> > Author: Breno Leitao <leitao@debian.org>
>> > Date:   Thu Jan 8 07:44:08 2026 -0800
>> >
>> >     kho: allow KHO to work when no memory is preserved
>> >     
>> >     Fix KHO initialization failing when no memory pages were preserved by
>> >     the previous kernel.
>> >     
>> >     Commit eda79a683a0a ("kho: validate preserved memory map during
>> >     population") introduced kho_get_mem_map_phys() which returns the physical
>> >     address of the preserved memory map directly as its return value. The
>> >     caller then validates it with:
>> >     
>> >         mem_map_phys = kho_get_mem_map_phys(fdt);
>> >         if (!mem_map_phys) {
>> >             err = -ENOENT;
>> >             goto out;
>> >         }
>> >     
>> >     This creates an ambiguity: physical address 0 is used both as an error
>> >     indicator (property missing/malformed) and as a valid value (property
>> >     exists with value 0, meaning no memory was preserved).
>> >     
>> >     "No memory preserved" is a legitimate state. KHO provides features beyond
>> >     memory page preservation, such as previous kernel version tracking and
>> >     kexec count tracking. When the previous kernel enables KHO but doesn't
>> >     preserve any memory pages, it sets 'preserved-memory-map' to 0. This is
>> >     semantically different from "KHO not initialized" - it means "KHO is
>> >     active, there's just nothing in the memory map."
>> 
>> This isn't true. If you hand over _any_ state, you will at least need
>> the KHO FDT. And the KHO FDT is preserved memory (see the
>> kho_alloc_preserve() call in kho_init()). So I don't see how you can
>> ever have valid KHO with no memory.
>> 
>> mem_map_phys _can_ be 0, but only when KHO was enabled but not used. And
>> that is of course also a valid use case.
>
> Oh, I was not finalizing KHO, and in commit e1c3bfd091f363c1
> ("kho: validate preserved memory map during population") started to fail this
> on purpose.
>
> So, I understand we want to fail if mem_map_phys = 0, but thn FDT was properly
> passed (how is it possible)? I know I can read
> KHO_PROP_PREVIOUS_RELEASE/KHO_PROP_PREVIOUS_RELEASE from the fdt, even when
> mem_map_phys is 0.

See commit d7255959b69a ("kho: allow kexec load before KHO
finalization") for more of an explanation of why this is done.

The FDT is always handed over because when the KHO image is set up, we
don't know if KHO will actually be used. On the next boot, it is
discarded if KHO was not finalized (that is, mem_map_phys == 0) since it
won't contain any memory to hand over.

Since you had the previous release in the FDT itself, you were able to
read it. If you move to subtrees as I suggested, then it would stop
working.

The KHO FDT is special in a way. We access it _before_ going into
scratch-only mode, and until then we just have to hope nobody
over-writes that (which is unlikely in early boot anyway). So it is safe
to use the contents of the FDT itself to signal if we have any useful
KHO state to hand over.

-- 
Regards,
Pratyush Yadav

