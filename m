Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE75606A323
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zfyLxeLX;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=MzXfkxIX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PRHEIBcRVtOU9mxXH6oSTTLdGiFLeS2r2uPk2vm17iM=; b=zfyLxeLX6I6ckBiqrbTOog5d6y
	dY8KW78V36crmJoT2XQgVe/zSDWsAS/QOrCwj8Pelnd212xzbMgnkxFy4rFcUfOEhp4Fi4PWlI90c
	d9BVj8uhoBSkBLvVPf/hX97g8U9ZO1tZ62qc9lfr2AsSkb1Bti3ASmigHEguFMyFeePWk6ymNVVkG
	UEBvJSwrmBiKnW052SFYoafpWIgqPilUmLzU/jHeep+zH5Mvdbs+J/19aMHvsU0SjbbLf5zlfoVWv
	RI1DSt8obVVSbDY8N3WasBeNS51gcnwMLy7NAWOFMUPJLvZTsq7hbf6qKQtwHZcS6mpT/x0kmtm+G
	93bDnlWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6vd-00000007bSC-0MRC;
	Wed, 28 Oct 2026 16:55:09 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6vZ-00000007bPu-3Q8f
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 16:55:07 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-5eaf169fe3dso409206e0c.3
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793206504; x=1793811304; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PRHEIBcRVtOU9mxXH6oSTTLdGiFLeS2r2uPk2vm17iM=;
        b=MzXfkxIXRU9DVtUwRinN/QsSlMj3rV5dZXRhLJVYsoL+TORpsgigRTaHFm/EXGzRon
         RSlWSgZu20THyBMDHbjtQbeYxtnqdS57/QA/QFyJGjY3VRYOmeLA3FsRse9ZayKEci0q
         oo6rixBemLEGmOt3v4LdqAPbRVV0TQMbXaCpxwK7ca8Pc3iXHT8stkm1/2zJgPbiy4F8
         x2YaKw2qZoLrcsHXeXD7dSSwXdhwa20BeZA2kef0FKAcVDTv1inDpNOtN1yAtugGPZGM
         dhvc1rVd0NF+699aHfkDbI7nrFu5Exp0dOtaZCnkETlDoVjCHm0NQqyODiGCYd9IniAp
         N6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206504; x=1793811304;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRHEIBcRVtOU9mxXH6oSTTLdGiFLeS2r2uPk2vm17iM=;
        b=05URNrto2SDAfS1jf72unFX+L/f3htdBWLAA8RQ1RqSzuVh3tCCVA5vjNzz8Nvu+qs
         HgD5oj4nXkCqU8D4/Zfr/5Utrkzq8Y6Kv8Q0npvurVnei4vnF/jfOy5Ru+Jq4a1SG8ao
         vwD7ojL0FDcmZTaHxal01jGzupH/+IILzikGxa3aK0YcYCBtogZmulkPfDfJYylPTkLU
         OSmDMPGeqTrAmeGzSEA6IBw26+zIR9SPHdTv1t4WALjAXomyf37JX7ng1AQrrJ5HSFCW
         gtKUaqF9mkmkfrrk/rwMWuG0LjrB72J68ZYciOAKK3p4Gz7/DOATkB2UDsiSpFGfFd2I
         6S3g==
X-Forwarded-Encrypted: i=1; AKwUvBx2vBpxs04RDI9xGI4YefH1GH8bsR+v5IWRCvpuFCHAlTsWyCUolqHFxvkxigl6r1bmh1xTvQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYIL41k47xkMFybXnpNVVoL0Fpf5k4LaJ5SRH6vtEPp568rjvb6b
	Esace6Obb8fTDVoQww/KYJLoDWM3m4p3yJzOOG4sJjTAbqLhNFTq+pnbcxEwY9gjWhE=
