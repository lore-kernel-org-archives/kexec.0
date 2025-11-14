Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E8FCE8D4F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ve+WAMq8atN7a13urD4whY2gxe5IxNcUUoYARSAJDk=; b=syzZeKYz0u1JC2h3/jxNL76dPF
	lcepJ72NRYtMJ9U7SIKNBS9MqTfP8MWuPq2EFV/bIbfUvOSZXldK01EZfamvlrm3rIlj2Vms7h7I7
	bXyfO7dhK5Q9n2iaqfoSDrezm1ZX6sJ053QBwRv5gI1YqoJi0hViaTwmI0vTmzPtROwqYonckqhIh
	KFtnbhK9MzKJOZLyaTyexkTNF+1Ka4VThVHOJL8xRWSvR7oNSeSWfbpqgTnOrZPReWScPc8WIeCji
	JYqG4qfTUmlIkflG6QqLpKfj+fsHoL7ms4Ll0aZNk+zlEtbfjI+nki/njjBV3k6UA505IMBucQCT3
	PPhVmNew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwT6-0000000Cikm-3PUm;
	Fri, 14 Nov 2025 16:16:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwT2-0000000CikP-2FU2
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 16:16:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D442540339;
	Fri, 14 Nov 2025 16:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AA4C116B1;
	Fri, 14 Nov 2025 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763136967;
	bh=tSxN8dD+nQ8F1DqUN5WT//XcohZgIvkWhnqveOTbdS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RyWrUZmiPavdad5/L4Ku4XTi4TroUF34qqpGQ2vIK5Mb+GKYPyKWzhjiNLEd4eT2e
	 UVXjYV9X+p75gEgGgQGz51BDugj6dLOcRxf/VtpXcPTXatrH+9uNm5doI0218B3bwk
	 Y2Hg7roLrSqqgo25csIUK5gOEatcZZsUU3dkiavyuOFbjg48aE5Y2hvGJyyrDDRWsj
	 2xMxNTw5GvJRhE3w7q4MlB5q8T2wrOI7/qyovv4wx3MUPDtocUVMtWPmRVLXtriwQC
	 7MQ0J/Goo7rfaJLwR7Of0FxWUIrNKVvaNp8SDsUNbxX54AOCr97HvybItXlgCaUcSZ
	 u1xzn7yEwSdHw==
Date: Fri, 14 Nov 2025 18:15:59 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, jasonmiu@google.com,
	arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca,
	ebiggers@google.com, graf@amazon.com, kees@kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v1 13/13] kho: Introduce high-level memory allocation API
Message-ID: <aRdVvxF2bDVjSN8f@kernel.org>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
 <20251114155358.2884014-14-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114155358.2884014-14-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_081608_613029_160ED7F5 
X-CRM114-Status: GOOD (  12.60  )
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

On Fri, Nov 14, 2025 at 10:53:58AM -0500, Pasha Tatashin wrote:
> Currently, clients of KHO must manually allocate memory (e.g., via
> alloc_pages), calculate the page order, and explicitly call
> kho_preserve_folio(). Similarly, cleanup requires separate calls to
> unpreserve and free the memory.
> 
> Introduce a high-level API to streamline this common pattern:
> 
> - kho_alloc_preserve(size): Allocates physically contiguous, zeroed
>   memory and immediately marks it for preservation.
> - kho_free_unpreserve(ptr, size): Unpreserves and frees the memory
>   in the current kernel.
> - kho_free_restore(ptr, size): Restores the struct page state of
>   preserved memory in the new kernel and immediately frees it to the
>   page allocator.

It would have been nice to have it before patch 3 (Preserve FDT folio only
once during initialization) and use kho_alloc_preserve() for KHO's own FDT.

> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/kexec_handover.h     |  22 +++++--
>  kernel/liveupdate/kexec_handover.c | 101 +++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+), 7 deletions(-)

-- 
Sincerely yours,
Mike.

