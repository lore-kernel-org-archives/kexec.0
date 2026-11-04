Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F31606A331
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FXkQOiZl;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TcOpgZef
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ensURHApHSqZx6uOyzhFmn+kTScsXcNRPyYQC1uz1CU=; b=FXkQOiZls85jJa82Jgst1/9itn
	Xge5l+jgA+O7f11/aHNolhOvSg3DZy6/cd7w1JfiDINgXfCj+HQyw/9dXUwr/rcItm6uhRCoNvRMa
	SCJTuxUd5rFW7QRSja+L8QIvAQsgTJiu3BZjdiIzrXD7vROADS5LU4dUoegWGHOZJcBZAviXvOTx9
	wUXyKlBfDhopU6vSFBkkG2ixYFPEP5zuTJD7teFfoj52CG6z8t1fTwNfP2LRlQM1J48JWqaHKeXw2
	9MsDnCi9/LqUEYNSl6APnSF9E7FQ4W+SGXChzJhQsBBhxCFyvBdz/T3SfphZHy9Jpz+KXYiktV2zY
	2WwatVFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOc27-00000005eLl-14M7;
	Wed, 04 Nov 2026 14:32:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOc26-00000005eLb-0vk5
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 14:32:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6032E6022E;
	Wed,  4 Nov 2026 14:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753631F000C1;
	Wed,  4 Nov 2026 14:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802729;
	bh=ensURHApHSqZx6uOyzhFmn+kTScsXcNRPyYQC1uz1CU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=TcOpgZefoJQDj0LMKZN2iBGkvhXFOXPKKWcv/EELG3wUHGxyUFmCRM1ItUL21vHPU
	 NL30EdFERhZSC/XY5znlGdQMZm3hLLB8tDKOgM7sntuTcodKpH25Nl4e8MahputugX
	 iGMxROzfrdCI5MWnXSfHTdb6BnKnjgcxrpA7aF11iws3kFyfpO2J9N2x0jW5LvDTHw
	 1Las9U1zCRWFyJBh+l9Tz6tJ6e3xFAroBm5WNtxAiFB2PQC4jsJo5mfffKhohxhdco
	 VgFwwZhMbiGRqPCJ/D1rhtDZiR9/MTBL0jU1idXwszX9SprqNES9MFPDmEX9CyJneA
	 hXNHIUwLK6FZw==
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
Subject: Re: [PATCH v3 05/10] liveupdate: Don't WARN if tracking a retrieved
 file fails
In-Reply-To: <20261103010216.3447716-6-dmatlack@google.com> (David Matlack's
	message of "Tue, 3 Nov 2026 01:02:11 +0000")
References: <20261103010216.3447716-1-dmatlack@google.com>
	<20261103010216.3447716-6-dmatlack@google.com>
Date: Wed, 04 Nov 2026 15:32:04 +0100
Message-ID: <2vxzmrrok6qj.fsf@kernel.org>
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

On Tue, Nov 03 2026, David Matlack wrote:

> Handle a failure to add a retrieved file to luo_preserved_files instead
> of triggering a WARN_ON(). Make the failure permanent, and keep the file
> until the file set is finished, like any other retrieved file.
>
> xa_insert() can fail with -ENOMEM, and userspace can trigger that with
> LIVEUPDATE_SESSION_RETRIEVE_FD, so warning about it lets userspace crash
> systems with panic_on_warn.
>
> The handler has already consumed the preserved state when this happens,
> so the retrieve can't be retried. Keeping the file ensures that its
> resources are not released before the file set is finished. Finishing
> the file set then erases the file from luo_preserved_files, which does
> nothing for a file that was never added.
>
> Fixes: 00d0b372374f ("liveupdate: prevent double management of files")
> Signed-off-by: David Matlack <dmatlack@google.com>
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/luo_file.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index 908ae124ea5e..5a82e45b9062 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -684,14 +684,25 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token, u64 arg,
>  		return err;
>  	}
>  
> +	err = xa_insert(&luo_preserved_files,
> +			luo_get_id(luo_file->fh, args.file), args.file,
> +			GFP_KERNEL);
> +	if (err) {

I think you should do a WARN_ON_ONCE(err == -EBUSY) here. Because if
someone can somehow retrieve the same file twice, something really bad
has happened and must be reported.

> +		/*
> +		 * The handler has consumed the preserved state, so the retrieve
> +		 * can't be retried. Keep the file until the file set is
> +		 * finished, so that its resources are released at the same
> +		 * time as those of other retrieved files.
> +		 */
> +		luo_file->file = args.file;
> +		luo_file->retrieve_status = err;
> +		return err;
> +	}
> +
>  	luo_file->file = args.file;
>  	/* Get reference so we can keep this file in LUO until finish */
>  	get_file(luo_file->file);
>  
> -	WARN_ON(xa_insert(&luo_preserved_files,
> -			  luo_get_id(luo_file->fh, luo_file->file),
> -			  luo_file->file, GFP_KERNEL));
> -
>  	*filep = luo_file->file;
>  	luo_file->retrieve_status = 1;

-- 
Regards,
Pratyush Yadav

