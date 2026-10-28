Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A9606A321
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PaS9UFR6;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HaHjfyXg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Q5xA2wRJBQ07Qo768sQziuchQxKB2Cjd+x4z5GHdG10=; b=PaS9UFR613grMWm6eBiUPPksg+
	eE4PGyH/3hCZ+tTxvAYHTUIbmcejvRD5cKcSO7e3t9EgFvbj3PnSPmad48W15EjsPeZXGKxfHWaEl
	x3YsoGD22f6j0dcQ6Z2pyj2nbu+Z297yzVSHZNEhw8Xdv7KM1ar+TgoFvyQuYazHl3KKkt80H5dfQ
	qWyo9gaReuxhRr/g0Q3YB7jHRqLLe1BrJeEBVSKdfNSjFRQKhi3QVywcwzSbXBz+Ac/HlYNr6MrmE
	p2vTMySknCH917SGcwmb+PedQ20+U9yLDE4RWc6/Y3FFDuuRaFo7GvAKTGNa2Q0o6uEuuap4/fnYM
	mYVWfnRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMClk-000000083Lu-2y9P;
	Wed, 28 Oct 2026 23:09:20 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMCli-000000083LW-1SF6
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 23:09:19 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so921404a91.3
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 16:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793228957; x=1793833757; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q5xA2wRJBQ07Qo768sQziuchQxKB2Cjd+x4z5GHdG10=;
        b=HaHjfyXgpB+8psZTdHFbzqK7DvjrQdhd3vIN+L413VMNY/BeHwzIsUx6XOm8G8a+m9
         EQj5XPvD4qZvv3u7PooBkjiH+WXOPp1XYCEKY2XVCH8Z8zEl7TSDghFoqsNev/y11WVC
         AIhOYpCERj3NJ/Mv9eY5R3P6D4Lply+a6LJGluoGhvWxpi4pMZLkjXDbDDw8XwsFX9BM
         9OnAorTsmwHfDOaQoHYMbnSGooOf+TIwtFSmYPeMtK2GtjRobbsS+bXKbEOQJUDU96Rt
         XnOxEBJkpOaHIR/7DH0n9zLRFVS9AUg7LXUyRkDERTeJ4dk+xeUzMnPHjY2l8thuKget
         5wAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793228957; x=1793833757;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q5xA2wRJBQ07Qo768sQziuchQxKB2Cjd+x4z5GHdG10=;
        b=wd3xqGuY8hQTnShlCONXk8wNxtFKXfNGLPmwjRSRQmQe758zkHO6uJqZ5BfW32E5lW
         sCKOidBYUwclWkIc+zXp4WYgpaihi16esg3fauDuz386ePlT1k5R3T15XksXCqGzpoV+
         ltuVvWIoJCxWSwzUg5SjALD6ghSglzCR4mclc8wkMLj3981x2OpmY3NRdyaqDpFj+JQV
         lZkzDQdxOgLNpjVHdt05JcX5wKVCu0jGAjYa+9DdDicDCNR6Fys842L7IUMup9wmdoGP
         nHLd7ygteLN8T/U6ZcRkh9rCLadPvb6js51eJzQYd4TX8Ta+IBUYtI+7Pxjl3Yl++RJS
         IBng==
X-Gm-Message-State: AFq9FYLiNfNkwcmXFZM1Bsp+gAubZakbtZXGgXL8NeGLVFip1Hwlq4xD
	8ozX0LIG+pdIDc8GZZQ2gx/AnZby9ZeK+gVXQxgQacpgMmlxY6zBahjpD3nLFZQhCQ==
