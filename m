Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFD0FDEE27
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EIxrK91kn1M62e09nSfgNnwvs2jLd9c5g2/Rq/zkfec=; b=n/Q4tN5ft2BHjNo4CCQKG+6uEN
	rJMwEPo9qpfS+PkAJyrgY7I6l+2DkUlXT40jTJn29UVNz9m/TMNgYAVX6GCJQQMUPCkDxu7Ce/fRn
	JP3PL+WFtxuAD++kTo881NgdXyxNdiYHys4gFmW5GEz1fPVLuAJzAsSFOcbRVCyGlIW34tYR+ukB0
	dmKajjvv449lSsuAgHPm6yiBjMzKM8SUbcz0AP5OaZ0lVP4tfDGxx4pypKRlXKCfpQ+WfTctYFo4v
	lpQ0EUQstKvrTKlB2b/TDLcNGyzeDeI2yyb15tpWaJE7CMn1EBywYBEmN07UFuvGaJ3chtMjz0zHY
	QTZ8EDhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFx9R-0000000BzGf-0wmb;
	Thu, 23 Apr 2026 16:43:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFx9P-0000000BzGH-1udq
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 16:43:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2CF38443CC;
	Thu, 23 Apr 2026 16:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584EEC2BCAF;
	Thu, 23 Apr 2026 16:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776962619;
	bh=BwX/3pz1cBY/YrLGL/Zo60/ngbnFP6zgwqIPvFvoGGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EYr8+U3KRMCF79F5UJRyc/iM2l4R6pBlqGkgAL/TgiLlvt2I/GBOWctUKN4vvoKUQ
	 20uncwssyv/1v+MgottmrjGc7OQ7VYWOwApxZZKxQRcDwOA1hpB7cVCo3Ccgj/2ZH+
	 HB4TqU6NfC3dNwCJncXHzB8DFqDbjJfkcDeS6JV2+8jahGtkytLctJTvwtbIM0oe5m
	 43gvqdjL5+aSYdmobsArVRnmW0imGK2oaQZizpMukjdUQR6HbFtDyGU2NlhbM9MUTq
	 yYaolstMkAnYknKvQxdq9YyPI9L+i3b5KP3BmjdQHGkGnJJwLyyf1O6lOuboWEfArn
	 uCjLN0/dyIVeA==
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
Subject: Re: [PATCH v9 3/3] selftests: kho: test with deferred struct page init
In-Reply-To: <20260423122538.140993-4-mclapinski@google.com> (Michal
	Clapinski's message of "Thu, 23 Apr 2026 14:25:38 +0200")
References: <20260423122538.140993-1-mclapinski@google.com>
	<20260423122538.140993-4-mclapinski@google.com>
Date: Thu, 23 Apr 2026 18:43:34 +0200
Message-ID: <2vxzik9h630p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_094339_519235_A2177BA2 
X-CRM114-Status: UNSURE (   4.90  )
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

> Enable DEFERRED_STRUCT_PAGE_INIT which depends on SMP.
> Also enable additional debugging options.
>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

