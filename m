Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC86D606A31F
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FfMzfABU;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=TOFAHawp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=q/xBVtBLk16U8qItuEo0/3JxmIlfapOJCXoA5AObKSA=; b=FfMzfABURiMRiH5FWFmCfM/UVz
	W7+3udAPCmhur9xT6SzECso+URtbSvC+IRxNlrEQGrVwofQg35JNx7N102NM9P+MKOny5XT0UAyV/
	3JG29RNt5XeIpUVe8JrzLzVM5g4nyJEVDvyUBgR7RTDYgRT8lMnHhtMtbxDF0gepNiFSiQEQhKvdb
	Akl4KiSW9M7nlU2SAUVmG19vKxuVgp5TzBvfEDrRyXiiml7x8exo7we7hRiAPRsqYnkKBqSZwkdnS
	2NgLIpFhqUbaAwReZDAo0/XoY8z+ya6Fmqnly235/Ff2shHYO2f0b5Tb4gXQ7ccJRe60qEoC2wq+2
	eJ8vNicQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMDdQ-0000000855S-1i9R;
	Thu, 29 Oct 2026 00:04:48 +0000
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMDdN-00000008554-20P3
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 00:04:46 +0000
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-9905d61449cso540789241.0
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 17:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793232283; x=1793837083; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q/xBVtBLk16U8qItuEo0/3JxmIlfapOJCXoA5AObKSA=;
        b=TOFAHawpEawLdXNtcOoQfjtdXhpshrmNg+Lg0eSFBpghgevg4AgSEyzjOEM8wvj29H
         g0r9QIYGhpKeIVawUk5fYb+cImqGWzYYqGx63Yospm3TXJXVpCj95kdfDQtAKczz8ZEM
         o8g4zUZlT1vMGO1aRTzRAwphJEKIKPtzYYqguDDzUl0SOumyuZH60exYKFmu4Z3ZHuqw
         Qdxt3Ob/csDSdmNorsZFuh3PSBm+AvNZct8OBEzwUCv+mbc1c4PgyGDicVEeEumvwSIF
         zMLRVpx3ayvosWHgMdo2pY/Q+yc9An1fTd++QBZqpKsto6yDMrsxbJYZpvJ0QVsmE00k
         YhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793232283; x=1793837083;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/xBVtBLk16U8qItuEo0/3JxmIlfapOJCXoA5AObKSA=;
        b=gy0KGXLQFoxFNhgAo/ERtgVI6GxIWhkTgIb7pIh/OA3FdgL6dua7P/C5LtI0NX1E4C
         g1KHgqRJHPQ9vIFi29XQ00nvMyhYrM4L2HEahHtDc+flhNptuH51fYizHXrLoFC5rSK/
         8ILjAcYcARoxfhIzQ1w9MlC9igWXPR0YnQyAYcJDxyRSQyH0BiG3X59/4gCp9IqOBrZP
         MeR/h+ns5QymRCHSBwX4KGpqK8y3Faq9dpJB2y/v9DoLzyneUqZiqwcOWO4OY3O5hcjv
         YrKNKvfL6Xqwv+szCrzoLRq2TPfAGwd7fciSqome8iV4LGzEPdMRIycVNI4+RzEGKQXe
         vcyg==
X-Forwarded-Encrypted: i=1; AKwUvBw9kK/6kGbDAAidog80PpWbB/Yqd9jxas5tSfZPEL3meI6+6PhGT0Y1bU3aM2AsTTgOMo0NVA==@lists.infradead.org
X-Gm-Message-State: AFq9FYIvcKmsflo5bvWlL/yqtFWcU3t8zyTLnBMs36a6VWDKJ3x32UCh
	jsKBbQKUFPbGXuS001pIijDGZPZsLZkE/mPJZ6PIQHakdGcsyrxTtKagLb6e3I43f9Q=