X-Gm-Gg: AYBFou31SF3gx9SCAOxRcsLpywabdO/PJ3PJH91CrzgJjgS2OthuY/XJdzT9VslaYl1
	TwvoT6RO9IVAydDpj19Qrxe2e6GQPM3yXuzviw+uRu0vW2lunv8sF5LQcnP0py0cKJ9tipn0OAE
	DcIxfLvet4iMldzV+3LI7AcTvJnCM5RnGjukrz4SgLfiPNVJBTY66P3fWtJM//OEd8ja3ed2r5H
	kDGsu65NbalQLnn2iVE2zDn7s8uqMlzk4H5DWK9BUss62jhTUJ6w6OgdCdYAYsDK0xJZF6u3s9A
	tJOdrEbfNK1ZJhL3FRST6rrEoERCelZuCkhCNBX/HJNZ8NMayACXZfnGrVmfazPx4tYKKtZJ0L7
	Ey5tCf+3hMmj8iBoNMWy38legGKAntWpXGgDq0VT2nHdw6JXCBGJJVuX4273R7Tjkg6NetUnFRO
	V6fPn5CgeLvKblz3X3UV9hPaPQxgiTOqfBieXJDGStKJMksoMfxps+xtd9vU0wS2y3kjKv0h8vS
	KYks4C5wfpVd5vYWSR5tNLG0f7Uu9hq7NsnPz03tU5hQK+wEEaX62Z7IpCUCMNXjVVPlLWDqRH4
	cn2CE2DqmMFW11SiNiyW+RrFqtjVpQmrJDXvKtRMf4MrpE6zDSPQLuZ8y1DmpO6o1Q8qfxnkbBX
	pi1Tg6fDa0VGRnXRXF9JsrHcOFy049A==
X-Received: by 2002:a05:6102:a54:b0:7b1:6028:5475 with SMTP id ada2fe7eead31-7d03a505a71mr1235376137.12.1793206503993;
        Wed, 28 Oct 2026 09:55:03 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3d32a48sm6300543137.9.2026.10.28.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:55:03 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:55:01 -0400
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 04/46] mm/memfd: make f_pos accesses atomic
Message-ID: <auIoupm228FQTNGi@google.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_095505_871485_CA4E823B 
X-CRM114-Status: GOOD (  26.10  )
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10-27 00:17, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX") made
> read(), write() and lseek() on a shared open file description of a regular
> file serialize on ->f_pos_lock.  The flag that asks for it,
> FMODE_ATOMIC_POS, is set in do_dentry_open().  A memfd is a regular file
> too, but its struct file comes from alloc_file_pseudo() and never passes
> through do_dentry_open(), so it does not get the flag:
> 
>   CPU0                                CPU1
>   write(memfd, "a", 1)                write(memfd, "b", 1)
>     pos = file->f_pos  (= 0)
>                                         pos = file->f_pos  (= 0)
>     vfs_write(..., &pos)
>                                         vfs_write(..., &pos)
>     file->f_pos = pos  (= 1)
>                                         file->f_pos = pos  (= 1)
> 
> One of the two bytes is overwritten.  Two threads writing 100000 bytes
> each, one at a time, to a memfd end up with a file that is far shorter than
> 200000 bytes, while the same program on a tmpfs file never loses a byte.
> 
> Set the flag when the memfd is created.  As for any other regular file the
> lock is only taken if the file is reachable in more than one way, and
> nothing a memfd does in read or write waits for another operation on the
> same file.  This cannot be done for all alloc_file_pseudo() files: anon
> inode files such as eventfd are S_IFREG as well, and a blocked read holding
> ->f_pos_lock would lock out the write that is supposed to wake it.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 9183df25fe7b ("shm: add memfd_create() syscall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: minor description tweaks ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> ---
>  mm/memfd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 7d2da23157003..6f5fbce74f21e 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -484,6 +484,8 @@ struct file *memfd_alloc_file(const char *name, unsigned int flags)
>  	}
>  
>  	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> +	/* a regular file like any other: POSIX.1-2008/SUSv4 Section XSI 2.9.7 */
> +	file->f_mode |= FMODE_ATOMIC_POS;
>  	file->f_flags |= O_LARGEFILE;
>  
>  	if (flags & MFD_NOEXEC_SEAL) {
> 
> -- 
> 2.43.0
> 

