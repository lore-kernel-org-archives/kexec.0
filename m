Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402960A2617
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k51+yKey;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIWH6Hg6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=E6d7w+bAYSu5dtWtl5fUZsUOR40mrhZ84JxkLfa82GE=; b=k51+yKeyK4pg82QZ/P6Tf+oz/Z
	qBmcdIODn9fu91lVQKo7WVKtfHPMGGB+mtVsr6uwR1m4L36DvJo7YK2rhraZzY9eMSdpRjqKIbgUq
	CjsN/+SbYokimNMdeNhxX7GuNRMOkExG7u3cnMAWVFnY1huKYPAlLIVrTfyd8INhBcSuoXUkJ/URy
	d2bQRI/+D1DSsMNHyMEvOnkq7TI7b5mH5INi3M+xKz0Rf6nNu4wc1taEZfOn2ispTwfIO/Dv1t30U
	XkWvp3yJZ0XJfsw3KGOJWvRyEtFwjNdskxllW+oZzmkqe5T0jTWRrRmmiZ5pmeYSQwEICkaMCxmuD
	3B4lVJ5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xULNy-0000000EXrv-41zJ;
	Fri, 20 Nov 2026 09:58:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xULNx-0000000EXrH-1Bz2
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 09:58:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B91C9611C2;
	Fri, 20 Nov 2026 09:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC3F1F000C4;
	Fri, 20 Nov 2026 09:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795168704;
	bh=E6d7w+bAYSu5dtWtl5fUZsUOR40mrhZ84JxkLfa82GE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VIWH6Hg6ZngwRI0Sh8L6RPMEKJzqjKamjETcbLDxmQ9/OCIxXv4eFzXJ5hekmLDAI
	 /Dj0EoHYcLqjlUjJ5/DYPr/SnUG01jX+yRhY4UkBBvYa0U25SDar06EnekwxgaadyZ
	 DXfc5VfhhA/lGEvjZ2XGV4xYeB937AG2HyEqmZgvlQYHNYammlo9aT+xuBrwu4KAFn
	 kOOFTbrmmS86ONpWUk4BoEIOEB2CMXrLzM1SaG0Rq3BzlvqsS9jYldZt07fV5x7yH0
	 Lb25Xu/a+zFhm5K2N1kB9boAfhUAEpAicLLJZRNE10w4xM0RL2gsxThMLZ0/xW8HpF
	 xCJFZBIft5zMQ==
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
Subject: Re: [PATCH v4 06/19] liveupdate: Don't WARN if tracking a retrieved
 file fails
In-Reply-To: <20261111002358.1842967-7-dmatlack@google.com> (David Matlack's
	message of "Wed, 11 Nov 2026 00:23:44 +0000")
References: <20261111002358.1842967-1-dmatlack@google.com>
	<20261111002358.1842967-7-dmatlack@google.com>
Date: Fri, 20 Nov 2026 09:58:18 +0000
Message-ID: <2vxzik1r3jut.fsf@kernel.org>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11 2026, David Matlack wrote:

> Handle a failure to add a retrieved file to luo_preserved_files instead
> of triggering a WARN_ON(). Make the failure permanent, and keep the file
> until the file set is finished, like any other retrieved file. Only warn
> if the file is already tracked (-EBUSY), which would be a kernel bug,
> since a retrieved file is always a new file.
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

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

