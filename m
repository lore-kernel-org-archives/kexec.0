Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7C9607F96E
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RA9Eh0iO;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=glRMY9+y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gHsVZIyLB4LY6jVwLQ9hDHHfJ9C6/ccEH9xuZg5C7+0=; b=RA9Eh0iOQHcZBN+VRTrx1Xsn4E
	MzgzXY9NlW+rPaE8m5XqOqe4/xyBIkvX/QvzWOhpbfZR2N07gzPN5YZkiNOc5p2baUyrzTvGuL6Tt
	y++vTAi98vuoLF8jM2bDyPMM2OyGE7GgcjRDrL6GAfBF1uZMfp1+YvHRHrzjgu2ODGMJ94Q1KtRHk
	gdewr4aTOG/jC7YJ+1FJkF8/NST4bcybJjEuNxSzR+j+y5UFtpPIAZQaicHuQRyDVxUibrXyRnBxF
	PcoXBs/2vxy9qNihf4NPe4q9rL1SguO4gqrwG8UoOPHOA7P+FLnLyJL3f6ByfNa57YGBvoUNUej9U
	T1btNt4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgo9-00000006gqR-1gGp;
	Wed, 04 Nov 2026 19:38:05 +0000
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgo6-00000006gou-3LpN
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 19:38:04 +0000
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-5eafa528803so388828e0c.1
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 11:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793821081; x=1794425881; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gHsVZIyLB4LY6jVwLQ9hDHHfJ9C6/ccEH9xuZg5C7+0=;
        b=glRMY9+yRfsiDU/O45o5nazpKgdZYLyEYf9Fr7cWxCzQmsroPW7TKK5bWnT/uEp4Oq
         QdkZA5Az1en3EfmQFOD+OLJubmileyyzlnbpBzrbE1XCr9Janyp+yJIYXRP1TY9XCyyY
         i7UEnTHBXUJQ7HrX89dBGslpsWQDQZUfEk24ZLGjpS3XxUDTCx8KsYsK8HlEelgUU8DT
         e0eTdfqBOm4eVUskmfdjoqFGjTlRbXYyZyCd/yNIZN0HEXpWPNs4BU2hbuRI5HbN08FW
         AgF/kYe8R0ppLCIndiNW9VPpRQopEALo6bEJrg1X5UXmMNkOPEEDOD1ZMtNttH82Ex5Y
         WyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821081; x=1794425881;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHsVZIyLB4LY6jVwLQ9hDHHfJ9C6/ccEH9xuZg5C7+0=;
        b=dYWvgca68jDk07V1G/XGvCjoCB1UwcxQu/neZvX6XHeU3ED/M1a0REzVDxrPIaHlbe
         NGJ0PEbx2OpRS0vs9xu9/ROhNca4AL/cSU5Sw4+LTeunhoDt4uEKCDm8YRABornPYFth
         PwxAdGTk3e00uMP3fEDH3X73/wdkRvQO209QXbZIk8SYs3m9UVDrjUfHTR01cOCKoeXb
         Cc+3fSmw3+RKMDzTyQIlvbNFizWr/AjZsRwzr7nmayZSzSLUitraZMjwTXEBH/EaW9Jv
         o//UoLUk95wuUOa/sMKdBd6RZoeHIWgxOOpZarHKA4XR965WF42pY6Q0q6oqdubRt2a4
         Ficw==
X-Forwarded-Encrypted: i=1; AKwUvBxJFyZlSGIywf5RBgWrA5QNW6rvP+B4k1jadnJ4OUExKLz/6JYUosU96Eo17CkYualgYBRQ4g==@lists.infradead.org
X-Gm-Message-State: APuU4Z/Cj6J7ObzGG9iVxLfiw2LYnnO05duPAqO/gdkoPfC/eEXcXGkd
	FVkTGpmiwyVsKpLgUJvRD3HLQY5dIrB3bLZeJoqkfqVjsqNyp3O5mwGPr0QYvUAf17A=
X-Gm-Gg: AYBFou2qGPx2dVdOBSB4te4PN7v5CpjHMKY/cYj8skMH55sGKPk9u/X5XLkw5YV/AET
	o9nA8ykjdsx5mL2PKPxT9NEkZlkaMgV3EFZki6VeiFHfCwFFNaT+/3UcQU6Sogb91RN//6ABCT1
	3picfBqlz+CBei54jy1VhJtdrmapp8phqqMtd+bVTTl+biGKIt/vU2IIKQ5GBEoLBdhYfRxj4eP
	npLeyVqU3FP4NV+TEsYaqWgGHXXrnZ/7GyDU5MjqvoBvoMW4XTz2xKYR5N6E6G3kQiqslK9CaGZ
	h482OcpH86k/Lj8QHVG6lHMWeKH0IWjlwp6joHvZM+QEkcEV6+NQY8YIPo/Beq9zusqQnrZHup6
	zp/S3ZpQHOgPYJIvE8nG/QGTusG5Feg1+U+CGfdHGJgGjHpDueGBdzAlUz0YO9po96OVSoAA4F+
	CV2nvQu79XGOTiQqUmy9Qr7aKQH0J2n2Dw5kVCpiw0wwUWNqLdM86iSvOPLdHd5pdQHQiBPqKWd
	mLqqBIK5W8YaSB/NxHdezODofKmYNDAQTk37clx4nfVIldNATsSUg0+1/B9vWXhuMvgy7V4cTTw
	SNXDDCGOvTffVIbMIy4QsMNdqVPZodQSlzw1VHw8coBvhES+A7cfzfgy0uAgB8AFDXQ7wOb5IWu
	Ao8ti5bVD+RH5c6jYVVbl+oJSyKRzpj+b+p+Na/2tm8K/B5GZvw==
