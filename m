Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3762C5518F
	for <kexec@archiver.kernel.org>; Tue,  4 Aug 2026 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xMHP+hPMOaHZx9jDNO0xYD9pWUWMBLkbRPM0u4QDrOo=; b=IOdL6GhjwILjh3YQCunM0WzXw7
	cnJT+6NdDuVXTocGrs67SJ0Ir32SQ7hl6fsy5OtNrX3yyRCFk+HGruUPn01757W2z12alkK0A5OOs
	r9kxOyUhcsGh0ej7fPlbZegXCA8kcFmaKcuxReJ5ZhooqGSEZiCcSvR6RemtKz5ygwgXHB8uWXV+I
	FDEpLssJMk4fXXwBCx3APGKM3DBQWJin7/oX82BQAExNih7fAZEFBfuka9bVM6ufGFCu7bJ3oK/5U
	NpCxGrD5MKUargTMk9V4a4dH8govZAutYfT/PIAno+gS9vNppW8hQlOuxl6xoqtdYi+gZ15/3MPiQ
	WnRx6CcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrGGH-000000025vZ-1wGB;
	Tue, 04 Aug 2026 14:36:57 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrGGF-000000025v5-3KCp
	for kexec@lists.infradead.org;
	Tue, 04 Aug 2026 14:36:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 306B343C39;
	Tue,  4 Aug 2026 14:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0281F000E9;
	Tue,  4 Aug 2026 14:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785854215;
	bh=xMHP+hPMOaHZx9jDNO0xYD9pWUWMBLkbRPM0u4QDrOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HbEtkvAZf70uDRm57s8S2Js++GGFN/fljdOhoJptzMF2N88EfAEJdmrEAOiM6HJA2
	 Uml3dId9f0WYqJxejCZCNArT9SawT2uP5jBSBBTLxELnu+vfc0GrsQQToYXnzZw7ay
	 R2cCwVxzqM2fT6TWYAaKqN1WqujNXbIzjc4hw/eC6rhhFCv/KfYrxFLih6Jrc63Rhu
	 H65iFpahgeGYB5ENvkbVjTZG7Kplz40leJ2pXOnMBN5hi05peml/UnMWFScX1c0N16
	 swAnz9kYXUJDHs4BvIs96i8yud/gEHZr+fA+ZQz8W3xvRfOJnYVR7bTf9PNnG88X3G
	 +61ZdFvaiiEig==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 53B4D198005C;
	Tue,  4 Aug 2026 10:36:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 04 Aug 2026 10:36:52 -0400
X-ME-Sender: <xms:APlxaugx6RXIfl3v3aDSMW0ncJwAyy3pLzAUtRUokhDAKNBC9I0DUA>
    <xme:APlxas611YFY_Rg92zXDB25utn_Hk_llj8ms3tot78f4y0wufCTpw9u_bbq2Niada
    5EMkb3Y4odp-bn6EYhByDMUkenXkjP5sbjiR6vl59XbLUoDJFlD-5M>
X-ME-Received: <xmr:APlxavLwEjMZQ1IBwnbCXr56XcJFbnqC8Ny4SeDk02wyxNn2EMCHUBaylk4>
X-ME-Proxy-Cause: dmFkZTFhdGzLG39r1fMJddaw2USXwwshGe2dXEdkL6WJwsFjOH3SdHoN64VD7l/z+M8aMA
    4AjIBR2yzva7tfrgZigRLsg6cD+RB1DPGvEMnmO9G+1lDkX/EXVbxIdZbn0UeqbFiuJ4/r
    gyVQZ01CzYF618dykSnjz8ppv0caM8t0SMTDncdEUQUmHYImfVsKz0hQwHW9gNiycWqLRV
    WSMaLbFxWRx3XFZF6qtVLvbGv3Oc5bfAz52rJ02W1a4rDBLkqzpI2xBOcimCjvxGSGUbcD
    UZSi+TEdX0ZKm7T9C+gTHS5O3QVH+kRCBSzxorCQsCu4xyiAEjBf85LNlNHXsYIcHP/bZT
    y9ElmDOfTPofTD3biREhXmS/3/YA1l3kKXL1JPXMZqPsHnKV4lwAdHbFieVsTTMB0WxxeJ
    gpE/ZDETEt7gEpR5pgZ+kSaPTFT46I2/SseRBTCPJ7d/ph1n2wKmLua1xwtqMBq7tnuwt1
    WcDN6VDPdB6cNQEVwElYTlLy5vNHbmTDx9RnoQ51rjkfOwE4hp+CwfANrClC+nFGJduohN
    Fyg90+BlIbFbygBlp6B+xRaV9RF2hU2o3YGvd4tvlGm1ykhw/YtveSA6NqtYkRTJGcT0jT
    inYKiVKVyK3heu/y3I7hbiuDUNur6cNpm8WMjUmMhQdIntVB8GtsD3OBSypg
