Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E344AFDEE25
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 16:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rg4/rbO3ZGDWi1Az/qcfROL4icB/3e+FtvHi40Si5UQ=; b=DUYavPKn0FL8NN3ori1kw3uKbd
	N0CMg+IYDvMx3DwiVD9HB5G+U7564dlhVN6wEYIjFJpoax4QAa2S2x/zFoMYa4/qZpGyU1PYzXVCn
	MZK9r4zQRN6xfXxyEoW2e70W081BAKGc57+fg8NhlWedbESQvjnQDg6uDaFgaXi9X+8MjcUGqge4t
	hMd6JfKtpwn5jH7xyyVObBujnoqNmqbWdSM2vSL0dSBzgW6ZQXqtpto/xJ3Sf4+XrtYvDsoExyj07
	LOV1V9y0FDvRilpPQJTEr+mg3GKcyyQPIN8FmsgcBjxqqKIgBkx1Jh190iugXQx819W9aF7fHF9y8
	ZIUDDL0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFx8x-0000000BzDY-3v0S;
	Thu, 23 Apr 2026 16:43:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFx8v-0000000BzDA-3zTt
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 16:43:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 91BCE44062;
	Thu, 23 Apr 2026 16:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03F6C2BCAF;
	Thu, 23 Apr 2026 16:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776962588;
	bh=PbPs/W4+n3I7+0udzca9mgH75HU493tf2uasPDZI9eA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y48yIR677BPTn8wzenQY15Cy8LxN5kt7WPJJXzr1lKd9Lk1jv2GwGPBAThNIpO2Ye
	 AdtpFceEHKJru/iCf+mZUf62f5m8sE6Y4JKBj5eS3GALtSND+fkQXahsZBb6xKnKp6
	 Mf3saSepeov0+zKGvO6pUHcZmP1mK4lyuRrkVjbxBuitOqyOV7i7W8XfgQ5ZzFZMKl
	 PANBDADHEJkHKi47hf8hrKMD4jFW8+WMBHuLluRYZQxdVIb4uyyqYy+UzCTnnfNnnH
	 Kf20oN9hYLO3vKWFOKHqAIr3Bb86x6Ek+VaZKTQ9VMCqiU2+2aVVsxFHOLDXkDJ2Ow
	 scZoKtxrgyrlA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,  Pratyush
 Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,  Samiullah
 Khawaja <skhawaja@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Vlastimil Babka <vbabka@kernel.org>,  Suren
 Baghdasaryan <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,
  Brendan Jackman <jackmanb@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v9 1/3] kho: fix deferred initialization of scratch areas
In-Reply-To: <20260423122538.140993-2-mclapinski@google.com> (Michal
	Clapinski's message of "Thu, 23 Apr 2026 14:25:36 +0200")
References: <20260423122538.140993-1-mclapinski@google.com>
	<20260423122538.140993-2-mclapinski@google.com>
Date: Thu, 23 Apr 2026 18:43:04 +0200
Message-ID: <2vxzmryt631j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_094310_014824_F53DD383 
X-CRM114-Status: UNSURE (   7.78  )
X-CRM114-Notice: Please train this message.
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

On Thu, Apr 23 2026, Michal Clapinski wrote:

> Currently, if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled,
> kho_release_scratch() will initialize the struct pages and set migratetype
> of KHO scratch. Unless the whole scratch fits below first_deferred_pfn,
> some of that will be overwritten either by deferred_init_pages() or
> memmap_init_reserved_range().
>
> To fix it, make memmap_init_range(), deferred_init_memmap_chunk() and
> __init_page_from_nid() recognize KHO scratch regions and set
> migratetype of pageblocks in those regions to MIGRATE_CMA.
>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

