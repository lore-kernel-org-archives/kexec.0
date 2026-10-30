Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804C606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iZT1DzHM;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWAH9XrR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8vt3r0dV4H78MyX5tyofuPfjl2FfIwvVkisCW8E4akc=; b=iZT1DzHMev5d6yRMbd9uliuKud
	EqCdxlXhyJ/HBZWPHSXzfKmbuaaFJ+Tbd27VXxsFXFUvy8s0PwCzwKKRjHxxYfz7Z7UwqsJxxYO+o
	8AMRyAQGgLcf9Kh5IMORea065v/SckCkMgvR+lRc1vXEokPJ2JKueeLMuSLMF6IxG5BGhj+tns7LW
	Kn/pMVoIE/cHAB/rzdtfBL6wQRkqgCDrFqTcN/25EL3s+uLwBmdG4KEeLak5/xuBBCOKXs+f+NftE
	qmxp68K4WrVF6gbF1/Zj63DhVcdrSzk8CXPvIieTISNUxTY1szwIqX928wjD015o9ydGQuEkIk5yQ
	w1vViagQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdVJ-0000000AktV-1cjd;
	Fri, 30 Oct 2026 03:42:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdVI-0000000AksZ-1qWF
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:42:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DA112600DA;
	Fri, 30 Oct 2026 03:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087E21F000C1;
	Fri, 30 Oct 2026 03:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331727;
	bh=8vt3r0dV4H78MyX5tyofuPfjl2FfIwvVkisCW8E4akc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FWAH9XrRqNGdlVz48bcrq1+V5ulr2ptkvsIlZv5tR/SewdcA21FsGI0sfWCkvVI3w
	 vlZOqqLr+j9nIeY+r0UDa3P2h7Q8UiJbj4R49KdyHvM8I8t5Bx8eIxo60ZNwaiXqFx
	 Y3iBdeEohDmXI2JWsVCBX5AAC9biHBcL6LasvitQ7iZjN8Nhic1aDM46tk/4kVj0cI
	 CFtbDbBIvz1de83W7IN6d+cT8ZDpS2FoXR0BjGFTOljQaxJMsf3nd40jpRiWL6JvJC
	 rLwhFuy3EFpWb6KcaqEEIbuaDvsVdFJMGeAliDDa+yJCUdrw/xyg+N6MupITSmvtuj
	 HPuLFoQNb0ivg==
Message-ID: <sashiko-outbox-190263@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 35/47] mm/memory: reject remote COW faults on PFN
 mappings
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Johannes Weiner" <hannes@cmpxchg.org>, "Michal
 Hocko" <mhocko@kernel.org>, "Qi Zheng" <qi.zheng@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Barry Song" <baohua@kernel.org>, "Axel
 Rasmussen" <axelrasmussen@google.com>, "Yuanchu Xie" <yuanchu@google.com>, "Wei
 Xu" <weixugc@google.com>, "Baoquan He" <baoquan.he@linux.dev>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Kees Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Jann
 Horn" <jannh@google.com>, "Pedro Falcato" <pfalcato@suse.de>, "Hugh Dickins" <hughd@google.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 =?utf-8?b?TWF0dGhldyBXaWxjb3ggKE9yYWNsZSk=?= <willy@infradead.org>, "Jan
 Kara" <jack@suse.cz>, "Zi Yan" <ziy@nvidia.com>, "Lance Yang" <lance.yang@linux.dev>, "Rik
 van Riel" <riel@surriel.com>, "Harry Yoo" <harry@kernel.org>, "Alistair
 Popple" <apopple@nvidia.com>, "Nico Pache" <nico.pache@linux.dev>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl
 Shutsemau" <kas@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>, "John
 Hubbard" <jhubbard@nvidia.com>, "Peter Xu" <peterx@redhat.com>, "Will
 Deacon" <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Nick
 Piggin" <npiggin@gmail.com>, "Oscar Salvador" <osalvador@suse.de>, "Minchan
 Kim" <minchan@kernel.org>, "Muchun Song" <muchun.song@linux.dev>, "Xu Xin" <xu.xin@linux.dev>, "Chengming
 Zhou" <chengming.zhou@linux.dev>, "Chris Li" <chrisl@kernel.org>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Nhat Pham" <nphamcs@gmail.com>, "Youngjun
 Park" <youngjun.park@lge.com>, "Gregory Price" <gourry@gourry.net>, "Joshua
 Hahn" <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Ying
 Huang" <ying.huang@linux.alibaba.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: kexec@lists.infradead.org, "Chris Mason" <mason@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-35-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-35-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:42:04 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> From: Chris Mason <mason@kernel.org>
>=20
> When handling a COW fault without a normal source page (PFN mappings),
> __wp_page_copy_user() copies from the faulting user address. For remote
> faults, this accesses the wrong address space, resulting in wrong data
> getting copied.
>=20
> For example, user_events updates an enable bit in the registering
> process's memory. If that memory needs to be faulted in,
> user_event_enabler_fault_fixup() calls fixup_user_fault() from a work
> item. Placing the enable bit in a private PFN mapping can trigger this
> remote COW path.
>=20
> Reject these faults with VM_FAULT_SIGBUS when the target mm differs from
> current->mm: remote faults. Ordinary (non-PFN) mappings are not affected.
>=20
> The user-address copy dates back to commit 6aab341e0a28 ("mm: re-architect
> the VM_UNPAGED logic"); likely, actual ways to get remote faults in
> there on COW PFN mappings appeared afterwards. But the fix is simple and
> straight forward.
>=20
> Fix generated by an LLM and sent by Chris Mason in private.
>=20
> Fixes: 6aab341e0a28 ("mm: re-architect the VM_UNPAGED logic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: simplify comment and description ]
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D35


