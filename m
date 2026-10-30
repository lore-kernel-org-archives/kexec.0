Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FB2606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1ZEoHfaO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FXYK/0/v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IfXkLdB2R4sDImm8bzY/1UjAIsrAfwRilVnQTGvBTuU=; b=1ZEoHfaO1Gpw6jxb/a2GdS0GLB
	jYBSOgYIOZdBlqm+SlgfkYdaH+m4oYH9gNcpSfvzNfOm2oV+yLLmm/GtLmRN2lYLo+s3pFD10bpET
	nv2ulFWtmV61d54dBni6YeM8tHbzNDlmbcTTcRindLHnJPig0u866qYlSEowU4x46MzRmz3F05ejf
	tsBRzvrMus820HxgUH6/ZYM9daDHKBjYdiEDGI2/cbyhV9sIbFC0uZDkdPPrGhqe8W0I+vCweNyA8
	l4r+5cf9CxFbYLBjstTDhU5pyY9HeWDNz7paaYJvBsY98ptOBle0A1PSJWTb3YIQ3w0L30U0Ooboy
	XtyEghwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdU3-0000000Ak3n-2zam;
	Fri, 30 Oct 2026 03:40:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdU1-0000000Ak26-27D6
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:40:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E8154600C8;
	Fri, 30 Oct 2026 03:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FDA1F000C1;
	Fri, 30 Oct 2026 03:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331648;
	bh=IfXkLdB2R4sDImm8bzY/1UjAIsrAfwRilVnQTGvBTuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FXYK/0/vbbRVTpCfi5NSPh0rsRu3XHDuU4p1ncAnAn9u2KhLt7a11/ulAHTdXSI89
	 Y0AHpJ5J+ZjwxSwoX36ie+QwEwU4M/Z7moUh+EMte6IJ9r7LPKVGYthTLxD6wJbKEZ
	 AqohEGYHGzsqDlLqhfkIgGqaUws1J8bujta7wXhdX5kH+ae0rfgyjrbqjd8GO0qSkg
	 n3mcBYAZkOxo5PKVmQRuODtKb8Wx9M/+BIoXO/nAp7JZ7vNMhiPig4/0ofjQv20paz
	 2gk7YH9JJUYGIITKm9loz/xC9KaWp/ngJKJ5f3tWSii3dQne94HPVOlWqp7Abg6E34
	 kKZU3rQGjAXBg==
Message-ID: <sashiko-outbox-190240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/47] mm/huge_memory: fix livelock on device private
 folio
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
In-Reply-To: <20261029-fixes_core-v2-12-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-12-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:40:45 +0000
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
> If do_huge_pmd_device_private() cannot lock the folio, it simply returns
> to try again on the next fault.
>=20
> Just like we did in commit b570f37a2ce4 ("mm: Fix a hmm_range_fault()
> livelock / starvation problem"), let's wait for the softleaf entry,
> which will drop the PTL and wait until the folio was unlocked. This is
> precisely what we do in do_swap_page() with device-private folios. This
> avoids possibly livelocking.
>=20
> Update softleaf_entry_wait_on_locked() documentation to clarify that
> device-private entries wait until the folio is unlocked.
>=20
> There seems to be no compelling reason to backport this to stable
> kernels unless we actually see problems there.
>=20
> Fix generated by an LLM and sent by Josef Bacik in private.
>=20
> Fixes: 4964099163d0 ("mm/memory/fault: add THP fault handling for zone de=
vice private pages")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: simplify patch description, fixup softleaf_entry_wait_on_locked =
description]
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D12


