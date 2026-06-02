Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694EACD6E60
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QoEDHLDPjah5bpcTq5+xdPnUnkR+I3T5o+EEfuYH6c0=; b=jn55xtW2iU2Hxbc9L2SHJoBvkv
	qdqB17dAvx9+bQy3cYOWnsVx/CAk4MQzdGq3XtofIbhEJi/n9SSP0ZyYtpAd6CUaKpwj0hMi4qCHN
	RLGV3DMN4/vINYiPCsFzUZg5dcoyraCyZuNZg5GwGmlQi0AigeZChweLTuMF32eDFv6g8E2nkIaK3
	UtoVua8Qz2dr2l2NSwyqhHoRnQtHJmWCWTvRU3fMfif5T6ouwKjpM8HjWibeGQuGxSoY+OBrKDXy5
	Vm3XOZVylWiHVMB0GmgVyFtMaDmqU8pGmTdhZAjNBTPh6l30HsL+hiwpa8gW/n4M5l+9mU/6ai3ab
	rKdPgu4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUObI-0000000D1ek-3Sai;
	Tue, 02 Jun 2026 12:52:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUObG-0000000D1eM-2YIl
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 12:52:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7BA1043E7A;
	Tue,  2 Jun 2026 12:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8561F00893;
	Tue,  2 Jun 2026 12:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780404725;
	bh=QoEDHLDPjah5bpcTq5+xdPnUnkR+I3T5o+EEfuYH6c0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IiXf1nVAnO6t8NjlmzVhB2FDUs+qCYUsODkAWZ8sJTmk6a3lKVlf7tG67+VzbgBNQ
	 J7k5dqFFIF6+G5gn8Eq+IwMN4aNjsd2ONhT4EHoruasOEleK7cSmsQB4YdlAAqGEz5
	 4FFIzpTYiIeOCxlkgCfydz5dzQERCV/6b4kvoHr8KvCEruq64LWvoxFZdT6q5i006q
	 iwkVYLG0Ss7xNCtzrvg/VjiGJkSmKi+s2M36PLANDh6Y4h0ZjEEtyAlvpn63SbHQ0l
	 Jjk5kCalZ1XzlknpjzXB5XVn3uybFmWbzn4yCt1wGKZNiOh2bkPsibCvLd99WXllys
	 7B1hR1+e6qUMQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] memblock: introduce MEMBLOCK_KHO_SCRATCH_EXT
