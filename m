Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620E606A31C
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 23:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=B3/42AbD;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Hx507ke+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ErACdD6wnsCj5BI4BkkTwpFvg1ap5ibaSYHTkZSlAoQ=; b=B3/42AbDINeIwkjed0Ka341C+G
	px90foojcxuQA22pZcCoNYzsqHvuHa9EjmMHfmUpetu+ECNsyZ3Mkd8Omw5SwK656hrM5z1fgrvBq
	RoVAM39fxusCmdyzC1wQMGQlDpBGixvG620Z/9DkQ9r9RtXI+sLdAODbsnA2TIZ6EUfet1f6cm9Dt
	J4RU9omXXO8jp8EPQnR5dvpuQCtvIcxsXUIuf9yxKF7zYUTxJAabSDyf6g7PR+khhDDpFslQyUvB+
	lAHuq8oCEo3K9ZOT83V0TBblmsaiLFIwfhzQejJAb+6BvWBWlGz9R1+0l4AxDfOkQBT7bNADeIY2X
	MpgMqBfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMCyP-000000083gD-2BAk;
	Wed, 28 Oct 2026 23:22:25 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMCyM-000000083fr-0yNQ
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 23:22:23 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso727060a12.2
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 16:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793229741; x=1793834541; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ErACdD6wnsCj5BI4BkkTwpFvg1ap5ibaSYHTkZSlAoQ=;
        b=Hx507ke+ey3em8fp0tqJlavRYj+vpU6pyMvuhtuh5su0txskJL3+j7/zTWNu2QmuNK
         rSZ47sJpg+wuiSUMaoJrrvXmnWY8cnAbRooKtIc8WwwOnlKxCVa2JzwZ0T551AK/yvbs
         kQdk25SiZ2lnCdQ+mfKkzDSeEvHj0Q2D+xR+EeF/cMI1jZrfmeIPLt4MFCy00W3E28DW
         +C3qjIgShtFdPGiLc0yskYcepJhy1ICrptdQ9s7vIcbtlLgn1KI5JMlo0OZzxFnxGn6D
         4tTL/UF3qegeCQUwYRGv/sGlyhqwu1D+S9URp0DzXxHZHPyR473pVNi3wvw2ct2fvEr4
         MY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793229741; x=1793834541;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ErACdD6wnsCj5BI4BkkTwpFvg1ap5ibaSYHTkZSlAoQ=;
        b=j7NdJsjeypJljhbLEyf4v/47cmqvBmg/w7MC3Sy1fxvosKqlRZ0dwGG8sBihHgg+Bo
         jLNVEK6U+GWyrksD+zdWmZ5Z09Nreng4xhkR/Q3xiRPlw8HDYvdlOkDmzF7pwQI/wpeT
         M0Lv5srlaJ8dVQGeta01jrhTBCyiHEVZh1GjHB0MXTkSElE3npzgRqOcMh4LRDtJeePQ
         OL5L7SGpTTQ1fMjIzKSWoyL61E/+6+V2v9qm8qHbyrJ4ocm+UaHWGHR6uuWh6P7nGVge
         VL31gmmuBOgb3rEem/2uswi6YgI6q3MjvMaHxzXgs1lH1w4GL6GwWU7xfRAqamC3GcmC
         9RYw==
X-Gm-Message-State: AFq9FYJg4FI+jupWYCUhkRU13SlFRuyrnGGmmB9yjN8ghZh1hazrnbGZ
	0OisQvBP5GPa8za3TiGvWzgFpq3sqFsfheOviZ5W7Rdqm0V6PHGAnEptAhy6BOhJPg==
X-Gm-Gg: AYBFou36vwptH0AzFLhUVTIi+7QB0+Dm0awwuw9dBeU+V6MqTj0LcY8AMUByUQPVlDq
	SiF1cMnGbUhLse9ZiS0B40IDXXD3UILdJy0tTs7zoH/VoZT9EYxsTbodEIkHKZi9wckim3Dq2h9
	t1P/ACj3ykRlp7cAkp+WUoESFVCDVAHpzlPdHewEtDAYiyBoUJUau84fA1R8OkuTVW1PCxFRMoH
	z4DZo0mGHD4lqC04ct8J6HDQul9PPwjC4bka9XMmRQOicZsU14+rhoqgh2RDksIQggfCehrMbJz
	cijocNnap4dlWiQs+24+GRwbIQHlyriHoppLw5NtssaxPUtH4V5XBwQrLFNIzHhsGwqnlFOu/jc
	lwP8h1cSp0CVzUVZVXZcKuq2NUpHaWlSahLOZ+B2JQs0ExC0mIC1BnnYuW7B0iMVInnm7pVpzog
	DJHNU+p+BczOwMiIfVhozpoFSZDjJk8s8GCymiZTt4SWRYiVSoNCSAof7gTUFEY+V+9C8M1tt3B
	46avPJq6pEZHXmX8ZIwCL1MwMi1oInxCfgUEOer4eSKjWFg9AVQXyFtPvP4utFRvSLKkl7uuUwM
	29PqapWPXT2v+00AAxj0ygpwFKMvDlZyQrorsyMzT/V1nS5OPqHIzX8/XBHLf7YfSwGW2aGT