X-Gm-Gg: AYBFou0eITI6dsbqFzd93mybbBy3jR3ArSTM3UICEpx9CEt4hUM9rSo5PBqqvOnK5M1
	ylkC9WMJU+mATosg286bSwd0EtAklAF5ED7VmljFWY3bprQk9lOWDB4kGE4Wyq+UDfGWYJgLMBb
	2BBLKDQzyoN2n+d/FInzIdccieN7w7ehoTJcRztAzijvYtmFgLZxofaNLYf1w+x4OaCGhyhHOiY
	4S2EqfQk7H72eGQc3Vu7Y913p4oinzZuwpQkCtox6yYarzU6zem3jh+oGd7E8qvveKwP4gm11Vp
	h85kMzt2jekNQ+6vGzPoVPsGxAyuf/9RLulAXxw/YhIZxSh9FdPCYwtPEvwWvk/QfVb4skMIkuT
	cfpBF7MxiF7770Z0hV1vCwzPeIrNsPBtAsRkp3ih3rSBbgTwf/vZqaQTzMblMDf9nLBzztpwCYA
	PXONsvGpX6QA6OfdvEZG/KTLFgxVuibPiGxZeg8CybnDJJ8kHGMJFtbbn+kdlJSEba+bDV2SRx8
	2A/bfqF3dprvxxh5p10IKYhpY/WwoDx3rz0z1yNQG0kc7S+Mymz9nVHgi6YgFATzdXxf6mr7cLJ
	U8JfIq90AECEgqJXkny3HaEAsyU1KLA4fF2MrmO/O8QCyUsdJzHqhCgETijiSP/uPw==
X-Received: by 2002:a17:90a:ec8e:b0:3ac:8897:7b92 with SMTP id 98e67ed59e1d1-3ae58319f5amr2770048a91.57.1793228956133;
        Wed, 28 Oct 2026 16:09:16 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e973ac6sm1327770a91.11.2026.10.28.16.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 16:09:13 -0700 (PDT)
Date: Wed, 28 Oct 2026 23:09:09 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v2 07/10] mm/shmem_luo: Retrieve tmpfs files onto a tmpfs
 mount chosen by userspace
Message-ID: <auKAlcPN0Lt6Y3Wm@google.com>
References: <20261022225035.377445-1-dmatlack@google.com>
 <20261022225035.377445-8-dmatlack@google.com>
 <179322496574.1894369.544573858973645958.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179322496574.1894369.544573858973645958.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_160918_413487_11309378 
X-CRM114-Status: GOOD (  22.19  )
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

On 2026-10-28 06:02 PM, Pasha Tatashin wrote:

> > +/*
> > + * Whether @inode is on the internal shmem mount, which is used by
> > + * shmem_file_setup() and thus by memfd_create().
> > + */
> > +bool shmem_inode_on_internal_mount(const struct inode *inode)
> > +{
> > +	return inode->i_sb == shm_mnt->mnt_sb;
> > +}
> 
> Please fix the warning reported by kernel test robot.

Will do.

The prototype for shmem_inode_on_internal_mount() is in mm/internal.h,
which mm/shmem.c only includes if CONFIG_SHMEM=y, but the robot was
building without CONFIG_SHMEM. I've moved the definition of this
function into CONFIG_SHMEM in v3 to fix this.

> Looking at this together with Pratyush's mapping-freeze series ([PATCH
> 0/3] mm: allow freezing mappings), I think we should extend the mapping
> freeze lifecycle from preserve() -> retrieve() to preserve() ->
> finish().
>
> When retrieve() returns an fd, its mapping should still come out frozen
> and only become fully user-owned/mutable once a successful session
> finish() happens. That keeps the index -> folio mapping invariant across
> the entire live update until every fd in the session (e.g. vmfd,
> iommufd, vfiofd that depend on the memfd) has been retrieved, passed
> can_finish(), and been finalized together in finish().
>
> (Doesn't have to block this series, we can do it on top or as part of
> Pratyush's AS_FROZEN series.), but I think we must fix it either here or
> there.)

Ok that sounds reasonable. Should we do that as part of Pratyush's
series then?

Pratyuh's series replaces shmem_freeze() with mapping_set_frozen(), so
retrieve() would freeze the new file and finish() would unfreeze it.
That should work the same for memfds and tmpfs files..

BTW, this tmpfs series does a lot of renames and code motion so it
conflicts with Pratyush's series. How should we order these?

