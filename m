Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39D606A31F
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rX/OcB0Z;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=AhEibjFt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jQ5eyf1zl1dztY8G8GNDjIbe5i6XtlGMZ8AEehh0sP8=; b=rX/OcB0ZZh/uQfpsrwvv32/805
	c/3btE8KwWbnpPJMcsYZZO3pSiOGjW7Y2LqEEwd+55JrUKPWRPlbrqUOryimLOpp13+e3kfQHQmJC
	UeN8D3g1+fNjBEQFDia2RUJv8H3MV11OvjN052zKnAPRT7pr0upUiUhji4OroTGqOBs5QAKxuTQVG
	lcyP+RgPqhLUMg4gTd+h6ShxHc4N6mnJqOUmYm3Tv3ppXZcEWc/J/y9rbh0OG1BX5pLVeIAgB5IlB
	z4VCBHWaycaE6//sI/FZEAJCy+J5SKK2xe7PMd26WlGtwEzxRhp9RF3UVS557jaLossLnDWjjq1DF
	krH77f/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6uW-00000007bFS-3Puc;
	Wed, 28 Oct 2026 16:54:00 +0000
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6uU-00000007bEu-2POO
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 16:53:59 +0000
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-7cbbb7b90efso359485137.2
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793206436; x=1793811236; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jQ5eyf1zl1dztY8G8GNDjIbe5i6XtlGMZ8AEehh0sP8=;
        b=AhEibjFtjlb0YMLFsvVkNvJjP82l3peCkqdriDGQN+2eUINPYdaVzGEjUdmGP3mPde
         PzTSam+gfLCMrM3AuKGV4gqVYoHFnTn0uXQFpbPUw0DDFxymGTOMl0OnR1N0mt6uOXJX
         VuQtJObrr3MzmQmnlKN8FFpQDCdSQ64/2xsQv16HFmyaTJKUkss1bP4t5Ocdxa6oym1L
         s4st0txFRRw2b4SpxqcaWnfSnkBYxGg828qdhEoEwku4BlP2QSZL5/RMAqHwBFDb173u
         4g0UotqsF0HC88yV4ajok+IQ+JiE8fiHidkO4Pl9SPwQScxpBZgmpU4KlImpmBggcVg5
         7skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206436; x=1793811236;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQ5eyf1zl1dztY8G8GNDjIbe5i6XtlGMZ8AEehh0sP8=;
        b=U2G4CS9Zky0v3ZR8WVs3is+UoCVHNcooGRwoCHVAkQ/CbcXQIThNH8EbSUZJuQFmh/
         dxJjKBj8wLe3gbun8RIPYA2kBA3IkCGPzJ+/tfQPc2wElkE7q5eHk9Odxgdjefd45uj/
         cpKT+RAFOcFEG7rSgR1SfBJKpriMrmxzFqTa3tZE50dyVRcbXKnt5iKjD+DmAIAF+u3k
         33aJ19juzwBSKV9xxstqlrIMmrQ78VoWdJr7zzTA7t91e11l73hGjguNTHgCQNKbbOGH
         D6tF9ETiyyJ/HRkFvg26gv10KJdw0NVvbV4DDkrdbtwcwNS77RqvEXYuBJoj6Aiq4eXC
         nD8g==
X-Forwarded-Encrypted: i=1; AKwUvByccbCReMrcW6KZk68ulZX4cfQHtN+Gpb67I1Cct8++8JOO9IEMlySrTTQENKZIKUyM1gNdQA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ2bk7/OnLnAlHH5qplkKXrSQ2rlY8XyiU5hb3QuIS1xszmKFdO
	cMU+GEBrzyzZdLyxbqenlPvJ9boUUpivKa4H8qU8fvTWgx4gbIelTgWWmoggKfbXqxo=
X-Gm-Gg: AYBFou3YS7gcLoz081dwKzG6toqCaxqNdUKRH3t6c1nAY4SRShawAnb/en3ZCuV8xu0
	6SJKOhJEUU7WAefbJ8++yCNuTK1thnraLjroviZ6s55YiUw734nlmQRbkVBs9p9g5La06+a5Id6
	y6dY2GDuQKuoppJKS3A4yAy37QylqFTOwYwpF6GfsQrhRg+cPOvA0Z+XZNsYt61Zeq6chZa7DGj
	5S1yLLHFPhlcp2nEjZUeWlaF0igacWQmESmUvSPXxEZZkHXI1duaTH9XipwC6Uy9RItmpjmjNA1
	uhy6N6sf+sQLCfsIZS+P6tQpkcuXzfhJBZyp7oU6WGRvUJHJ61Cw234SrGgIZoXYSdcqzRz86gL
	I/E+tQsn0PX1bg8lloyZ6j7eciQfrocD8KDBN3kxMxzWKdUhxWfjLgYjQ7ur75iPnxQwXBmYOnN
	UP7JJ09XlcQCBGKuiVbBslwg9HOrqG/Qh41+ZpQa32SD4yDpcCGPkTgDmLIe0IoY0n6S0hGEChb
	7dGTTpZJaidDL19ocg3XaiyW58n4DHGI7dXXZbEUfHhNqOIAiO4awK5bwK/C7CZENKxglp4pY4n
	xHo2UVUGIm8zgzp+IXlnlwjcM04GMKjvJjwDzdWRwkXxAld9U/lCLZdlZAsttLvutD9QEQP998T
	fLKcw6yF1cdYL7/LIQzreEU/xDuxQCg==