X-Received: by 2002:a05:6102:6b0b:b0:7d0:3ed0:c61c with SMTP id ada2fe7eead31-7d0726a9cd7mr6446000137.16.1793821080773;
        Wed, 04 Nov 2026 11:38:00 -0800 (PST)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d2a3asm2569956241.8.2026.11.04.11.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:38:00 -0800 (PST)
Date: Wed, 4 Nov 2026 14:37:59 -0500
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 10/10] selftests/liveupdate: Add a test for preserving
 tmpfs files
Message-ID: <auuJM8c-bE43NP54@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-11-dmatlack@google.com>
 <2vxz1p90jzx4.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz1p90jzx4.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_113803_001805_34D8221B 
X-CRM114-Status: GOOD (  38.36  )
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

On 11-04 17:59, Pratyush Yadav wrote:
> On Tue, Nov 03 2026, David Matlack wrote:
> 
> > Add luo_tmpfs, a kexec test for preserving tmpfs files and memfds, and
> > for retrieving tmpfs files onto a tmpfs mount with struct
> > liveupdate_shmem_retrieve_arg.
> >
> > Stage 1 preserves the source files of each test case. Stage 2 runs
> > each test case in its own directory, with its own tmpfs mounts, so that
> > block usage can be checked exactly with statfs() and st_blocks. The test
> > cases cover:
> >
> >  - The restored file: contents, size, position, seals and holes, for
> >    linked and unlinked source files.
> >
> >  - Creating the file: it is created like with open(O_TMPFILE), with the
> >    requested mode minus the umask, owned by the caller, and not linked
> >    until userspace links it, unless it asked for O_EXCL. Also O_RDONLY
> >    and O_WRONLY files, other open() flags such as O_APPEND, O_NONBLOCK
> >    and O_CLOEXEC, read-only mounts, and directories that the caller
> >    can't write to.
> >
> >  - Preserving files that can't be written to: a binary while it is
> >    executed, through a read-only fd, files on read-only mounts and
> >    superblocks, and immutable files, including sparse ones, whose holes
> >    are filled. Preserving someone else's file that the caller can't
> >    write to fails, and so does preserving a file through a write-only
> >    fd or an append-only file.
> >
> >  - Executing restored binaries: a restored binary can be executed
> >    before the session is finished if it was retrieved with O_RDONLY, but
> >    not if it was retrieved for writing, since LUO keeps the file open
> >    until then. These test cases execute copies of the test binary.
> >
> >  - Block accounting: the file fits a mount of exactly its size, and a
> >    large folio that extends past the end of the file is charged in full.
> >    Running out of space, or hitting the memcg limit, fails permanently,
> >    and leaves nothing charged to the mount or the memcg. The session can
> >    still be finished.
> >
> >  - memfds: they are only retrieved as memfds, with their seals, and
> >    files from tmpfs mounts only onto a tmpfs mount.
> >
> >  - Interactions with LUO: invalid arguments, which can be retried,
> >    retrieving a token twice, and outgoing sessions.
> >
> > Also check that the size of a preserved file is frozen, and that the
> > test doesn't trigger kernel warnings.
> >
> > Enable CONFIG_TRANSPARENT_HUGEPAGE for the large folio test cases,
> > CONFIG_MEMCG for the memcg test case and CONFIG_TMPFS_XATTR for
> > FS_IOC_SETFLAGS. Those test cases are skipped without them.
> >
> > tmpfs quotas are not tested, since the test runs as root, which is not
> > subject to quota limits.
> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  tools/testing/selftests/liveupdate/Makefile   |    1 +
> >  tools/testing/selftests/liveupdate/config     |    4 +
> >  .../testing/selftests/liveupdate/luo_tmpfs.c  | 2055 +++++++++++++++++
> 
> Umm, no way I am reading all this...
> 
> LLMs are great at generating tests, and I'm not saying there is no value
> in this. It is just that this massive code dump is unreviewable by
> humans. It is also unfair to the human reviewer because it took many
> orders of magnitude less effort to _write_ them with an LLM.
> 
> What do you all reckon we should do about this? Trust the LLM to get the
> testing right? Do we give up human maintenance of tests entirely? Do we
> do fault injection to test the tests themselves?
> 
> Or do we make the tests smaller and more human reviewable?

We need good test coverage, but I believe we can break this patch down 
into smaller changes where tested features are incrementally added.

> 
> >  .../selftests/liveupdate/run-vmtests.sh       |    1 +
> >  4 files changed, 2061 insertions(+)
> >  create mode 100644 tools/testing/selftests/liveupdate/luo_tmpfs.c
> >
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Pasha

