Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF1606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZWppj1rm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTYBwt7b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=peaYebCEEiX4uS8IB8eF19W+t/RywQjsjJmZB55sdf0=; b=ZWppj1rmir/uTWR0EwneZoxpK1
	CRt+obZZkDxyCVEfRkGuU9M0Nf1VBSy1MxA+lkTery0zKHhc/k0xoFjmNC+zthcKQVv8GbOmImDm4
	QebcCj/aFNB8jOcXtVsZ32suRQhzIlOaxAAMNbvpygAPrBU8LYGsPNGinCbUJeyBFCdqwJMpbv7jy
	6nDX7Fhn0FTShT+H3FqACo/x1onY76nn1Vmq2B4fq5M6DDS8HokbstnmdvUzRIIhQYoAtco+WV36z
	bVtAeITIFl8JVOsCY6fJvIm/HYR6kXrA/MKg9kPrJbKiYWOmgdxf+Mhusg/Ol4Qm8iAEjMoo+G2hy
	Vfu0zUYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdTb-0000000Ajhw-10cS;
	Fri, 30 Oct 2026 03:40:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdTZ-0000000Ajh5-1j2o
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:40:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 291C441566;
	Fri, 30 Oct 2026 03:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F62B1F000C1;
	Fri, 30 Oct 2026 03:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331621;
	bh=peaYebCEEiX4uS8IB8eF19W+t/RywQjsjJmZB55sdf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nTYBwt7b3vUgNVzdyx/BtYblE/pNcdvXsg5KSqZrmQZ17llmBP5Pmqsiq7soiVkLc
	 oXkHzUwwhRDX7d1i3WuBtY7dqMfMPyxc+YtWN8OZy3X0wBd3H0lbgGfkp3u8lJiTHC
	 0bOhFgS8FZ7s7TpxyWrN20fc7J2FOTpu3RUUW+TfU2CdS6wM8Cvs3kw0fVz/IoIKcT
	 Cu3WrdEqjEBLQ2mLF2HlhmrYskx+aH2fG/f9yW53BY9xYy9XTxzhGax3O4fNq+Bx6F
	 n8nPDcOKhS5+ff6jTimteZe/9p7le/FyTfzCwvQ9VLemh6/NJFGYCAkJHyEF9+iSru
	 JJQwVlWCTofvw==
Message-ID: <sashiko-outbox-190231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/47] mm/memfd: check for real shmem inodes before
 accessing shmem state
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
In-Reply-To: <20261029-fixes_core-v2-3-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-3-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:40:17 +0000
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

> shmem_file() only checks a file's backing mapping. That mapping can belong
> to another file, as with a Coda file backed by a tmpfs container after
> mmap(). It does not establish that file_inode(file) is a shmem inode.
>=20
> Seal handling and memfd preservation use this check before accessing
> shmem inode state, so they can access an inode of the wrong type.
>=20
> Add file_inode_is_shmem() to check the inode's file operations in both
> paths. This identifies regular shmem inodes, including those used by
> memfds and ordinary tmpfs files, independently of wrapper file operations.
>=20
> Fixes: c49fcfcda8b5 ("mm/shmem: update file sealing comments and file che=
cking")
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D3


