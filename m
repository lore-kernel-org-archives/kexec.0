Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761CBCD37BE
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 16:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zDWlAo+by9et/MLJA85Pch/TMQZwZ2+eHb3ad+Lqwro=; b=aMoQGL3nWWqhKYxrNgZHG8FW+b
	jB8PHG7DYDrtqXLxFISmyOjSWUnyOssuRVW0KHWu8kM4ZUMOxCJvYqvzL2u3avYX2GjMOJYrOihPj
	ZXu8xJWsxOskFN5kTJgJ8RryDWxuhS2RLsxRs6tQtd5Bldrv5XuzULO3SCBuz7P/QeNBBw7sNlH23
	Bc6jUHULU3tjUAqaIQ2L6gtmJreI7F9y8Aw/amytJm4RJbFUWggGn5ANQCqdOCP4J7WHnTnGgq1YM
	ptiFKoYPGRmJyry2m28unGnmVb8Rhkf1tBFfn0xcfh3zZjVLR2e/nkL4RUb52EsYo6FES0OU4HzPB
	s0OdwG1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTmA-0000000EGNL-33JH;
	Mon, 11 May 2026 16:46:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTm8-0000000EGMm-2f8T
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 16:46:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AECBA60121;
	Mon, 11 May 2026 16:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671B6C2BCB0;
	Mon, 11 May 2026 16:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517995;
	bh=bw1iSp23wIs22ISN/RndBuh+7+IBivBG0cops6DsbD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GYQyVF0dodcnUtJFTeC3X6pBLZ91yI70qFAz9UI53t7Q0FVCJa3pgjktMCFALEF69
	 oFf86juGHdTTIx18+2++QfRgKVI/HsuKVJjpLA2YQHi2BHwP7iP4b2rDKOoXFAGDsZ
	 V6fW/otEE1ZlCA+SN9dsIevnW2msNppbiRYuSsLRnCiHukzao+82/kUJujVQ36Z7uz
	 FzXWDDyoSP6rMmM1WtGNgeYVuGySa5JT9xFKBJWyZ9rpD4cT6rFQGGSo3YH3LM9xrV
	 lf1cXfbMfcPqfBsW2BVAMoFeWtAJv7Q1CNFvKB8pBreZ9Lhr3L9wZAHJOwtFwVM4xi
	 6vuaKLjRTYdIg==
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
In-Reply-To: <agHGOxSnP_VraH1M@kernel.org> (Mike Rapoport's message of "Mon,
	11 May 2026 15:06:19 +0300")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-10-pratyush@kernel.org>
	<agHGOxSnP_VraH1M@kernel.org>
Date: Mon, 11 May 2026 18:46:31 +0200
Message-ID: <2vxzecjhc2s8.fsf@kernel.org>
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

On Mon, May 11 2026, Mike Rapoport wrote:

> On Wed, Apr 29, 2026 at 03:39:11PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> In the upcoming commits, the KHO will learn how to discover free blocks
>> of memory by walking the KHO radix tree. It will then mark those regions
>> as scratch to allow memory allocation in case scratch runs low.
>> 
>> To differentiate the extended scratch areas from the main scratch areas,
>> introduce MEMBLOCK_KHO_SCRATCH_EXT. Use it when choosing memblock flags
>> for allocations during scratch-only. Teach should_skip_region() to check
>> for both flags before deciding if the region should be skipped.
>
> Why there's a need to differentiate SCRATCH and SCRATCH_EXT?
> SCRATCH (I still hate the name) means "memory memblock can safely use for
> the allocations". Initially this memory comes from the reservations in the
> first kernel, but if the second kernel can find more memory to extend it,
> why that additional memory should be treated differently? 

Two reasons:

1. We mark SCRATCH as MIGRATE_CMA. We don't want to do that for
   SCRATCH_EXT since this memory can be used for non-movable
   allocations.

2. Gigantic (1G) huge pages can not be allocated from scratch. They can
   be preserved memory and thus should not be allocated from SCRATCH.
   See patch 12 that does allocations for gigantic huge pages only from
   SCRATCH_EXT.

I will add this in the commit message for the next version.

Naming is hard, so if you have any better names I'm all ears :-)

>
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>> 
>> Notes:
>>     Checkpatch complains about no space after MEMBLOCK_KHO_SCRATCH_EXT in
>>     the declaration, but doing so makes it nicely align with all the other
>>     numbers. Mike, if you'd like I can add some whitespace.
>> 
>>  include/linux/memblock.h | 10 ++++++++++
>>  mm/memblock.c            | 41 ++++++++++++++++++++++++++++++++++------
>>  2 files changed, 45 insertions(+), 6 deletions(-)

-- 
Regards,
Pratyush Yadav

