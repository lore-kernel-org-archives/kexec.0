Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5807606A323
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=L8uTxKW0;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKkvvYxV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=irlTfbuxdiMpDcvP4FHkEhCPa2hhZ00WVQ6MUSYj6Pc=; b=L8uTxKW0KIno1PmhfnCDp4Lkng
	Op3t7NrW3eCgwWFKFj/l+qxqJanSz1KXepNA0cP8vhNk7H7Jnw9y5yl6Pb4FFXUf+v5wpTKg3pYI5
	P/Vf0jUaSv282jAwxSFHyMUt+hdD1yWzN0bG5fjrfctTymY0zMHs0qrkZapk9GJMaem1AEsG16gXe
	ObYZduPUAXUU5yLLFpeyBibW74OarmqrhaeSi9gafydMnGsomE9Yto4LrUalfmmAVGOwytehLpr/F
	OrsYXXCI/lGZobLx9ys+q1YxS0hCf/jagu5y1qA1SpKliX2vdoGtWWYr/pUdZKu7HAzWq2d0fVvF3
	ajv380aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5vL-000000048bf-2cRt;
	Mon, 16 Nov 2026 23:15:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5vF-000000048bF-0ht5
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 23:15:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D97FD43CC1;
	Mon, 16 Nov 2026 23:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE711F000C5;
	Mon, 16 Nov 2026 23:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794870936;
	bh=irlTfbuxdiMpDcvP4FHkEhCPa2hhZ00WVQ6MUSYj6Pc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IKkvvYxVqcZvdS1TDlwoU2qoUoA5xI9SLsm+DXbuUwb0vz9kbwET7e8B6Cm4jiEtF
	 A+OpELWCjjj0DERNQQSR6+Yuo1dXpQzsNZsQf2/FELRJA7Yw/SVomlqGooaqXkvOhY
	 KhxY7j6827+UFVOH7QsTPhubv5IMORt0lXEhLwhqGjeqQ14outAW41QAU4ErKFA0I3
	 rMtt0BJcEOMjscthUUUCR4womdcHk+MmBWeOZzzfxFigSKhTVlSKoV4IlRUibj8PIz
	 huff0kFBiA/h3qvNgxA6sUJ7CzFrqvv0Xg4GXO6YoV1rvLdK6/Lm/+lB40RBgOcfT2
	 /vQFi/FF113Yw==
Message-ID: <sashiko-outbox-217865@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/7] net/rds: use GFP_HIGHUSER_KASAN for message
 pages
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
In-Reply-To: <20261116230627.3537051-5-jeffxu@chromium.org>
References: <20261116230627.3537051-1-jeffxu@chromium.org>
 <20261116230627.3537051-5-jeffxu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:15:29 +0000
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

> RDS allocates the pages that carry message payload with GFP_HIGHUSER:
> the receive fragments in rds_ib_recv_refill_one() and the send payload
> in rds_message_copy_from_user(). The kernel fills and drains them
> through copy_page_from_iter(), copy_page_to_iter() and kmap_atomic(),
> and they are not mapped into userspace.
>=20
> Allocate them with GFP_HIGHUSER_KASAN, so that they keep their KASAN
> tagging when GFP_HIGHUSER starts to skip it later in this series.
>=20
> No functional change: GFP_HIGHUSER_KASAN has the same value as
> GFP_HIGHUSER at this point. Build tested only.
>=20
> Assisted-by: LLM
> Cc: Allison Henderson <achender@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Cc: rds-devel@oss.oracle.com
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116230627.3537=
051-1-jeffxu@chromium.org?part=3D4