In-Reply-To: <ahyDHVSH5eLsnp3C@kernel.org> (Mike Rapoport's message of "Sun,
	31 May 2026 21:51:09 +0300")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-10-pratyush@kernel.org>
	<agHGOxSnP_VraH1M@kernel.org> <2vxzecjhc2s8.fsf@kernel.org>
	<ag-a4ru9bMkDMthO@plex> <2vxzse7j7ai9.fsf@kernel.org>
	<ahyDHVSH5eLsnp3C@kernel.org>
Date: Tue, 02 Jun 2026 14:52:02 +0200
Message-ID: <2vxztsrlds0d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_055206_690972_4BF47532 
X-CRM114-Status: GOOD (  39.08  )
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

On Sun, May 31 2026, Mike Rapoport wrote:

> On Fri, May 22, 2026 at 05:02:38PM +0200, Pratyush Yadav wrote:
>> On Fri, May 22 2026, Pasha Tatashin wrote:
>> 
>> > On 05-11 18:46, Pratyush Yadav wrote:
>> >> On Mon, May 11 2026, Mike Rapoport wrote:
>> >> 
>> >> > On Wed, Apr 29, 2026 at 03:39:11PM +0200, Pratyush Yadav wrote:
>> >> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> >> >> 
>> >> >> In the upcoming commits, the KHO will learn how to discover free blocks
>> >> >> of memory by walking the KHO radix tree. It will then mark those regions
>> >> >> as scratch to allow memory allocation in case scratch runs low.
>> >> >> 
>> >> >> To differentiate the extended scratch areas from the main scratch areas,
>> >> >> introduce MEMBLOCK_KHO_SCRATCH_EXT. Use it when choosing memblock flags
>> >> >> for allocations during scratch-only. Teach should_skip_region() to check
>> >> >> for both flags before deciding if the region should be skipped.
>> >> >
>> >> > Why there's a need to differentiate SCRATCH and SCRATCH_EXT?
>> >> > SCRATCH (I still hate the name) means "memory memblock can safely use for
>> >
>> >  +1000
>> >
>> > I also strongly dislike this name and mentioned it in another thread
>> > earlier today.
>> >
>> > If we ever decide to s/scratch/something-else/ globally, that should be a
>> > separate cleanup effort. However, since we are introducing a brand new flag
>> > here, we can discuss a better name for the _ext portion to avoid overloading
>> > the "scratch" concept.
>> >
>> >> > the allocations". Initially this memory comes from the reservations in the
>> >> > first kernel, but if the second kernel can find more memory to extend it,
>> >> > why that additional memory should be treated differently? 
>> >> 
>> >> Two reasons:
>> >> 
>> >> 1. We mark SCRATCH as MIGRATE_CMA. We don't want to do that for
>> >>    SCRATCH_EXT since this memory can be used for non-movable
>> >>    allocations.
>> >> 
>> >> 2. Gigantic (1G) huge pages can not be allocated from scratch. They can
>> >>    be preserved memory and thus should not be allocated from SCRATCH.
>> >>    See patch 12 that does allocations for gigantic huge pages only from
>> >>    SCRATCH_EXT.
>> >> 
>> >> I will add this in the commit message for the next version.
>> >> 
>> >> Naming is hard, so if you have any better names I'm all ears :-)
>> >
>> > IMO, this scratch_ext is not "scratch" in the traditional KHO sense at all.
>> > The traditional KHO scratch is what is passed from kernel to kernel and is
>> > guaranteed to contain zero preserved memory. This new memory is not passed
>> > from kernel to kernel and can contain preserved memory at runtime. It's
>> > essentially just memory that we identify as currently unpreserved and release
>> > early to the system.
>> >
>> > If we want to keep the naming aligned with the existing codebase for now:
>> > MEMBLOCK_KHO_SCRATCH      -> original scratch
>> > MEMBLOCK_KHO_UNPRESERVED  -> for the new memory (instead of SCRATCH_EXT)
>> 
>> UNPRESERVED sounds good to me. I will use that for the next revision
>> unless Mike objects.
>  
> Can we make it shorter? ;-)
>
> UNPRESERVED makes sense, although I'd love to completely remove KHO_ notion
> and make the name reflect how it's used by memblock. I was toying with
> PREFERRED instead of SCRATCH, but it didn't feel right enough.
> With two of them that surely won't work :)

I don't think you really can remove KHO_ notion. These memory regions
only make sense on a KHO boot, and won't exist otherwise. And PREFERRED
sounds like a suggestion/priority hint, not a hard limit. "With KHO
boot, you can _only_ use PREFERRED memory", doesn't sound right...

I think MEMBLOCK_KHO_BOOTMEM for scratch and MEMBLOCK_KHO_NOPRESERVE
(which I think is a tiny bit better than UNPRESERVED) for scratch_ext
are my top picks. To make it shorter, perhaps MEMBLOCK_KHO_NOPRSRV, in
similar fashion to RSRV_KERN?

>
>> > Alternatively, if we do want to tackle the global rename of "scratch" later:
>> > MEMBLOCK_KHO_BOOTSTRAP    -> for the original scratch
>> > MEMBLOCK_KHO_UNPRESERVED  -> for this new dynamic memory
>> 
>> Or perhaps BOOTMEM? I suppose either of the two are somewhat better than
>> scratch.
>
> Well, if we have BOOTMEM_HVO, we can have BOOTMEM_KHO as well :)
>
>> Anyway, can we please do the SCRATCH rename as a separate series? I
>
> Sure. We can continue bikeshedding in parallel.
>
>> would like this series to not get muddled in the naming discussion. I
>> will use UNPRESERVED for the new concept in v2 though.
>
> That might warrant v3 even if everything else is perfect :)

I can live with that. As long as we can agree on the easy part (the
code), I don't mind doing another version for the hard part (the naming)
;-)

-- 
Regards,
Pratyush Yadav

