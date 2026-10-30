Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F06D606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b4Hor+Lq;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itx+Xv1t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tpeknwVNJmP/bKKG+fXm/2Q3N6ESvrFSEq0ZVqkxjXo=; b=b4Hor+LqSTATu3yVSck3PYitMY
	hqVbjxgbCVNrfpPIwhGBhaHCrH/hXQvbBjxWWBxJEFUufn7EniKV8bH6NvcgtRlUrZMkmERNOZnvO
	U5XmmnWlsC/Ybb7Drbxrc5VUZpwjmOxvJqE88wEuAdHa3ELmlmQmUgbSoy9Up0x/pCAF724Qmw1Fb
	0EcdF8DmG5/xs/duKW1AjLDlY5zXE4poW1WkqjkiB7ygRsraygb/TDdNVc7n3ZP8nI5PLGrb8LBYq
	E5ABrx7SLJvSyo0JGnqfzZMWNQex9h/5dwf45QHMfah3haL6HgYbtyX8nHNVtl/QZS0qfZHTtfI7S
	fqZJUrtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdVj-0000000AlFt-3fep;
	Fri, 30 Oct 2026 03:42:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdVi-0000000AlEJ-13AF
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:42:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 026E640444;
	Fri, 30 Oct 2026 03:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35851F00A02;
	Fri, 30 Oct 2026 03:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331753;
	bh=tpeknwVNJmP/bKKG+fXm/2Q3N6ESvrFSEq0ZVqkxjXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=itx+Xv1tuOl2fS/x35e04kS2m3+RtcQGcYRf7iqwkM/rWJ9UsF7NqLdUzbGiFAUib
	 dF5Ut7kniw77qXpLAD/xtefZwBopd1sTzFMt7kneV9JwdVrZYL3djKRegvXcFkB/Qz
	 Pe19hqDgtWewUWdj3/7u9y/DYSS5j/ebdQrcwIQG04PcL78p1HWtFEqo1BirKJz2+B
	 FCKNuf1ONrByNQAV0nFlatf1IK3j9OfEy/6xL9xC+A8KU8rYiCr8oENRKafhjLTtno
	 Z1e+LAST9fDkMFW7fw6kQ5HqX5NS9ABi7fxmFIAk/clpV0Rs83EXW/MFzo49mXAlmL
	 6cHykGwT5hnGg==
Message-ID: <sashiko-outbox-190271@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 43/47] mm/huge_memory: split huge PUDs when adjusting
 VMA boundaries
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
Cc: kexec@lists.infradead.org
In-Reply-To: <20261029-fixes_core-v2-43-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-43-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:42:30 +0000
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

> PFN mappings such as VFIO PCI BAR mappings can use PUD leaves while
> allowing VMA splits at page granularity. However, vma_adjust_trans_huge()
> only handles PMDs.
>=20
> After faulting a writable PUD-sized VFIO BAR mapping, changing its first
> page to read-only with mprotect() makes the PMD walk treat the PUD leaf
> as a PMD table. Applying MADV_DONTFORK to the first PMD-sized chunk leaves
> the PUD spanning two VMAs: the PMD-aligned boundary skips splitting.
>=20
> Walk the page tables once at each adjusted boundary and split a huge
> PUD or PMD leaf as needed. Handle PUD leaves even when the boundary is
> PMD-aligned.
>=20
> Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D43