X-Received: by 2002:a05:6102:3e8d:b0:7cb:bb33:8412 with SMTP id ada2fe7eead31-7d03a5063b4mr1453208137.10.1793206435862;
        Wed, 28 Oct 2026 09:53:55 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991259db2d3sm6495987241.6.2026.10.28.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:53:54 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:53:47 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 03/46] mm/memfd: check for real shmem inodes before
 accessing shmem state
Message-ID: <auIoDgHmzpGH6cOl@google.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-3-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-3-6f74bec9a5bb@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_095358_635937_E62B4404 
X-CRM114-Status: GOOD (  24.08  )
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

On 10-27 00:17, David Hildenbrand (Arm) wrote:
> shmem_file() only checks a file's backing mapping. That mapping can belong
> to another file, as with a Coda file backed by a tmpfs container after
> mmap(). It does not establish that file_inode(file) is a shmem inode.
> 
> Seal handling and memfd preservation use this check before accessing
> shmem inode state, so they can access an inode of the wrong type.
> 
> Add file_inode_is_shmem() to check the inode's file operations in both
> paths. This identifies regular shmem inodes, including those used by
> memfds and ordinary tmpfs files, independently of wrapper file operations.
> 
> Fixes: c49fcfcda8b5 ("mm/shmem: update file sealing comments and file checking")
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  include/linux/shmem_fs.h | 6 ++++++
>  mm/memfd.c               | 8 +++++---
>  mm/memfd_luo.c           | 2 +-
>  mm/shmem.c               | 5 +++++
>  4 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index a7c7a96a7cbf9..2ceca7993e4f5 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -117,8 +117,14 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
>  		unsigned long len, unsigned long pgoff, unsigned long flags);
>  extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
>  #ifdef CONFIG_SHMEM
> +bool file_inode_is_shmem(const struct inode *inode);
>  bool shmem_mapping(const struct address_space *mapping);
>  #else
> +static inline bool file_inode_is_shmem(const struct inode *inode)
> +{
> +	return false;
> +}
> +
>  static inline bool shmem_mapping(const struct address_space *mapping)
>  {
>  	return false;
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 0f6fff004f5e4..7d2da23157003 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -211,12 +211,14 @@ static int memfd_wait_for_pins(struct address_space *mapping)
>  
>  static unsigned int *memfd_file_seals_ptr(struct file *file)
>  {
> -	if (shmem_file(file))
> -		return &SHMEM_I(file_inode(file))->seals;
> +	struct inode *inode = file_inode(file);
> +
> +	if (file_inode_is_shmem(inode))
> +		return &SHMEM_I(inode)->seals;
>  
>  #ifdef CONFIG_HUGETLBFS
>  	if (is_file_hugepages(file))
> -		return &HUGETLBFS_I(file_inode(file))->seals;
> +		return &HUGETLBFS_I(inode)->seals;
>  #endif
>  
>  	return NULL;
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 59de210bee5f9..c0811407ce397 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -582,7 +582,7 @@ static bool memfd_luo_can_preserve(struct liveupdate_file_handler *handler,
>  {
>  	struct inode *inode = file_inode(file);
>  
> -	return shmem_file(file) && !inode->i_nlink;
> +	return file_inode_is_shmem(inode) && !inode->i_nlink;
>  }

Yeah, file_ is not needed, otherwise:
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

>  
>  static unsigned long memfd_luo_get_id(struct file *file)
> diff --git a/mm/shmem.c b/mm/shmem.c
> index fadf23f9e21ed..0d41aac125df9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -275,6 +275,11 @@ static const struct vm_operations_struct shmem_vm_ops;
>  static const struct vm_operations_struct shmem_anon_vm_ops;
>  static struct file_system_type shmem_fs_type;
>  
> +bool file_inode_is_shmem(const struct inode *inode)
> +{
> +	return inode->i_fop == &shmem_file_operations;
> +}
> +
>  bool shmem_mapping(const struct address_space *mapping)
>  {
>  	return mapping->a_ops == &shmem_aops;
> 
> -- 
> 2.43.0
> 

