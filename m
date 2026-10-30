Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AA0606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Wj65bSOT;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TD4MqYLG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6IFs6Ua5cKqFfxiaIjBtPKSG0AZAvSoXo+bIWocfbD0=; b=Wj65bSOTOLH7hoq0ebaDtrRdaq
	hT3uZESBx6wyMkIo095+4xWU5P69PG/5RbeJ1mewosK8J1U9f337alxbz1v6+DQUFjpAsjovpC+KW
	x72umkbqj9Cy0qAbWQCH1WCYFBltZLcUg0bSZ8RZLQrb97VP1TWPgHPSKOinpxZpUQRcI98M5vsjZ
	FRgleDUja5E90tpDiBVqauHDFDgQ7u79YHdPltzUmjVJuu+IXKzDLstzbhV6kNFB/wuO3o4VTOogt
	3zD9yNSO+INIO+enqRw4J2ndEyWhBcGRtfj2A+eLu0BNYg32qYwGU3uBAEGWNPwiCfLbxoKwKDSsJ
	pMvQ5z/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdTp-0000000Ajtq-3z6E;
	Fri, 30 Oct 2026 03:40:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdTo-0000000AjsX-2He4
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:40:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 40CA542E90;
	Fri, 30 Oct 2026 03:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E521F000C1;
	Fri, 30 Oct 2026 03:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331636;
	bh=6IFs6Ua5cKqFfxiaIjBtPKSG0AZAvSoXo+bIWocfbD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TD4MqYLGV0vwDN4xOeoxDFS9YtfbtWcWN8rcWhGN3xzTJLFlzln7ejUIr9NyUlI5P
	 hdupQP7IjZXRrtPALN10iAfyAc4738vd8dNRbpndnTM/7ECCptR8z47V4/+xghYneY
	 h2TKyu8UD/qp4wqDujE+o5uh6IRKXUBuv4RrQlyawb6V1iFTsaGsDT8GJ8Bx7M/0Pl
	 9YOTtisArq57C65+tD20vt6pOwEVS1ViToO6VcSuuxoIDn7ptGfjdrPnq4fL+vmUef
	 tpZ6v+6v3OE3Z/Nof9KUMYPHho5Iq96DbJm7oiRWnCEv45qAsqbvd/S1MPSkMO+OOz
	 D8SnalyD/+L3A==
Message-ID: <sashiko-outbox-190236@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/47] mm/filemap: finish fault cleanup before
 dropping the fault lock
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
Cc: kexec@lists.infradead.org, "Chris Mason" <mason@kernel.org>, "Thadeu
 Lima de Souza Cascardo" <cascardo@igalia.com>
In-Reply-To: <20261029-fixes_core-v2-8-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-8-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:40:33 +0000
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

> On a retried fault, a fatal signal interrupting the folio lock wait
> makes lock_folio_maybe_drop_mmap() drop the fault lock without pinning
> the file. However, filemap_fault() may still need to release
> mapping->invalidate_lock. A concurrent munmap() can release the last
> file reference and free the mapping before that unlock.
>=20
> Defer dropping the fault lock to filemap_fault()'s retry cleanup, after
> releasing invalidate_lock. If the fault lock was already dropped for
> I/O, release the existing file reference instead. Keep the fault lock
> held for FAULT_FLAG_RETRY_NOWAIT as before.
>=20
> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache w=
ith invalidate_lock")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Reviewed-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D8


