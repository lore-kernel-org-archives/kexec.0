Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8E1C55162
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 11:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RI2GUexLmVv8gB7H4ZANPJBiidvoccuLoXhfaCBsWjs=; b=ssG84Pzs9O2w7LaTtECpy1elZl
	Uv+Sh/Ivp8QQAYaqprVpqLjOJKRzSbEcmhkFmRa4EG4i1jJfaJIMBEuSqqAajHP8HhBaw0jY1QRCH
	2yw7fuOPugpbj4LvtA5ilSSN93q/j3IeycewUckAw9/rR6bddiqlcbd7/uqq2+mSKZ9cAjVvOwMuN
	sej5jljLN92w+oAkDJN5w/w6NQBRlgal3AVbaGI3ga6d87NwOD2epn43TQDzWyDFPBes/uDDYq12V
	2mUkccoBElFEAci1OAc+J1qXDbzkHXFhpwK+Ay22W0xjK2awG2aQFfAKKx/gUKkM4dR5L92VBUcNy
	A9uuQSCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPKG-0000000AOVW-2UhN;
	Thu, 30 Jul 2026 11:53:24 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPKF-0000000AOVQ-1gDJ
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 11:53:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 187E640D9C;
	Thu, 30 Jul 2026 11:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A601F000E9;
	Thu, 30 Jul 2026 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785412403;
	bh=RI2GUexLmVv8gB7H4ZANPJBiidvoccuLoXhfaCBsWjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Tcq/3Rns1MAd8B1/L7Wt94PX9kJJUcT4EbttzTvK6Xl4qi9iy5hsl+eRMHNOV3hyi
	 /Mk3gix0qtRSRs/M1JUAkS7jHYamRkTtD5ZpR+TcB414J/21Bwz71T3It8uHKHCFkH
	 QW0ZDT3X+9Qk+L70kqoIbLrxuzWrcnNyHtLchES3uGmkDtv4eGB5kmHhcwTUkrohoq
	 Rj0z5pYeVOfsbvzeOsEFaFU/StIg8eEmEJgRLNxUObJaaDwsS88WYePIxYM8/2+weG
	 ylkVcgYkRtbkOoWdIy2v20zBKgRNt04rKm57oUuBTg0pIgXPagEFhf2TLzV6LeKE1R
	 dT2OrncI5cJSA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/22] mm/mm_init: don't rely on memblock to get KHO
 scratch migratetype
In-Reply-To: <amr8ADvAiJE3ZYKF@kernel.org> (Mike Rapoport's message of "Thu,
	30 Jul 2026 10:23:44 +0300")
References: <20260729145610.2827231-1-pratyush@kernel.org>
	<20260729145610.2827231-18-pratyush@kernel.org>
	<amr8ADvAiJE3ZYKF@kernel.org>
Date: Thu, 30 Jul 2026 13:53:19 +0200
Message-ID: <2vxzik5w7ky8.fsf@kernel.org>
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

On Thu, Jul 30 2026, Mike Rapoport wrote:

> On Wed, Jul 29, 2026 at 04:56:02PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> Currently struct page init via memmap_init() or deferred_init_memmap()
>> only queries the migrate type from KHO for each discrete memory range.
>> That works currently since KHO scratch memory has a different memory
>> type so it is always it its own region.
>> 
>> An upcoming patch will add support for discovering blocks of memory with
>> no preservations and it will mark it as MEMBLOCK_KHO_SCRATCH to allow
>> allocations from them. This can lead to the bootmem KHO scratch areas to
>> be merged into larger free ranges. This merging breaks the selection of
>> migrate type.
>> 
>> Get rid of memblock_is_kho_scratch_memory(). Instead, use
>> kho_scratch_overlap() to decide the migrate type of the PFN. Since
>> kho_scratch_migratetype() only uses KHO functions, move it to
>> kexec_handover.h.
>> 
>> Instead of calling kho_scratch_migratetype() once for each free range,
>> call it once for each pageblock. Update
>> pageblock_migratetype_init_range() and memmap_init_range() to do so.
>> 
>> Since the migrate type is now evaluated for each pageblock and not each
>> free range, drop the migratetype arguments to deferred_free_pages() and
>> memmap_init_zone_range() and use MIGRATE_MOVABLE directly.
>> 
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>>  include/linux/kexec_handover.h | 15 +++++++++++++++
>>  include/linux/memblock.h       | 19 -------------------
>>  mm/memblock.c                  | 10 ----------
>>  mm/mm_init.c                   | 27 +++++++++++++--------------
>>  4 files changed, 28 insertions(+), 43 deletions(-)
>> 
>> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
>> index 18ba417f1ada..c83ec4a15fe7 100644
>> --- a/include/linux/kexec_handover.h
>> +++ b/include/linux/kexec_handover.h
>> @@ -5,6 +5,7 @@
>>  #include <linux/err.h>
>>  #include <linux/errno.h>
>>  #include <linux/types.h>
>> +#include <linux/mmzone.h>
>
> Should have been mm.h, kbuild bot is unhappy otherwise :)
>
> https://lore.kernel.org/all/202607301001.ARjK0D4v-lkp@intel.com
>
> I can fix it while applying.

I pulled this in for definition of enum migratetype. But I forgot about
pageblock_order. I plan to do a v6 with the lockdep and documentation
fixes anyway, so will fix that in v6.

-- 
Regards,
Pratyush Yadav

