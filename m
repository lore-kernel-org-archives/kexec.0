Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C478606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VSIpLxAB;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ka7UXsQh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IIJ6xEqRSmc3P/njmK7rvcrkOwirvqwv8tVhsJQABX4=; b=VSIpLxABTccO69LFPxCpfmf3Jy
	H549001I4zLAnpVj7981fqVLezc9ppHGSYGsivxkkdA4B6Xcwn3VA6B6oKCBgTnBal/TjJRH4zWhV
	5og+zWcLqQJMhhiI0+FjccS89LBIuFcr7MAmHK9vn8X2Fzg5bGNVV9ux7e5sOxyAAFGBmf0Cc+0Ec
	ZHKEqaRPB25rCVLPAMXc/ogvcid2VInacqfoRtQvImZyIIPUEB14C60G34CXvZ2WlWoWfV9HWrmKn
	a/bhd69nda45YwWkAuNvya/vdjaM5tAP3G9+o+YrxubkFFZr4tcbr8CVpsCgD5WiuZGTnd4mPOcuq
	7gi5jBhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdVO-0000000AkxN-0j3z;
	Fri, 30 Oct 2026 03:42:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdVL-0000000Akuw-0h0G
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:42:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E52EC414D7;
	Fri, 30 Oct 2026 03:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E631F000C1;
	Fri, 30 Oct 2026 03:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331730;
	bh=IIJ6xEqRSmc3P/njmK7rvcrkOwirvqwv8tVhsJQABX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ka7UXsQhDWZeJmR/suhEgkW5bO0Pa2Frrr3UWVJxiTfY2zAtb0YAR97r0+vybzIYH
	 XiCOQGtR/AkdqEbjxD8vX9gnW6i1f9dzk9gzExvKhwwZ6/zY27gefccO91ciXjoqel
	 nvzDvOu+QxrV4K1GDdSlMi8jZxJ3FVUtiPVhHD2YllaT6T+N8nQMJJMqfLK9lm2wQ8
	 ohQ6gVRvEjZ8oIZ3WQmbplEYlkmX1bQDK9PbGYKxYxf++oSm5HQe7hjIZvZAdKTf9a
	 vCZNn7ZkH7Ql7xIa5QqMxuDYq63tXQVBRPN8rx2au2bA38AWBZmwTEVBUWfjoelgTP
	 l6CwYrAWJ5Jow==
Message-ID: <sashiko-outbox-190264@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 36/47] mm: fix unmap_mapping_range() beyond 4 GiB on
 32-bit
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
Cc: kexec@lists.infradead.org, "Josef Bacik" <josef@toxicpanda.com>
In-Reply-To: <20261029-fixes_core-v2-36-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-36-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:42:07 +0000
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

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> Commit 9eab0421fa94 ("mm: fix unmap_mapping_range high bits shift bug")
> made holebegin and holelen unsigned before they are shifted, by casting
> them to pgoff_t. That is an unsigned long: on a 32-bit kernel the cast
> cuts off the upper half of the two loff_t values, so a hole which begins
> at 4 GiB or beyond is taken for one in the first 4 GiB of the file.
>=20
> truncate_pagecache() passes the new size of the file and asks for private
> COWed pages to be unmapped as well. If a file of 6 GiB is truncated to
> 5 GiB, everything from 1 GiB on is unmapped, and what a process has
> written to a private mapping of the range between 1 GiB and 5 GiB is
> lost: it reads the contents of the file again.
>=20
> Where the range has an end, the wrong range is unmapped instead of the
> [ ... ]
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D36