X-Received: by 2002:a17:90b:1b0f:b0:3a4:967c:6947 with SMTP id 98e67ed59e1d1-3ae580cb98emr2772733a91.21.1793229740129;
        Wed, 28 Oct 2026 16:22:20 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae57a56a1dsm2552085a91.4.2026.10.28.16.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 16:22:19 -0700 (PDT)
Date: Wed, 28 Oct 2026 23:22:15 +0000
From: David Matlack <dmatlack@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kexec@lists.infradead.org, linux-mm@kvack.org,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v2 08/10] mm/shmem_luo: Allow preserving tmpfs files that
 are still linked
Message-ID: <auKDp6MfztVCIzp2@google.com>
References: <20261022225035.377445-1-dmatlack@google.com>
 <20261022225035.377445-9-dmatlack@google.com>
 <sashiko-outbox-183327@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-183327@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_162222_299218_2550592C 
X-CRM114-Status: GOOD (  22.89  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-23 10:51 PM, sashiko-bot@kernel.org wrote:

> > +static int shmem_luo_may_preserve(struct file *file)
> > +{
> > +	struct mnt_idmap *idmap = file_mnt_idmap(file);
> > +	struct inode *inode = file_inode(file);
> > +	int err;
> > +
> > +	err = inode_permission(idmap, inode, MAY_WRITE);
> 
> [Severity: High]
> Should shmem_luo_may_preserve() in mm/shmem_luo.c also verify that the file
> is open for reading (file->f_mode & FMODE_READ) or that the caller has
> MAY_READ permission?

> Wouldn't that allow a caller with only write access to read the file's
> contents after retrieval?

Yes. I will fix this in v3 to require the file is open for reading and
update the selftest to cover this scenario.

> > +	if (err && (sb_rdonly(inode->i_sb) || IS_IMMUTABLE(inode)) &&
> > +	    inode_owner_or_capable(idmap, inode))
> > +		return 0;
> > +
> > +	return err;
> > +}
> 
> [Severity: Medium]
> What happens if shmem_luo_may_preserve() in mm/shmem_luo.c is called on an
> append-only (S_APPEND) tmpfs inode?
> 
> Tmpfs supports setting S_APPEND via FS_IOC_SETFLAGS in
> shmem_fileattr_set() -> shmem_set_inode_flags() in mm/shmem.c:
> 
>     if (fsflags & FS_APPEND_FL)
>         i_flags |= S_APPEND;
> 
> Unlike IS_IMMUTABLE(inode), inode_permission(idmap, inode, MAY_WRITE) does
> not reject S_APPEND inodes. In fs/verity/enable.c, fsverity_ioctl_enable()
> explicitly checks IS_APPEND(inode) after checking MAY_WRITE:
> 
>     if (IS_APPEND(inode))
>         return -EPERM;
> 
> When a caller with MAY_WRITE permission on an S_APPEND tmpfs file preserves
> it via LIVEUPDATE_SESSION_PRESERVE_FD -> luo_preserve_file() ->
> shmem_luo_preserve(), shmem_freeze(inode, true) sets SHMEM_F_MAPPING_FROZEN.
> Because all writes to an S_APPEND file extend past i_size,
> shmem_write_begin() and shmem_fallocate() in mm/shmem.c will then fail with
> -EPERM:
> 
>     if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
>                  pos + len > inode->i_size))
>         return -EPERM;
> 
> Should shmem_luo_may_preserve() also reject IS_APPEND(inode) with -EPERM so
> an append-only writer cannot freeze the file and block future appends by all
> users?

I am not sure on this one, but rejecting S_APPEND inodes for now does
seem like a reasonable place to start.

A writer of an append-only file can only add data. It can't destroy
existing data or stop others from adding more. preserve() blocks all
future appends, so arguably it could be abused.

I will update v3 to reject S_APPEND inodes. If someone has a use-case in
the future for preserving such files we can revisit this and look at how
to support them.

