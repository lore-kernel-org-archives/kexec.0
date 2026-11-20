Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E28606A33B
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QqKm6yqx;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiQFT9Am
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4q/HAzNWIc8z/Kxp9yRP6YEkL7lf8pSJ0VxSvJc2osU=; b=QqKm6yqx4brio9BqfSRv/Q4/ee
	UUkvF7sapumvgTjkt6Ho1tf8KiCxzS6eDvr2Wjk4Taw3ABvHGmzKLeRAcsRAhr3M3YIr5N2Ad2n1d
	CL6jIrjgfC1XtkV2jGB3v969t4TkcT3NBt3R/dnHsn5u8brtGfz2nIwOPADu958mELsI8giDP/TbR
	eH/hnWjTOuMOdoHrTVmuQsN4vuCNeOKwBPZ+McQQXnLIiCMG6ljPmILFrUag2EVTU/6P+KORI3DCb
	KkloAKYIXj1PNS7ftEESBuO4SGW4rD7M0L/DUL9m+oYAiO9Pww3UOtprHSa1fUwaVBxtrxslT26Qj
	t06mxVUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMak-0000000ElYQ-22Of;
	Fri, 20 Nov 2026 11:15:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMaj-0000000ElY1-1wFN
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 11:15:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 39A26402A6;
	Fri, 20 Nov 2026 11:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631FE1F000E6;
	Fri, 20 Nov 2026 11:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173340;
	bh=4q/HAzNWIc8z/Kxp9yRP6YEkL7lf8pSJ0VxSvJc2osU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=eiQFT9AmZXE80k4vQiQVbH6zGKuabiTwvqQFRzxu32eu1FITxzhp6ynTVFOKGWIYc
	 kdt1ABR1nlY1lXBi21g6qB4xy50TYfMLG9JmYyI3xud/sDdL0BZw9ANPtDHZLwQryW
	 CCpH0Hhfd8DgR8jKwZGeQedWSfEuCyYEqOcljny15MzC/AhsZEKPbyCj8I7Xxh0e7S
	 zUj9rDDS3ujW4FY2JfUfbNk9Qm+e3G/+IWEJNSMyMrAiW+P3glbGmOPyJLrc9jvroF
	 7BxRY3IzC/wbNUIiDAHAn+Kfn/hojteAjPxdyBf1vKZNdYdwr9rAyqQJN8eZxA0XXo
	 BMVJFKbr5u18w==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Christian Brauner <brauner@kernel.org>,  David Hildenbrand
 <david@kernel.org>,  Hugh Dickins <hughd@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  "Liam R. Howlett" <liam@infradead.org>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Michal Hocko <mhocko@suse.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  Randy Dunlap <rdunlap@infradead.org>,
  Samiullah Khawaja <skhawaja@google.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Suren Baghdasaryan <surenb@google.com>,
  Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v4 07/19] liveupdate: Add helpers to track the files
 that LUO manages
In-Reply-To: <20261111002358.1842967-8-dmatlack@google.com> (David Matlack's
	message of "Wed, 11 Nov 2026 00:23:45 +0000")
References: <20261111002358.1842967-1-dmatlack@google.com>
	<20261111002358.1842967-8-dmatlack@google.com>
Date: Fri, 20 Nov 2026 11:15:33 +0000
Message-ID: <2vxzbj7j3ga2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11 2026, David Matlack wrote:

> Add luo_track_file() and luo_untrack_file(), which add a file to and
> remove it from luo_preserved_files, and use them instead of open-coding
> xa_insert() and xa_erase() with luo_get_id() for preserved and retrieved
> files.
>
> The next commit lets file handlers make LUO track the file they retrieve
> into, which adds more users. The helpers keep the key and the -EBUSY
> behavior in one place.
>
> No functional change intended.
>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
[...]
> @@ -395,8 +407,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
>  		luo_file->fh->ops->unpreserve(&args);
>  		luo_flb_file_unpreserve(luo_file->fh);
>  
> -		xa_erase(&luo_preserved_files,
> -			 luo_get_id(luo_file->fh, luo_file->file));
> +		luo_untrack_file(luo_file->fh, luo_file->file);
>  		module_put(luo_file->fh->ops->owner);
>  
>  		list_del(&luo_file->list);
> @@ -668,9 +679,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
>  		return err;
>  	}
>  
> -	err = xa_insert(&luo_preserved_files,
> -			luo_get_id(luo_file->fh, args.file), args.file,
> -			GFP_KERNEL);
> +	err = luo_track_file(luo_file->fh, args.file);
>  	if (err) {
>  		/* A retrieved file is new, so it can't be tracked already. */
>  		WARN_ON_ONCE(err == -EBUSY);
> @@ -788,8 +797,7 @@ int luo_file_finish(struct luo_file_set *file_set)
>  		luo_file_finish_one(file_set, luo_file);
>  
>  		if (luo_file->file) {
> -			xa_erase(&luo_preserved_files,
> -				 luo_get_id(luo_file->fh, luo_file->file));
> +			luo_untrack_file(luo_file->fh, luo_file->file);

This looks dangerous.

Since the previous patch set luo_file->file when xa_insert() failed,
this will trigger in a failed retrieve. Except, the file was never
tracked to begin with.

While I don't see anything that actually breaks because of this today,
I think it is a bug in the making.

I think the below is a bit better. Although this change probably makes
more sense in the previous patch, since that introduced the problem.
This patch should just replace the xa_erase() with luo_untrack_file().

	if (luo_file->file)
		fput(luo_file->file);

	if (luo_file->retrieve_status > 0)
		luo_untrack_file(luo_file->fh, luo_file->file);

>  			fput(luo_file->file);
>  		}
>  		module_put(luo_file->fh->ops->owner);

-- 
Regards,
Pratyush Yadav

