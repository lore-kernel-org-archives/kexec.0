Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11406CD5BB0
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A2IrT8PydzK9xxtu2jbeHfoX/1GcdXru7uVPffwnQVk=; b=dL0sLKFcylD125SydbUQVEbfTn
	z4K1m/sJab6TuuCBGH8M+luSjjDwCKSD4s1VJPxj/T1ZXoEeoMsqTTQK/rdfLLWzTQy/OfIxrfdKO
	7PW03y7NdlLCkjGBtUistSXpuvQXqU48kPp9OWyH1Jh1IZZCAnbBqRTpZHMcpuyxTLWEN2MnFlnnh
	jJrMSRJg0MYcHX1rxy6e9X/2Dn2IQYN25AL6M6O44KX6s+/OGZqwCVq5cqoCcgOQ8dF6+QHHl0paU
	wxP+2gdcyH5/w4WyI3dIxhbkPme0hC2d3CdUTA62F5OBR6M01dMCQtvVJAchfiUfQikRzeXo2KPXQ
	Hl4lDNrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQROf-0000000BCWl-1u28;
	Fri, 22 May 2026 15:02:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQROd-0000000BCW2-0EUT
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 15:02:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 57D08404C1;
	Fri, 22 May 2026 15:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1C61F000E9;
	Fri, 22 May 2026 15:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779462162;
	bh=A2IrT8PydzK9xxtu2jbeHfoX/1GcdXru7uVPffwnQVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=KrfS+tJBjhwvjCQc5lgSC6UFM6xUBTGfKJwHZGomUl3hmvnG1kj0ilOsmwLMOtvHs
	 WkhRDeIH8FQct/ouklVCLMRrJcS4BKjeoi4U6HGiK3BZ7DhLP+gUuvdgdIKhpD1yeQ
	 pKpFA76LjjW6sjKy3COwgf521ZIPorDv2JVVq+AP9nJYDkyGweg+5VRbvMyV65K+OV
	 aMVCLwYyHtObaRLTb86V3MFbGhyycqmQnZ3xtdjEd0oeePDe/GK6oTq4Io2R0xvTOH
	 DZcT6S+Tdy/0Ntak24i/r+mUMrhP0rIdIsr01sIslAsOIJMLNw/ikjSgkesOrd/DOv
	 rfHbxnVUM2xoA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Muchun Song <muchun.song@linux.dev>,
  Oscar Salvador <osalvador@suse.de>,  David Hildenbrand
 <david@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Jason Miu
 <jasonmiu@google.com>,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] memblock: introduce MEMBLOCK_KHO_SCRATCH_EXT
In-Reply-To: <ag-a4ru9bMkDMthO@plex> (Pasha Tatashin's message of "Fri, 22 May
	2026 00:48:35 +0000")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-10-pratyush@kernel.org>
	<agHGOxSnP_VraH1M@kernel.org> <2vxzecjhc2s8.fsf@kernel.org>
	<ag-a4ru9bMkDMthO@plex>
Date: Fri, 22 May 2026 17:02:38 +0200
Message-ID: <2vxzse7j7ai9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_080243_137761_610B84D1 
X-CRM114-Status: GOOD (  30.91  )
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

On Fri, May 22 2026, Pasha Tatashin wrote:

> On 05-11 18:46, Pratyush Yadav wrote:
>> On Mon, May 11 2026, Mike Rapoport wrote:
>> 
>> > On Wed, Apr 29, 2026 at 03:39:11PM +0200, Pratyush Yadav wrote:
>> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> >> 
>> >> In the upcoming commits, the KHO will learn how to discover free blocks
>> >> of memory by walking the KHO radix tree. It will then mark those regions
>> >> as scratch to allow memory allocation in case scratch runs low.
>> >> 
>> >> To differentiate the extended scratch areas from the main scratch areas,
>> >> introduce MEMBLOCK_KHO_SCRATCH_EXT. Use it when choosing memblock flags
>> >> for allocations during scratch-only. Teach should_skip_region() to check
>> >> for both flags before deciding if the region should be skipped.
>> >
>> > Why there's a need to differentiate SCRATCH and SCRATCH_EXT?
>> > SCRATCH (I still hate the name) means "memory memblock can safely use for
>
>  +1000
>
> I also strongly dislike this name and mentioned it in another thread
> earlier today.
>
> If we ever decide to s/scratch/something-else/ globally, that should be a
> separate cleanup effort. However, since we are introducing a brand new flag
> here, we can discuss a better name for the _ext portion to avoid overloading
> the "scratch" concept.
>
>> > the allocations". Initially this memory comes from the reservations in the
>> > first kernel, but if the second kernel can find more memory to extend it,
>> > why that additional memory should be treated differently? 
>> 
>> Two reasons:
>> 
>> 1. We mark SCRATCH as MIGRATE_CMA. We don't want to do that for
>>    SCRATCH_EXT since this memory can be used for non-movable
>>    allocations.
>> 
>> 2. Gigantic (1G) huge pages can not be allocated from scratch. They can
>>    be preserved memory and thus should not be allocated from SCRATCH.
>>    See patch 12 that does allocations for gigantic huge pages only from
>>    SCRATCH_EXT.
>> 
>> I will add this in the commit message for the next version.
>> 
>> Naming is hard, so if you have any better names I'm all ears :-)
>
> IMO, this scratch_ext is not "scratch" in the traditional KHO sense at all.
> The traditional KHO scratch is what is passed from kernel to kernel and is
> guaranteed to contain zero preserved memory. This new memory is not passed
> from kernel to kernel and can contain preserved memory at runtime. It's
> essentially just memory that we identify as currently unpreserved and release
> early to the system.
>
> If we want to keep the naming aligned with the existing codebase for now:
> MEMBLOCK_KHO_SCRATCH      -> original scratch
> MEMBLOCK_KHO_UNPRESERVED  -> for the new memory (instead of SCRATCH_EXT)

UNPRESERVED sounds good to me. I will use that for the next revision
unless Mike objects.

>
> Alternatively, if we do want to tackle the global rename of "scratch" later:
> MEMBLOCK_KHO_BOOTSTRAP    -> for the original scratch
> MEMBLOCK_KHO_UNPRESERVED  -> for this new dynamic memory

Or perhaps BOOTMEM? I suppose either of the two are somewhat better than
scratch.

Anyway, can we please do the SCRATCH rename as a separate series? I
would like this series to not get muddled in the naming discussion. I
will use UNPRESERVED for the new concept in v2 though.

>
> What do you think?
>
> Pasha

-- 
Regards,
Pratyush Yadav

