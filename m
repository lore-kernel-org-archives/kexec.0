Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8ACD25958
	for <kexec@archiver.kernel.org>; Tue, 27 Jan 2026 07:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LS8aWoAwuUZfXKGJJtyYD5Ry6YFS4Hs0JmhcUrHlK/s=; b=m1nL6G0m8TJIsTHw15ZWWWN9nX
	lk12F/f58bIIhog+NM1+1CGyvdgO85S4Yp/MbY2kDg4g1Uh9AOHuqkFr9oYcxt6Hg1zToqJcp/WmT
	HegzQJrb0/cmpZH8jUFH3YnQD81Rzh7Z0aNW/tovWK/d0cHqEX7RZhoAE7zLhob+9dvQqYwXKToFV
	ajPr3yno6mgoScBwQdJN6/vgHPo9k89PG6P0R3opy2DD9npNlLvUb5FTV3DN9nWdiZ5bUzJKf4XcL
	owRZqyxdpRH7IJbhxuH6DDEfd+x5IGtcT6+JVEzFbcu1gFsEX/2f/OFi4/Oc1dqnskyrTElddsFAF
	clEtUEhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkdQM-0000000Dm97-1Ez9;
	Tue, 27 Jan 2026 07:23:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkdQK-0000000Dm8a-08ky
	for kexec@lists.infradead.org;
	Tue, 27 Jan 2026 07:23:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 942BF43F89;
	Tue, 27 Jan 2026 07:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0FDC116C6;
	Tue, 27 Jan 2026 07:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769498618;
	bh=wKc6TL0A4RPyPSsNR6BFVNJfOo7cACM6wopJvwkAz0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4bBJQeU/o9hOCFqmG0i2rEDHAXUQpCc0MJKYS6Y5c/RUILsdmi8lxJVvxAa+Cjl6
	 L0Fkyp58vRmqs9H7LMt7ccQ+bhA0PGlobSQELyJcEpBhrnS9bcNhXDAOOySeHifhwh
	 oDWSNMFxC1W1odL6Lv2avlJWJDfi1sEh9IgV+zqZAH3hKAD3zzoNijv8EfZST1APKh
	 c2cbZvdVdf5wtPe+E+4Sg4BWBhIc1AJn5O9Dhz9u3+/MsiLxHi5Mjd/fPCSoZe7Vip
	 X5DbMcjA5hw0brxwPZ8L7gLZpTpER20rkSCVGNiFynFI/cjdd9wpJkSWViWwE4dk4b
	 6AzxEMzqK1u9w==
Date: Tue, 27 Jan 2026 09:23:30 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com,
	riel@surriel.com, SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v5 1/4] kho: add size parameter to kho_add_subtree()
Message-ID: <aXhn8ieKtj3T3FCc@kernel.org>
References: <20260126-kho-v5-0-7cd0f69ab204@debian.org>
 <20260126-kho-v5-1-7cd0f69ab204@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-kho-v5-1-7cd0f69ab204@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_232340_113650_AA731B70 
X-CRM114-Status: GOOD (  19.69  )
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

On Mon, Jan 26, 2026 at 08:07:23AM -0800, Breno Leitao wrote:
> kho_add_subtree() assumes the fdt argument is always an FDT and calls
> fdt_totalsize() on it in the debugfs code path. This assumption will
> break if a caller passes arbitrary data instead of an FDT.
> 
> When CONFIG_KEXEC_HANDOVER_DEBUGFS is enabled, kho_debugfs_fdt_add()
> calls __kho_debugfs_fdt_add(), which executes:
> 
>     f->wrapper.size = fdt_totalsize(fdt);
> 
> Fix this by adding an explicit size parameter to kho_add_subtree() so
> callers specify the blob size. This allows subtrees to contain
> arbitrary data formats, not just FDTs. Update all callers:
> 
>   - memblock.c: use fdt_totalsize(fdt)
>   - luo_core.c: use fdt_totalsize(fdt_out)
>   - test_kho.c: use fdt_totalsize()
>   - kexec_handover.c (root fdt): use fdt_totalsize(kho_out.fdt)
> 
> Also update kho_in_debugfs_init() to compute sizes using fdt_totalsize()
> for the root and sub-FDTs it processes, since these are known to be
> actual FDT blobs.
> 
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/kexec_handover.h              |  4 ++--
>  kernel/liveupdate/kexec_handover.c          |  8 +++++---
>  kernel/liveupdate/kexec_handover_debugfs.c  | 15 +++++++++------
>  kernel/liveupdate/kexec_handover_internal.h |  5 +++--
>  kernel/liveupdate/luo_core.c                |  3 ++-
>  lib/test_kho.c                              |  3 ++-
>  mm/memblock.c                               |  2 +-
>  7 files changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index ac4129d1d7416..abb1d324f42d0 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -32,7 +32,7 @@ void kho_restore_free(void *mem);
>  struct folio *kho_restore_folio(phys_addr_t phys);
>  struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
>  void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
> -int kho_add_subtree(const char *name, void *fdt);
> +int kho_add_subtree(const char *name, void *fdt, size_t size);

I'd rename 'void *fdt' to 'void *blob' to make it clearer that subtree isn't
necessary an FDT.
And s/fdt/blob/ in debugfs function names.
All this could be a separate cleanup.


-- 
Sincerely yours,
Mike.

