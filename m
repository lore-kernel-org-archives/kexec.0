Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE74EF31E21
	for <kexec@archiver.kernel.org>; Thu,  9 Apr 2026 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kmhpeXRFnKDZawMaN4TGSoZ0Kow/RbxIHzEqGbCkBA8=; b=17pqWyqdNt+bU3J5MzDDUVklQ+
	kbguncla4Pq/Pg1QOl6ygyrR8o1HnLGN9wifK+gmqHGswXYsFD3GgXYFYuYH9WbWkeLIZrt9YkUyV
	KF4NSu2oDkjrdIy7oaRAwz9oQoWv4ADfKOqji8BpzAkjTAgr5+s55TIEAxAzULV6pbQV/nwLL7URE
	0y3UPYaqi9siIpl1GJhbEHe4ZyNs1EFGTh1aFbMuFB8exrXeVCjv2biIbUprBy5HJDQ9U9iEr1WTU
	FdC1Zzxdbcba3icA8ctoj6amO+ebWl0KNJUO4alh71Ef28JVQmRzlEZiElFuB84ohflaydsv3gEPh
	yetHlL9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAr2p-0000000Am0M-1uDu;
	Thu, 09 Apr 2026 15:11:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAr2l-0000000Alzi-2ock
	for kexec@lists.infradead.org;
	Thu, 09 Apr 2026 15:11:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A91C260125;
	Thu,  9 Apr 2026 15:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D58BC116C6;
	Thu,  9 Apr 2026 15:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775747502;
	bh=KFCI6V1rO1y+xOef/LA1LfimklhqeVXX7IveWVt1pR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7I0kteoBfVBAO4NM+dn3SiWgNPYH6WufMcI7EfNaUzOSVb62RGST4az+Oy9VXVCy
	 KINxPsK34ExMnEypjO5Hmxm3BQB01JZ2AKZq30Rq1t3QgQS+dYwHE1YnwGp3fKGMym
	 9artXLDZNPjS6t46RhIpbtEHfpY3rYEDKBNsvMkOIgEFaxKbiDyZaLRzRWs4SvN+k2
	 uqfmHtkPaVVjqecf6/wdMT39JqZ1S50nFcgrpgQ+L96s9ZBncM4kcTQ1h4/0Xgir8w
	 Bd/tSati6bvFhu3I3D1eizTb0gp8XutMzrmWvf7tKQWdBH51JqSU7XD1woZoqDaabZ
	 2LFAuBdKpaFow==
Date: Thu, 9 Apr 2026 18:11:35 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] kho: call kho_kexec_metadata_init() for both boot paths
Message-ID: <adfBp4WvhKDv7aG9@kernel.org>
References: <20260409-kho_fix_merge_issue-v1-1-710c84ceaa85@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-kho_fix_merge_issue-v1-1-710c84ceaa85@debian.org>
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

On Thu, Apr 09, 2026 at 03:31:40AM -0700, Breno Leitao wrote:
> kho_kexec_metadata_init() was placed after the fdt check, causing it to
> run only on the fresh boot path (no incoming FDT) and skipping metadata
> initialization on the KHO restore path.
> 
> The original patch[1] was based on commit 5c9e55fecf93658 ("Add linux-next
> specific files for 20260312"), which included commit d7176a010afce8
> ("kho: fix deferred init of kho scratch"). That commit has since been
> rebased and reworked in linux-next, changing the code flow so that
> kho_kexec_metadata_init() is no longer reached on the restore path.
> 
> Fix this by moving the call before the fdt check so it runs regardless
> of whether an incoming FDT is present.
> 
> Link: https://lore.kernel.org/all/20260309-kho-v8-5-c3abcf4ac750@debian.org/ [1]
> Fixes: 047117e78331a ("kho: kexec-metadata: track previous kernel chain")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/liveupdate/kexec_handover.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

-- 
Sincerely yours,
Mike.