X-ME-Proxy: <xmx:APlxaohgtFkYNZB9P24X4TXe7X6JSD0n1NWpWO2ZZT5U4Yh9EdK9Hg>
    <xmx:APlxakJMCwFzE8uZYpmby2AO8jgsRCpHQ8i7uYWtSC0wvSuHQlMKug>
    <xmx:APlxathVa0Uz2XeVL-tZHO5hN4St8GJP6Ulo_DCfEUXq3Lsm8sONpA>
    <xmx:APlxat0bFoBmPsiivHmT90C9inEDleeJSM8BvHwH_6bYCeoBz7ni9w>
    <xmx:APlxakaZC_dsoWXGBa_Y9EFyxE6ERYBXKMOW85tXaPkkSpUeVfWJgZpH>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 10:36:48 -0400 (EDT)
Date: Tue, 4 Aug 2026 15:36:47 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v3] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <anH1JdVtiM9VoXMH@thinkstation>
References: <20260803-kexec_posioned-v3-1-83aa6ede0351@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803-kexec_posioned-v3-1-83aa6ede0351@debian.org>
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

On Mon, Aug 03, 2026 at 05:41:10AM -0700, Breno Leitao wrote:
> @@ -504,6 +505,15 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  			continue;
>  		}
>  
> +		poison = range_last_hwpoison(temp_start, kbuf->memsz);
> +		if (poison != PHYS_ADDR_MAX) {
> +			/* we hit a poisoned page */
> +			if (poison < kbuf->memsz)
> +				return 0;
> +			temp_start = poison - kbuf->memsz;
> +			continue;
> +		}
> +

Hm. Don't we want range_first_hwpoison() for top-down walk? Otherwise
the end of range would land on poison.

>  		/* We found a suitable memory range */
>  		break;
>  	} while (1);

...

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a8b03e2920ba8..ef0e989c25d93 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -96,6 +96,31 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
>  		memblk_nr_poison_sub(pfn, i);
>  }
>  
> +/*
> + * Return the address of the last hardware-poisoned online page in
> + * [start, start + size), or PHYS_ADDR_MAX if the range is clean.
> + */
> +phys_addr_t range_last_hwpoison(phys_addr_t start, unsigned long size)
> +{
> +	phys_addr_t poison = PHYS_ADDR_MAX;
> +	unsigned long pfn, end_pfn;
> +
> +	if (!size || !atomic_long_read(&num_poisoned_pages))
> +		return poison;
> +
> +	end_pfn = PHYS_PFN(start + size - 1);
> +	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
> +		struct page *page = pfn_to_online_page(pfn);
> +
> +		if (page && PageHWPoison(page))
> +			poison = PFN_PHYS(pfn);

Oh... I think it will not work for hugetlb pages. It will give
false-negative.

We cannot just set the bit hugetlb pages as we don't always have memory
for tail page -- look at HugeTLB Vmemmap Optimization (HVO). Hugetlb
uses a trick to encode poison page. See code that uses _hugetlb_hwpoison
in struct folio.

I think we need special-case hugetlb here. (One more reminder why I hate
HugeTLB).

> +
> +		cond_resched();
> +	}
> +
> +	return poison;
> +}
> +
>  /**
>   * MF_ATTR_RO - Create sysfs entry for each memory failure statistics.
>   * @_name: name of the file in the per NUMA sysfs directory.
> 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

