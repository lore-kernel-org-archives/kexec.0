Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE86CAC59B
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zm/y1D7s43WyhF0XeZWL5HSiuUb+YLhCe29XHDsKitM=; b=W79wAl5qoUmFt5Rizszb0Ogbup
	sy57UwOslKIipN8juIv8dDw+Ry09ZcpFl4vj+qZMZa3YkEQKZ/O8vRpvTI3JA+mNSiSjwUpy1FC11
	K3oV0e297D0uejLiUqZguyrk4h8j4ohlcewcBUIyoDe1OZ0wSrtGfT85FuNqCzpsrTff1rJsfhp9F
	2j6RTs6Wue4yr4hl9ifTtlIARR9jz99h9Y4sF7kOhTtQAcee/0WSM/Dwnx/Y/Kyv0x/jQW02bKlg0
	ehinb/mhqXNO8lZuMAkcLesnU/HcMusWR/9BZl8kv/s9oy4glp2YFsKFW3GcgbHczUfZ/qoLY+rxc
	bQLrXnMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyWoF-000000089PM-0DEz;
	Tue, 16 Sep 2025 14:37:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyWoE-000000089P9-1maj
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 14:37:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E2061601DF;
	Tue, 16 Sep 2025 14:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74623C4CEEB;
	Tue, 16 Sep 2025 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758033447;
	bh=LgO5/yIM681jTrDMpq8xGFhrw1pnS2TvOssqGdcDUCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZN1ct+08J2HGLhNlNLuFWoe5C1alwpgQhtMeSmLSwH9dlwRSe6s3/oXgwOLOzbBlQ
	 PXzXEd86PJ9ccKF0e8Qpla8hYUK4grbeGFjGSOb9K8AXPMkJLiDDIvnraAWyyYlZaA
	 3yMAqc6xK3vhvitPcAQ247EwtzG/RPw8JG3N7cbBJm57zZ3CBZ9lOulbeA1Px/h2s+
	 RXuYmEWymSRiUoLadgIGLtH40Jj6EH/zUUkJIw1tqvgnPAghpo+5BW2ZySzqHEAKRL
	 B+bEFypAX1aQFvcNUbgVJC88obupLOi9uZCERwx4xTeog6t+8o7/+21q5bc5zMdfTK
	 LwJLKBnL+qljg==
Date: Tue, 16 Sep 2025 17:37:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
Message-ID: <aMl2H3BLpH3xFCOw@kernel.org>
References: <20250910153443.95049-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910153443.95049-1-pratyush@kernel.org>
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

On Wed, Sep 10, 2025 at 05:34:40PM +0200, Pratyush Yadav wrote:
> When restoring a folio using kho_restore_folio(), no sanity checks are
> done to make sure the folio actually came from a kexec handover. The
> caller is trusted to pass in the right address. If the caller has a bug
> and passes in a wrong address, an in-use folio might be "restored" and
> returned, causing all sorts of memory corruption.
> 
> Harden the folio restore logic by stashing in a magic number in
> page->private along with the folio order. If the magic number does not
> match, the folio won't be touched. page->private is an unsigned long.
> The union kho_page_info splits it into two parts, with one holding the
> order and the other holding the magic number.

I think the sanity checks belongs to the core kho_restore_page() function
and kho_restore_folio() should be a thin wrapper for that, at least until
we'd need to allocate struct folio there.
 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  kernel/kexec_handover.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)

-- 
Sincerely yours,
Mike.