X-Gm-Gg: AYBFou2PQHH6Vt+st1Z0E6PKE2ak4by+24OgDh9gmjQsDzwa+ylL3qfYzSerDOBToya
	jKA+grjQO658kTIqCo+TPDxaViuI7Qtf7RAtKcgaedq3h8nnkCXonbONzBaZgrrur3nU8VLUgsO
	jRHldna3Tc+jdNVIumG3UE1UymAL7q7qkIDfPuxdpl03XS6Gu7hSUlrxHlISRrHLt2JzLv6Lgty
	advxFYWL65DM6QHptEHS18HtONLMlnF6+KmdXyYFAbXDc0nBhgyQVP1pKh/mmBDu4hC7FoPtCvF
	iqFmF/kMCVufT0viMciFgxHmrmoJB9JFUGRawk3onCzDZG6B1dGquwzUVkBmeTTyW0bgHguqQYB
	S+3FkNQAYfSPZ1j9pDUeHx/uA/gG5hIJsam6ukgTShZHNvblGnosmV/6g90cHzbYZe2xljHzrAY
	jjQSx7h3HXZM4Y6XlGyZc2HOQET/R4FZxXqPMFYG68PGmj0oEJf98XvKTql6rpXmwnsmuaGS+k6
	IXHK/akPRhGdzeCUcXxSXYMZKBdE+wh0D9AZOWOIXigM+fwnmvlSYQQo4HTKV6NGLv6Zhkhho/5
	VUWl1QnnyuV0Sy3VSoBE7ul2LMW0cZYF7SkWaFOwqa244w62nqI3XRZq2sSkJNZU0OOVv2wcEO3
	zC2ehcFUjNs7zLF/cVZhSsxSNuNzyEfAd
X-Received: by 2002:a05:6102:3e92:b0:7b5:1ca4:9df1 with SMTP id ada2fe7eead31-7d03a29c54fmr1908368137.5.1793232283543;
        Wed, 28 Oct 2026 17:04:43 -0700 (PDT)
Received: from google.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99125931983sm7622737241.2.2026.10.28.17.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:04:43 -0700 (PDT)
Date: Wed, 28 Oct 2026 20:04:42 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v2 07/10] mm/shmem_luo: Retrieve tmpfs files onto a tmpfs
 mount chosen by userspace
Message-ID: <auKND0n3LyivCrir@google.com>
References: <20261022225035.377445-1-dmatlack@google.com>
 <20261022225035.377445-8-dmatlack@google.com>
 <179322496574.1894369.544573858973645958.b4-review@b4>
 <auKAlcPN0Lt6Y3Wm@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auKAlcPN0Lt6Y3Wm@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_170445_527772_0F648C9E 
X-CRM114-Status: GOOD (  27.37  )
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10-28 23:09, David Matlack wrote:
> On 2026-10-28 06:02 PM, Pasha Tatashin wrote:
> 
> > > +/*
> > > + * Whether @inode is on the internal shmem mount, which is used by
> > > + * shmem_file_setup() and thus by memfd_create().
> > > + */
> > > +bool shmem_inode_on_internal_mount(const struct inode *inode)
> > > +{
> > > +	return inode->i_sb == shm_mnt->mnt_sb;
> > > +}
> > 
> > Please fix the warning reported by kernel test robot.
> 
> Will do.
> 
> The prototype for shmem_inode_on_internal_mount() is in mm/internal.h,
> which mm/shmem.c only includes if CONFIG_SHMEM=y, but the robot was
> building without CONFIG_SHMEM. I've moved the definition of this
> function into CONFIG_SHMEM in v3 to fix this.
> 
> > Looking at this together with Pratyush's mapping-freeze series ([PATCH
> > 0/3] mm: allow freezing mappings), I think we should extend the mapping
> > freeze lifecycle from preserve() -> retrieve() to preserve() ->
> > finish().
> >
> > When retrieve() returns an fd, its mapping should still come out frozen
> > and only become fully user-owned/mutable once a successful session
> > finish() happens. That keeps the index -> folio mapping invariant across
> > the entire live update until every fd in the session (e.g. vmfd,
> > iommufd, vfiofd that depend on the memfd) has been retrieved, passed
> > can_finish(), and been finalized together in finish().
> >
> > (Doesn't have to block this series, we can do it on top or as part of
> > Pratyush's AS_FROZEN series.), but I think we must fix it either here or
> > there.)
> 
> Ok that sounds reasonable. Should we do that as part of Pratyush's
> series then?
> 
> Pratyuh's series replaces shmem_freeze() with mapping_set_frozen(), so
> retrieve() would freeze the new file and finish() would unfreeze it.
> That should work the same for memfds and tmpfs files..
> 
> BTW, this tmpfs series does a lot of renames and code motion so it
> conflicts with Pratyush's series. How should we order these?

Initially, I thought Pratyush's patch series would land after yours. 
However, since he plans to separate the LU changes from the rest, I 
expect both series to land in this cycle. The order does not matter; 
whoever lands in liveupdate/next first, the other will need to resolve 
the merge conflicts.

-- 
Pasha

