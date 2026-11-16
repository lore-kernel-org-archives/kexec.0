Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ECF606A32F
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2/x3hj9D;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEDmK3yu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8Y/jmGHmDr5CDQdtNZLzYKMbpKH9Akbhi8ylVWwM4IM=; b=2/x3hj9DYnZJG2uXv51PCqDpUu
	Wl6mb5OzdHpdwkE2xyYys6Vg5EHv+oBW9G7gBZ4Zb6KcJ0k42/x1PcD1gDtCJxzjMgy2IWpk3Pp8u
	5lek+kNhvxmwaWRQChTrUZEnc2ZVlUMzvxDq3u2HHkC+zMMC/HYt0+dw6bYW2+hdHuNTGJPqtOpAW
	hyXyyV1FUPu94ZzPdOfKbSJIBlx4AjH51mJFmbcnYBmiFEFz64x+Mq6nbNtyvMAJdr/QTkV0FXBmb
	z0FqKWGM6+vtlwpCkMUydsr+S3QRi0GaMjK8W2sqsDD21e/Cz707pEYKqU0p8jwGn+G9kDMjAz9Ni
	uHkNGsvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5v2-000000048UN-1syk;
	Mon, 16 Nov 2026 23:15:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5v1-000000048UE-1Lzs
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 23:15:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C567D431F8;
	Mon, 16 Nov 2026 23:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5311A1F000C4;
	Mon, 16 Nov 2026 23:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794870922;
	bh=8Y/jmGHmDr5CDQdtNZLzYKMbpKH9Akbhi8ylVWwM4IM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FEDmK3yumbhiSrIrQBbD1KaUdpW47MZ7zm/FNLiW8bkO16EVPYUHoVhf1egtRYQdN
	 mOs7U6ZQvOzk6wqcSbKaN7U7uguDipNddrqHPfPMfCbOJUmZhP4SUO3NQaGRUUm0Fy
	 I3y1EHs2jkvz8z8fo8jI7bcqNAbuwM3ZRtdgQMXEQgm1XqKhGqe8pfWE8rz2uSf2Wi
	 FSlYp0/XXlkNrS3dtnF3kavnt1HLu+WdZRqOaQ1liKtyjNv8z0tIDr61xGIyBGQkOn
	 tcjy3u+0HaVirk02JefNMIACpHiVK7mNHkAs2KXeaXdttYrgewNhj9vJ7AhTAdt9Vr
	 +VuUuA54+wDRA==
Message-ID: <sashiko-outbox-217862@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/7] mm: add GFP_HIGHUSER_KASAN
To: "Jeff Xu" <jeffxu@chromium.org>, "Andrew Morton" <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Brendan Jackman" <brendan.jackman@linux.dev>, "Zi
 Yan" <ziy@nvidia.com>, "Alexander Potapenko" <glider@google.com>, "Andrey
 Konovalov" <andreyknvl@gmail.com>, "Dmitry Vyukov" <dvyukov@google.com>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Marco Elver" <elver@google.com>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Catalin Marinas" <catalin.marinas@arm.com>, "Chia-I
 Wu" <olvaffe@gmail.com>, "Dev Jain" <dev.jain@arm.com>, "Evgenii Stepanov" <eugenis@google.com>, "Ian
 Rickards" <ian.rickards@arm.com>, "Jann Horn" <jannh@google.com>, "Jeff
 Vander Stoep" <jeffv@google.com>, "Jeff Xu" <jeffxu@google.com>, "Kees Cook" <kees@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Peter Collingbourne" <peter@pcc.me.uk>,
 =?utf-8?b?UGllcnJlLUNsw6ltZW50IFRvc2k=?= <ptosi@google.com>, "Ryan Roberts" <ryan.roberts@arm.com>, "Tomasz
 Figa" <tfiga@chromium.org>, "Will Deacon" <will@kernel.org>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Miklos Szeredi" <miklos@szeredi.hu>, "Baoquan He" <baoquan.he@linux.dev>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Allison
 Henderson" <achender@kernel.org>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, kasan-dev@googlegroups.com, kexec@lists.infradead.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
In-Reply-To: <20261116230627.3537051-2-jeffxu@chromium.org>
References: <20261116230627.3537051-1-jeffxu@chromium.org>
 <20261116230627.3537051-2-jeffxu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:15:19 +0000
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

> A later patch in this series adds __GFP_SKIP_KASAN to GFP_HIGHUSER, so
> that with CONFIG_KASAN_HW_TAGS its pages are neither tagged on
> allocation nor poisoned on free. That suits pages whose contents belong
> to userspace and are mapped there.
>=20
> Some GFP_HIGHUSER users allocate buffers that the kernel itself fills
> and drains through kmap_local_page(), such as pipe buffers. While such
> pages are tagged, KASAN can report a linear overflow out of the page
> and an access to it while it is free.
>=20
> Add GFP_HIGHUSER_KASAN for these users, so that they can be converted
> before GFP_HIGHUSER changes. It has the value GFP_HIGHUSER has today
> and will not gain __GFP_SKIP_KASAN. The two stay identical without
> CONFIG_KASAN_HW_TAGS, where __GFP_SKIP_KASAN is 0.
>=20
> GFP_HIGHUSER_KASAN must not be used for memory that userspace can map
> with PROT_MTE (anonymous, shmem and hugetlb pages). Userspace sets the
> memory tags of such a page, while the kernel keeps accessing it through
> page_address() with the KASAN tag from page->flags. The two do not
> match, and kernel accesses are reported as KASAN faults. arm64 does not
> reset the tag in page->flags when the page is mapped; it relies on the
> page having been allocated with __GFP_SKIP_KASAN. Nothing checks for
> misuse at allocation or mapping time.
>=20
> No functional change. The kernel-doc describes GFP_HIGHUSER as it will
> be once it skips KASAN tagging.
>=20
> Assisted-by: LLM
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116230627.3537=
051-1-jeffxu@chromium.org?part=3D1


