Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2DC606A31A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hxqN4M6Z;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKfK0sgy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/2z2A5flMiKJNvY0JwIpCH3aK/To9m90m+ZoMVFJAbY=; b=hxqN4M6ZpslFiTMQIYdyv4UJaQ
	mQ+HADRtX+CIunm5rWu77yAgd3w/jJ/8XZ4kUZuItM0onMsjm8eQqpED23nrqo82ai2+Y43AcG481
	/0fj2Iav0IxqcPBqITvVw2wFXT/DJZ9sbwQ7OnTL7vaKHBCW3gl8TzBovElF7SF+87O+JkVOAMFcY
	m186lMOiYFh5yOM9NjtEYZzRTHAcsOYxWSF9WbzySZHx7BESjbg18GnDUmjnszTc8z3ThL5C/eOtp
	rWJtoMKFdfJTqzx+gDn1ejG14tKP28D5A3fkMoBx5fddwo2Kt6vcF2fBwhdjfzm157mXs6MTj/9y8
	Og3IRDLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUo9-00000003V8X-2Tx1;
	Tue, 27 Oct 2026 00:12:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUo8-00000003V7X-1ism
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 00:12:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BB73A600CB;
	Tue, 27 Oct 2026 00:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B730D1F01825;
	Tue, 27 Oct 2026 00:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059971;
	bh=/2z2A5flMiKJNvY0JwIpCH3aK/To9m90m+ZoMVFJAbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jKfK0sgy7sDw/r65SnJhorz2KfEoW49+tV57Muebo4YrwayT7a80Lv0kcp6Wiz9XF
	 X4fqpPLrLxOaA7aZ/zH+HWb8FpNBDYfG8wvquOoLrbWRcu1HaUYpX19q+6t7oAlUKL
	 OAbpcjH6BdfM2C83MvaiISTStNB06nOyjt0O0x2MRgQoaM4k+lqJG/T3TkZNdpzzsL
	 eLqqeHje6DRTan93idtttSxY3xuyaGUTCb5dLp4V5I6lWqOt/yrlYiFF+CWgHUxvUt
	 VXNz1eLLm0MvtNOYsiBxeJJVjeJKEBIAKkpLN1yFzkza2N45DemAPynkC/suP7l0Y0
	 zZhnRn6N07Jrw==
Message-ID: <sashiko-outbox-185897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/46] mm/khugepaged: always recheck the pmd in
 try_collapse_pte_mapped_thp()
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
In-Reply-To: <20261027-fixes_core-v1-15-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-15-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 00:12:48 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> try_collapse_pte_mapped_thp() drops the PTE lock after it has cleared the
> page table, and takes the PMD lock and the PTE lock to remove it.
>=20
> In between, MADV_DONTNEED with CONFIG_PT_RECLAIM can reclaim the
> page table. The pmd_same() check is supposed to handle this, but it is
> only done with CONFIG_SPLIT_PTE_PTLOCKS.
>=20
> Fix it by performing the check unconditionally.
>=20
> Fix generated by an LLM and sent by Josef Bacik in private.
>=20
> Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV=
_DONTNEED)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: adjust description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-fixes_core=
-v1-0-6f74bec9a5bb@kernel.org?part=3D15


