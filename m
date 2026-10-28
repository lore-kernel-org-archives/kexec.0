Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F9606A31C
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l0vqsjTd;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KHEUPAxB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=puyAoc6Jf4frehbhlLXQIfKglUE1ElIfqgej2JSgVAA=; b=l0vqsjTdiemE5PZOdYgHXYhOxl
	rhTS1TN73NaW/CxcAaE6vwsgSkG16acdzSxX6lxGKqAsBTDaf4ltge5tvDmGumiO1DmKoHf2j/DU0
	xUEbaxf5Wi6qJaHdeKelm8hjkPb+F89wmy9k1ijGwYB7ukMGpudL+0l7931aB7VktoeBaGyEqizwk
	R+LkVMk+rdKCoFmA6+Ujl1pIkP2J5MRDdlSyOBWKuP3MJrt/+XYLeGJayn3zXNQCkmtvXD3NLmre8
	K0dfk27GW/I79cDFz0QvxqQv15V7RwV9/MB7+FUsqBWoc2loDEg0++MD17f0hzZPOEe9v7uDJEOWM
	CIlRsQfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMCqN-000000083Tq-1qFJ;
	Wed, 28 Oct 2026 23:14:07 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMCqL-000000083TW-0TOp
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 23:14:06 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-8a60f90a924so697993b3a.3
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 16:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793229243; x=1793834043; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=puyAoc6Jf4frehbhlLXQIfKglUE1ElIfqgej2JSgVAA=;
        b=KHEUPAxBt2Du8BFnG9yArpgMF9/I74vIUHhowZJ1Lsh8jPgBgn51jGDGU35p3Jjuxh
         iwmCLwxvubx/zQELhGi04rGeHaNgO45MuMjiK0PTD8AuZWpCsdxzV/DDtARjTkB30p6c
         Vu7o5AM7SGbzVyLtIkVcpVfq06zAVoKV8PRR/e2paSsv14ncOcNTpJk0TFIaMxrkGS/9
         lAnMiHvMfRBSgO4no/OTZvkPAcJ+nc3oR8dXJfQyQqX38ZRRsDHplkaYEedeMc+F5sRy
         IIS9Ry77Yf08D6JA2q2UeQqJtyqBgbxnSi/zFUysjFRrDfTHuCzK3aQfZmBubPf4zHTs
         V5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793229243; x=1793834043;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=puyAoc6Jf4frehbhlLXQIfKglUE1ElIfqgej2JSgVAA=;
        b=CFxcxZaFaJB0nvw+vXWWsP9TcRBXc1pRYZWqPrDLKb3mvVrWJ87HZnqP6gGPEwJ9jT
         eii8nrGTRdYLrKQihABa5dTJETXU2wO4CeHHYdkHN20kJJwMOIAVb8FxQiAo/Bw1JOf5
         A8BMiTogjq9xb+f36uPSB6ngbTtF6cddbsnQGRAoitipGzcxxPgFeGwlDK0OZYqHfxw1
         oOM4dlZA8PnV1OVyqDLGxJC2ns0nucWihMZdfZ1YF2G4ZLNuzjVZFccvu9KUeyluV/7d
         9LMMkvpF5oTxQdYGpXQ7YBJF/811RVhN/MrQnRDJAS9bvuyDQPsTXIyNBa4iyYo4n9jF
         hddQ==
X-Gm-Message-State: AFq9FYLrDjAaYWErp/Jxgj4xYXARqUVwWKxF18M3npk5ZowgDOYMhz3X
	n1F9RgIkxjBCfV6fcit1brcr3iccvLwmiaM4VnbdF3r1wbijGRuWbd03sG8ZQ5/zoQ==
