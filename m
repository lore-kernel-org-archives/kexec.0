Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734F606A31E
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MIURAcJt;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=JGgWB21h;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=g4ilV5O3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kKJKbMnJNOGoE6D91lLl+V2hqik3/+jrS4TaB+PdqrY=; b=MIURAcJt0eqMQD
	ZH8Y5T0LmD/JJGcSexSvUxzLwrrdOfZh2gaLyeUNCn0GYdgPuW9CD/9HK1GcENMVpivH8kozc1XBp
	84kRTf7zSfn0no5KhXKvgLqMSQBN0ZV6+Y2UG7t6qM26d/Q0hwHvah3h8Y6e8dh+v/L6tUw73yA9B
	5/rSXXqR3e8GCB6n9nZVJQ3Fby9Klj+CRtLkQsC1KIT58LcRHPf3vhExVRKuv2oCQWMlus2dhACST
	QIGSRo4e9IwtdcwfXuwtiVEmIF0Dz4iy0QuKklzdb5clYA7EROPHGwFgCGuGo/vM3UfZw4YpbMsCX
	NRBDNRVfdTVeNMn9DBfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWKs5-0000000BPzd-3ckv;
	Wed, 25 Nov 2026 21:49:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWKs2-0000000BPyh-2mZ9
	for kexec@bombadil.infradead.org;
	Wed, 25 Nov 2026 21:49:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=kKJKbMnJNOGoE6D91lLl+V2hqik3/+jrS4TaB+PdqrY=; b=JGgWB21hZwLHe/FOXzigEBvPRi
	MsMu6hOpBlXB97JdZavr1817nfyNBimuN2z/oB/N5VPqniOoKr5mLG2fj67ZFHvcXrpx/5qDGGtum
	LA5KUCv4dOjo5l7GkSUuhHIJ3/TInFV/M0ugvPW09Qen9e4Y5GeN+YnVv/GHuXYv2tSnxTuMlfQKM
	4CKXWNC6KDSq+Jft+stP9cFekZVVWABnOkpalDYTiish9rBbwcdrpC4BKXuTxhNyzucP2bCnUmbQN
	gbgBQuNV5py/JEynz/THdkz/EthxXXhBdX8HArZ5vF6v0rhbiLTbrpghb00LBSLR5URPPXTcpG8Vo
	z5KlC61Q==;
Received: from out-178.mta0.migadu.com ([2001:41d0:1004:224b::b2] helo=mta0.migadu.com)
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWKry-00000005ngj-2aFH
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 21:49:41 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=23ukelReVlQPxc727XgPBvL052sL8fB47EA5Oas4FGk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795643375; v=1; x=1796248175;
 b=g4ilV5O3yYC6yhOJGtP90BvpNeDZQqHMwkolMBewnNYzg30dUDCcynwOM/kniC0MeppIG7iM
 S9hfp0ktxWi61dLPhnb4UFjObzp89imJxrRUEwaKJBUxP2SqkmSyXCOgQDmcQV3MEWrCKQ7HY5i
 395jK0IkAEgoiiNv3X7Z5bXE=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 61dfde814fe69c93;
	Wed, 25 Nov 2026 21:49:34 +0000
X-Mizu-Trace-ID: 61dfde814fe69c93
X-Migadu-Flow: FLOW_OUT
Message-ID: <1b0242ef-49ad-4d7d-820e-d1e6569eacf8@linux.dev>
Date: Wed, 25 Nov 2026 21:49:34 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: reject long-term pins of HugeTLB folios
 overlapping crashkernel CMA
To: Sang-Heon Jeon <ekffu200098@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Frank van der Linden <fvdl@google.com>,
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Jiri Bohac <jbohac@suse.cz>,
 kexec@lists.infradead.org
References: <20261125155108.24098-1-ekffu200098@gmail.com>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20261125155108.24098-1-ekffu200098@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_214939_822572_F1724311 
X-CRM114-Status: GOOD (  23.34  )
X-Spam-Score: -0.2 (/)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 25/11/2026 07:51, Sang-Heon Jeon wrote:
> crashkernel=size,cma uses existing hugetlb_cma memory, so
> crashk_cma_ranges[] may contain HugeTLB folios. HugeTLB folios allocated
> from hugetlb_cma can be long-term pinned without being migrated.
> 
> After a crash, the crash kernel uses the memory in crashk_cma_ranges[],
> but a device can still write to a long-term pinned folio.
> 
> So reject long-term pins of HugeTLB folios overlapping
> crashk_cma_ranges[].
> 

Is spending the workload to protect the dump the right way round for this
option?  kdump.rst describes it as

	This reservation method is intended for systems that can't afford to
	sacrifice enough memory for standard crashkernel reservation and where
	less reliable and possibly incomplete kdump is preferable to no kdump at
	all.

so the dump is the part the admin has already agreed to give up.

> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
> The above scenario is only possible with the two patches below applied.
> Currently only linux-next, which is targeting v7.5, has both of them.
> 
>   "mm/hugetlb: allow crashkernel to reuse hugetlb CMA memory" (kexec-next)
>   "mm: gup: allow long-term pins of CMA-allocated HugeTLB folios" (mm-unstable)
> ---
>  mm/cma.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 0c97aadcfea4..cb4a92e2b9f5 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -32,6 +32,8 @@
>  #include <linux/hugetlb.h>
>  #include <trace/events/cma.h>
>  #include <linux/page-isolation.h>
> +#include <linux/crash_reserve.h>
> +#include <linux/range.h>
>  
>  #include "internal.h"
>  #include "cma.h"
> @@ -42,12 +44,33 @@ unsigned int cma_area_count;
>  
>  bool cma_folio_is_longterm_pinnable(struct folio *folio)
>  {
> +	struct range r;
> +	int i;
> +
>  	/*
>  	 * Explicitly allocated CMA folios own their CMA memory and can be
>  	 * pinned even in ZONE_MOVABLE, as CMA memory cannot be offlined.
>  	 * For now, only HugeTLB tracks these allocations with a folio flag.
>  	 */
> -	return folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio);
> +	if (!folio_test_hugetlb(folio) || !folio_test_hugetlb_cma(folio))
> +		return false;
> +
> +	/*
> +	 * The crash kernel uses the memory in crashk_cma_ranges[], but a
> +	 * device can still write to a long-term pinned folio after a crash.
> +	 */
> +	if (!crashk_cma_cnt)
> +		return true;
> +
> +	r.start = PFN_PHYS(folio_pfn(folio));
> +	r.end = r.start + folio_size(folio) - 1;
> +
> +	for (i = 0; i < crashk_cma_cnt; i++) {
> +		if (range_overlaps(&crashk_cma_ranges[i], &r))
> +			return false;
> +	}
> +
> +	return true;
>  }
>  
>  phys_addr_t cma_get_base(const struct cma *cma)
> 
> base-commit: a036649714c3446abfdc36d0ae483046432b16c5


