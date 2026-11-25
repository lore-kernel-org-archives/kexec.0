Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C9B606A31E
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jrhoVO4M;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkOegOpY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ddXRKIxs/SxtuD/Wam6wkBN67cwe/5KWMWA3NLrNuiY=; b=jrhoVO4MrDADSn5g9f3V8EKOj/
	8aPWwPdAqkdmwQuA93Po6tZvFaLXZiV4LqFTHzThdLXeyQzs+mldmMOkSHRFbmuBteGtadhcGVzwq
	4eS+RSCKMjXpBvPbvzvzPypOi8HWSvYPzEYPMaFXnJkhBD1h/Oc/bcz5FHBICWHfvvDb8i2QmDC9h
	l9hDBdnb/LcxDGnOTKtw4O2i3MfU1ggOm9T/484TbtT+gofWKNVUiwKfuAcxPTvkPnI+HAd83SMj2
	5dl+j02dMDngn3cXtM/mABCirRBkfhcjguLOjB3m4OvvLGL5VExNrRhK0HXOuJcqhlAiwGmBbeDFK
	8aZEZ3Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFT4-0000000AUGj-3Msi;
	Wed, 25 Nov 2026 16:03:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFT4-0000000AUGX-07zb
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 16:03:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8171C46340;
	Wed, 25 Nov 2026 16:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8021C1F00A00;
	Wed, 25 Nov 2026 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622613;
	bh=ddXRKIxs/SxtuD/Wam6wkBN67cwe/5KWMWA3NLrNuiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bkOegOpY4pK2bVBnG3bnbjKD9Ly29qnyfJGtvJSFy+mcJ7A6wCkRYmw+px2LnYRQG
	 bh1v30OpXbM0Y3I2C+WWIhagCXqvM1I8xntTBRY/e+dSLgL3td/Ij7l2aAQuDsswpz
	 CAj+yTSh1wW+OD1xieyGPj+Bf2s+TtCzlQgIrgsEbrpmvmVldB4eg8C5VE4R+PKobK
	 LSWjxuTwevaz/aJL8ogbfbvbkufRK1RFpRqeMjLA2R8/a+wtPVrTzqaKhW8w0NI1uO
	 1xEou2X5vN2G3xY0oqRbb9ex5pBCaU62PcfebGw6GPQ5SNtZk/l1LK3ex+7b311kw4
	 wG2m3JpbRe2Bw==
Message-ID: <sashiko-outbox-233701@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/cma: reject long-term pins of HugeTLB folios
 overlapping crashkernel CMA
To: "Sang-Heon Jeon" <ekffu200098@gmail.com>, "Andrew Morton" <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, "Michal Hocko" <mhocko@suse.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Qi
 Zheng" <zhengqi.arch@bytedance.com>, "Usama Arif" <usama.arif@linux.dev>, "Muchun
 Song" <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "Frank
 van der Linden" <fvdl@google.com>, "Kiryl Shutsemau" <kas@kernel.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Jiri Bohac" <jbohac@suse.cz>, kexec@lists.infradead.org
In-Reply-To: <20261125155108.24098-1-ekffu200098@gmail.com>
References: <20261125155108.24098-1-ekffu200098@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 16:03:32 +0000
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

> crashkernel=3Dsize,cma uses existing hugetlb_cma memory, so
> crashk_cma_ranges[] may contain HugeTLB folios. HugeTLB folios allocated
> from hugetlb_cma can be long-term pinned without being migrated.
>=20
> After a crash, the crash kernel uses the memory in crashk_cma_ranges[],
> but a device can still write to a long-term pinned folio.
>=20
> So reject long-term pins of HugeTLB folios overlapping
> crashk_cma_ranges[].
>=20
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125155108.2409=
8-1-ekffu200098@gmail.com?part=3D1

