Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1B606A31A
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pd19NGcd;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=n+5+OHRQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BSMajUrIRWokvEVqqfI78Nzwlqlux4vwQO4+MOjfV+o=; b=pd19NGcdJNLl2KCtGOOn5Q0o1U
	jBO3Gw5jVnTdU+YjeFUPYBkXQdE2INZcayr5fA0G0R+iNV2fRBRV/rt3kRkipg+x9ovRULzwY9JcW
	xWY63u4+SI4Pr9VwUXyNRpf50syPQ/XTTf6chUXJoVTOsco3v1bWsCCUwc7onvB1xcZOOwA8E89Gd
	Y2LUyjcpVMmkxyUtErkMDxmhbLGEGlEIUjn7xsojGfWSLdZlj8EBeb3CiIQZzAR6p0xXZKbZWnDUd
	/a2B73iDNXWclnbu2iO2fSowY6F7cFzZFly7MjSe+nf16b0f0DNYReKHUm0Vj6XCIj8y4Ug/isp1F
	PVfjpNUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM9Ja-00000007rHB-2ccC;
	Wed, 28 Oct 2026 19:28:02 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM9JX-00000007rGY-3aRC
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 19:28:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	From:Reply-To; bh=BSMajUrIRWokvEVqqfI78Nzwlqlux4vwQO4+MOjfV+o=; b=n+5+OHRQAxJ
	59yCrr69KDXP9RQOEKk8GR+jY9iET8bVfnnVgTQiEz0oQgq8pbdIld1loOHywld3JdPYWF/PmBYGB
	RKWmW3U9wbyYYlK3WoZZTF695hgn819oakXiz97sHa5Lajz0bodTI+2SW2aoU/NHoOzPk6lqv0Y0d
	P743VNNi/bTMYmAOwVT9LcxFdKO3CED846nUgpBT6NgsNw/qIwpUTDZ+7asWMmzTiCPMmvoCGCpq7
	Wt6YwZR0A/kEXrEdbvwPUErnzMJ90+XEnSlUu/iizkfDXjblmo6F1IW9ZjeOrllCySjm9uD4jgJZU
	jm8msZJ5H0z9IoIqIjHBnxQ==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xM9IO-00DAtn-FH; Wed, 28 Oct 2026 20:26:48 +0100
Date: Wed, 28 Oct 2026 16:26:27 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, stable@vger.kernel.org,
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 08/46] mm/filemap: finish fault cleanup before dropping
 the fault lock
Message-ID: <auJMY1xFp6EkhXbZ@quatroqueijos.cascardo.eti.br>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-8-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-8-6f74bec9a5bb@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_122800_088906_57D216DB 
X-CRM114-Status: GOOD (  35.84  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 12:17:28AM +0100, David Hildenbrand (Arm) wrote:
> On a retried fault, a fatal signal interrupting the folio lock wait
> makes lock_folio_maybe_drop_mmap() drop the fault lock without pinning
> the file. However, filemap_fault() may still need to release
> mapping->invalidate_lock. A concurrent munmap() can release the last
> file reference and free the mapping before that unlock.
> 
> Defer dropping the fault lock to filemap_fault()'s retry cleanup, after
> releasing invalidate_lock. If the fault lock was already dropped for
> I/O, release the existing file reference instead. Keep the fault lock
> held for FAULT_FLAG_RETRY_NOWAIT as before.
> 
> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/filemap.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6b5e1d866a9e0..b04be64a5069f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3308,11 +3308,11 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
>   * @folio - the folio to lock.
>   * @fpin - the pointer to the file we may pin (or is already pinned).
>   *
> - * This works similar to lock_folio_or_retry in that it can drop the
> - * mmap_lock.  It differs in that it actually returns the folio locked
> - * if it returns 1 and 0 if it couldn't lock the folio.  If we did have
> - * to drop the mmap_lock then fpin will point to the pinned file and
> - * needs to be fput()'ed at a later point.
> + * Returns 1 with the folio locked, or 0 if locking failed.
> + *
> + * On both entry and return, a non-NULL *fpin means the fault lock has
> + * already been dropped and the caller must eventually fput() the file.
> + * Otherwise the fault lock is still held, including on failure.
>   */
>  static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
>  				     struct file **fpin)
> @@ -3329,21 +3329,9 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
>  		return 0;
>  
>  	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
> -	if (vmf->flags & FAULT_FLAG_KILLABLE) {
> -		if (__folio_lock_killable(folio)) {
> -			/*
> -			 * We didn't have the right flags to drop the
> -			 * fault lock, but all fault_handlers only check
> -			 * for fatal signals if we return VM_FAULT_RETRY,
> -			 * so we need to drop the fault lock here and
> -			 * return 0 if we don't have a fpin.
> -			 */
> -			if (*fpin == NULL)
> -				release_fault_lock(vmf);
> -			return 0;
> -		}
> -	} else
> -		__folio_lock(folio);
> +	if (vmf->flags & FAULT_FLAG_KILLABLE)
> +		return !__folio_lock_killable(folio);
> +	__folio_lock(folio);
>  
>  	return 1;
>  }
> @@ -3572,7 +3560,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
>   * vma->vm_mm->mmap_lock must be held on entry.
>   *
>   * If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
> - * may be dropped before doing I/O or by lock_folio_maybe_drop_mmap().
> + * may be dropped before doing I/O or when aborting an interrupted wait.
>   *
>   * If our return value does not have VM_FAULT_RETRY set, the mmap_lock
>   * has not been released.
> @@ -3728,9 +3716,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  
>  out_retry:
>  	/*
> -	 * We dropped the mmap_lock, we need to return to the fault handler to
> -	 * re-find the vma and come back and find our hopefully still populated
> -	 * page.
> +	 * With fpin set, the fault lock was already dropped. Otherwise it is
> +	 * still held. Release invalidate_lock before dropping either protection.
>  	 */
>  	if (!IS_ERR(folio))
>  		folio_put(folio);
> @@ -3738,6 +3725,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  		filemap_invalidate_unlock_shared(mapping);
>  	if (fpin)
>  		fput(fpin);
> +	else if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
> +		release_fault_lock(vmf);
>  	return ret | VM_FAULT_RETRY;
>  }
>  EXPORT_SYMBOL(filemap_fault);
> 
> -- 
> 2.43.0
> 
> 

If I understood this correctly, the invariant is that if fpin is set, then
the fault lock has been dropped.

At first, I was confused that maybe_unlock_mmap_for_io drops the fault
lock, but in that case, it also gets a reference to the file, so fpin is
set and the invariant is kept.

With that:

Reviewed-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

