Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F8FCE8D7D
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BhBSgv90wZI0qyBpc29SVmAZf3puLnSIxXA/J5fhwII=; b=O7mwV1mSwLs4i5KNvHsKMJzdy3
	x145z/PBmiKY2pylUe6WxjrnnffpxqV06uW2y02ZL28VDHAr/pcNmSONG3R5xv/PmdA7RbUVVA2Vq
	hxO4UKQjA5qaQiLJj6w2TvITPLot/kvJj/0SRqJhPBgf8bKZIJWCLqCUYbUWwHXHMZ/C86rmVu+Jk
	uCP/BV5ETryvkNMcCBdEVI4UKB+2AEx/mfIIzjviK0CWiCqu6UNNOtYA/EgowlZet9MNZIGJ7XFBl
	v26oXam++Ap8BHJLoPxehEKPYbrhfYqNhAUra63Aux91NfIHX2/xed4UEuox6T9miG9/kr4PM7wL7
	guFCe6Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJzXw-0000000D1Of-143c;
	Fri, 14 Nov 2025 19:33:24 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJzXu-0000000D1OU-0S6M
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 19:33:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0611C60192;
	Fri, 14 Nov 2025 19:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E7CC4CEF8;
	Fri, 14 Nov 2025 19:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763148800;
	bh=gNS0T+ZChKXxoN7znfwaqjXaS9x2GuQGcEUhveCqTRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C127I7taFpdO7ZJzL+lRCXoW7/gpoQapchCxBZs+vxjMzUV3uXhiLukMQlXHbTfa7
	 lv5eVOUmm9ZKYLVYR2gYR5Pb9RtP1PYHoeHQ/+PoQ61nn+DrYf1QjHTZOHrmr/ZHNH
	 rMqQvqIKKXvV9HYwvWJnRkLwJZQa3y2ijGrTFEXjDCd1Vyex8xGD1En2pHs2Pe6LFY
	 tX5GfMN7hn72lSz6M+u/OzT6ekbYdJjtt+TRbPlqJ/TqPnohjJl2ZwrK3FCzS8NpqX
	 RY9UFzluM0DrFpog79S6vl3OGcz1csYlFoKB+GmQFnk47VVedGrDgvjk4lW6LfCz1r
	 +sHCw3FtodReg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v2 03/13] kho: Introduce high-level memory allocation API
In-Reply-To: <20251114190002.3311679-4-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 13:59:52 -0500")
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
	<20251114190002.3311679-4-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 20:33:17 +0100
Message-ID: <mafs0ikfc5s02.fsf@kernel.org>
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

On Fri, Nov 14 2025, Pasha Tatashin wrote:

> Currently, clients of KHO must manually allocate memory (e.g., via
> alloc_pages), calculate the page order, and explicitly call
> kho_preserve_folio(). Similarly, cleanup requires separate calls to
> unpreserve and free the memory.
>
> Introduce a high-level API to streamline this common pattern:
>
> - kho_alloc_preserve(size): Allocates physically contiguous, zeroed
>   memory and immediately marks it for preservation.
> - kho_unpreserve_free(ptr): Unpreserves and frees the memory
>   in the current kernel.
> - kho_restore_free(ptr): Restores the struct page state of
>   preserved memory in the new kernel and immediately frees it to the
>   page allocator.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

