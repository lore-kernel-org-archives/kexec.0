Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2D60A261B
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BTiiWfPX;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sj8B4eAd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=lD0avvf7a0W4YUjuR/w8gv8cSrs+orKdOF7+3MwyUNQ=; b=BTiiWfPXpPnzRi
	NMKn++C8+gvzzOjveIo174vps2L7bNafuQeTzMlpnXe/7lTf6y3Ey43gByRuZubeZ0B8iRXQd1s2H
	Jk1iR6Vj9xj30NfhqSCGSLK2jlGgh0Tv/PFQ7Nf6tLL8xGWv1lpDhEuP7PRkpp8GqrU9Tl47s5/Kf
	UM1q1+gzizDVG0mPGQiaAsmZ1NL8J47OrqQAYrb59hm7vY5agc5XIt4zHzJeXRvzJ8g9YN/9jNf0r
	MWkTznbs+nRkyKrnB229DMjGHl92uam0qA8jNGpiqyWod2rohITQ9ng0Q8Bf7W06cH888U3jTOWLC
	KSzuKTjgWz2HYYtHJeaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTxTX-0000000BAoO-1UBX;
	Thu, 19 Nov 2026 08:26:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTxTV-0000000BAo5-2QKL
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 08:26:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F02FE477F6;
	Thu, 19 Nov 2026 08:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79641F000C7;
	Thu, 19 Nov 2026 08:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795076792;
	bh=lD0avvf7a0W4YUjuR/w8gv8cSrs+orKdOF7+3MwyUNQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Sj8B4eAdm1rPA9A9kvkOW8aa2I5KLj2Xu/ZsKGea/JgXDyGjOlLQUJtWAc0TAxLtg
	 eJ2tczDWSyNfNQwR4liU98aTbgD5uB3R7u42kznXNtoxXjknWDEOEPssSP/IP/eD2V
	 hllgA1tTb5DIeyTnCjLheGcOjcgekHLHkk8H+85MimiyKJ/LE6FvyQtLBUwE82qMIZ
	 e2y0muasl5jH+rFsYyYpQVYpUQItMrhoO4w+o4NMMFtJB5b6p1LMBxB9GA2D4qzdV5
	 J34lgUafiEKU5K/Km9nyJjLo7P7cuZ01M6BzfiCxMDeMxnmgxW1T+zdxRh2GyQoXJS
	 jg6Uopcz1f/0w==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/2] kho: drop the incoming sub-blob debugfs view
From: Mike Rapoport <rppt@kernel.org>
To: Long Wei <longwei27@huawei.com>
Cc: rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
 akpm@linux-foundation.org, graf@amazon.com, leitao@debian.org, 
 corbet@lwn.net, rdunlap@infradead.org, linux-mm@kvack.org, 
 kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, hewenliang4@huawei.com
In-Reply-To: <20261119063800.698863-1-longwei27@huawei.com>
References: <20261117092951.4017931-1-longwei27@huawei.com>
 <20261119063800.698863-1-longwei27@huawei.com>
Date: Thu, 19 Nov 2026 10:26:26 +0200
Message-Id: <179507678647.425130.13205346175314463200.b4-review@b4>
X-Mailer: b4 0.16.1-dev
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Please don't send vN+1 as a reply to vN.

> kho/in/sub_fdts exposes the raw contents of the sub-blobs described by
> the incoming KHO FDT.  KHO does not own those pages: they belong to the
> producers' consumers and have independent lifetimes.  LUO, for example,
> restores and frees its state in early_initcall, before kho_init()
> (fs_initcall) creates the debugfs view, so the blobs point at pages that
> are already back in the buddy allocator.  Reading them triggers a KASAN
> use-after-free in _copy_to_user().
> 
> The same information is already available to user space from in/fdt,
> which KHO does own and which stays reserved.  Drop the directory rather
> than adding another interface to describe it, keeping the -rc fix small.
> 
> Patch 1 removes the interface, patch 2 drops its documentation.

Patch 2 is only four lines of documentation for the interface patch 1
removes. It could be folded into patch 1 so that a stable backport
removes the documentation together with the code.

-- 
Sincerely yours,
Mike.


