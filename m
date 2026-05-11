Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767AACD37AC
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fA83Q2DaPneL5epts3/p93QFzKyzKFKpGeKnTELT3B4=; b=POjUHTl3vXmhXeBLUEOyi/9p8M
	nZBn6nIWBJF9D41+0ul32kUp21H+24ZjZVcv3wWd5KaBUq02UmGo+WgVw+Yl47pZrXFivS2WRNW6S
	SJJfGG8T/nxUo2NnnvL+6AR0yuf/UluevsctqNVow6PMG+bi/ig3sbUw/NrKYNN7/Kft9+lkCBP71
	j0dBKL8xZDpSlv6559v/7a6Q4eSiUK5wouJ7uzDyhJrlrlo5Q8xbbZdApZtfvyxIrMFvnryG4JAIh
	175hunxWEtgDv1la/dvxQFE+/6yqO3XBoCPuSubdxeIVAgg2AFxCHETRz5a/yd+uSdRIxu3N3AqTf
	qH918dMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPCG-0000000DPBy-2WY6;
	Mon, 11 May 2026 11:53:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPCF-0000000DPBX-0XFo
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 11:53:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7D2DD60120;
	Mon, 11 May 2026 11:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83047C2BCB0;
	Mon, 11 May 2026 11:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500394;
	bh=2/hzSY+sORkQ419Yp9gOXgQACkcvdIiFkmQSB5IY/FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6of8An4tXOdeGGXsrQSL2fEmWbuR7PSZSU/JW0UIluhc21Jb+j4Cb9ZYZROG9o1d
	 yAoXXjQF7stp9bdT6X+t7SsrdWLex5dYJO9nCn6HyxH0tPUlndngbEYC8D0CevyvNW
	 BBtK19ydbFfX03vmJ/MX/zHz4PddrkM0x5kZpbSlWhft99m1aCv48oLnAB8OzbyxG0
	 XmND8kYIZpK+wMKNh53fLSdeZ86227bKjkuGtF1SDtYnAd24Z1a8FDPC3tAvmx8mqz
	 OsAwE9MyjYt0d6NA9mhCpKPO9ROmMkA4HHYf+YDJhgiF587RxU2aS5HFXW5RQszvOR
	 slW+U/BLW4+og==
Date: Mon, 11 May 2026 14:53:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] kho: add data argument to radix walk callback
Message-ID: <agHDI-NdI_AhslBJ@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-6-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133928.850721-6-pratyush@kernel.org>
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

On Wed, Apr 29, 2026 at 03:39:07PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Add an opaque data pointer argument to kho_radix_walk_cb_t. This can be
> used for callers to pass extra information to the callback.

Nit:  ^by IMHO
 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  include/linux/kho_radix_tree.h     |  8 ++++----
>  kernel/liveupdate/kexec_handover.c | 24 +++++++++++++-----------
>  2 files changed, 17 insertions(+), 15 deletions(-)
> 

-- 
Sincerely yours,
Mike.