X-Gm-Gg: AYBFou1luCrLdVBj4oYuvLUgoFVdW6WOE4m1HMQPlxf9pi1RZRHm4EWJV8//c7C8Kol
	x+gItpK2AL7jhPv/IX6dJviGtR0YqUrE2S/Iy4s8HwFgAFI6Jy3cD340ClRkLBDV3ZB3ArUkEWc
	Jw6o5o7GkEPWwMdlOli4RtbIb6NL0dI74kbi9Mal7zZa9ja0xjjc5SuPk67HlPiXxAjhJ51A5Gs
	IFzYzDuepRPQrczpEGLsKR5zYTCWEHypyKVF1uvVAMqtKCKUEBMBv9PSIvMBrCAeaz6qN2Lh80P
	XUEZhrjCvC2MljPu7ksoFMdt5zP8721ZhaSH1ebhkIOCPTncnPPZsHNHJ/D/4qWm6EVnfiuAgQu
	O32T/EiA9qUuvNNP/9zVDARZTwDnVT69YIcIQ7UXkZIMke3TrmA1ZvD/rBXMDzgekLKu/yAVIgl
	16N/HFXwv/zskXW4Fkx9VCymfEQqTBG6TLgWI13sEypvTTdTn/srhcCNhezeIkzlGDBejFX0dtd
	LOdu52AN+Fziof7ZoyS0a0CpRTLFIgyNgMOpXkjnpdSiCNui7XiXhQIrZMu8zkmtb/A6IHnql+9
	YZU1q9ETKbYj3HqBDj90bf+XP9/5shkaMUo9ecbw8exny8dFmETkwbCoGVuX9kltJ8AlQK8oZEG
	iZBSedCdsanrIwZY/
X-Received: by 2002:a05:6a20:914c:b0:3d3:af85:eb98 with SMTP id adf61e73a8af0-3e9022d6cbemr3267144637.26.1793229242275;
        Wed, 28 Oct 2026 16:14:02 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a6cfa342sm1626775b3a.41.2026.10.28.16.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 16:14:01 -0700 (PDT)
Date: Wed, 28 Oct 2026 23:13:57 +0000
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
Subject: Re: [PATCH v2 09/10] mm/shmem_luo: Allow retrieving tmpfs files with
 O_RDONLY
Message-ID: <auKBtVmCS4jU8e_R@google.com>
References: <20261022225035.377445-1-dmatlack@google.com>
 <20261022225035.377445-10-dmatlack@google.com>
 <sashiko-outbox-183328@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-183328@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_161405_155520_59614379 
X-CRM114-Status: GOOD (  13.52  )
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

> > +	ro_file = dentry_open(&file->f_path, flags, current_cred());
> > +	fput(file);
> > +	return ro_file;
> >  }
> >  
> >  static int shmem_luo_retrieve(struct liveupdate_file_op_args *args)
> 
> [Severity: Medium]
> When userspace retrieves a tmpfs file via LIVEUPDATE_SESSION_RETRIEVE_FD with
> O_RDONLY in arg->flags, does passing the raw flags variable to dentry_open()
> in shmem_luo_create_tmpfs_file() in mm/shmem_luo.c bypass the flag
> normalization performed by file_open_root() -> build_open_flags()?
> 
> In fs/open.c, build_open_flags() strips O_CLOEXEC and ensures O_DSYNC is set
> when __O_SYNC is present:
> 
>     u64 flags = how->flags;
>     u64 strip = O_CLOEXEC;
>     ...
>     flags &= ~strip;
>     ...
>     if (flags & __O_SYNC)
>         flags |= O_DSYNC;
> 
> Because dentry_open() -> alloc_empty_file() -> init_file() initializes
> ro_file->f_flags directly from the passed flags and do_dentry_open() only
> clears:
> 
>     f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | __O_REGULAR);
>     f->f_iocb_flags = iocb_flags(f);
> 
> passing O_RDONLY | O_CLOEXEC in arg->flags leaves O_CLOEXEC in
> ro_file->f_flags (visible via fcntl(fd, F_GETFL) and /proc/<pid>/fdinfo/<fd>),
> and passing O_RDONLY | __O_SYNC without O_DSYNC leaves O_DSYNC and IOCB_DSYNC
> unset on ro_file.
> 
> Should dentry_open() be passed (file->f_flags & ~O_ACCMODE) | O_RDONLY instead
> of flags so that ro_file uses the normalized flags from file?

Yes. I will fix this in v3 to re-open the read-only file with the flags
that file_open_root() already normalized.

