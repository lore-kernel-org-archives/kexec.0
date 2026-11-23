Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E5606A31A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CoQeeONu;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HuTvG9Ls
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=O2PDXHMEw4Fy1/k2MO0pkbPKF0H2GXDc7bKdUmva7j0=; b=CoQeeONuR+vtX0ZnkiavLI4mXz
	t4V4AY/CCosaz3obg+FNG81VJfDspQ6nVmf7pjARQqvSOyPsKPzeI6jtgSSwfugy+z4stlpOpKwZU
	EQ2DbksxzmJzN4V7sjUDLc/9l5j70Apyp4YzMIBCX/XljuzWFzgBcGJN5L4/qVmXJiNdxCGlr96P7
	BU5tIXQLQb5paUvSlHyMwVqKHtKUQAqKas5oJexVAr2lSjz3cJ8pmGGDBawoV94aPstP+gjiyBHwm
	EApNDFFqnOh57X6Kt2iuCbaFCFluCvCEomEyJZjhOFnnj0l09janpGHH5UKcgEA5g6MOJ/Dh/tudE
	oG38w3/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVKvz-00000002E2D-2q66;
	Mon, 23 Nov 2026 03:41:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVKvy-00000002E24-0y4G
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 03:41:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A580C409FC;
	Mon, 23 Nov 2026 03:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D551F000C0;
	Mon, 23 Nov 2026 03:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795405297;
	bh=O2PDXHMEw4Fy1/k2MO0pkbPKF0H2GXDc7bKdUmva7j0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HuTvG9LsMTyG96xK4He1xnM4Eg6W/7bkzxLa9wAADy8G8YTM6SSATsQz7ndTQg4hU
	 YHF7hfCesJBna1yd/N2+Bt28V9UGpsPZ7gZJv3MiH82D+2mXXkceKkPQ2hhYpGdBEP
	 Jvf1LhzArln55BIY5qwd3p6/XtoePRi3H7yEnl+JCioe1qdAmdURrSYVGosQJ22mzV
	 7L3xfHZHf5XdYI8UkpgNcgk8c3QcXFkpDJSv8FxxDIot0OLoj4Y+h6UuCigirmzPsJ
	 r+gALl2drqsJ8M88YYI0RR9E+Pna5NHsvUztfOVTWdHCgpgLAekrD7n1UIFmvgLZY0
	 X3NbWvWnL48MQ==
Message-ID: <sashiko-outbox-228597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 0/2] mm: kasan: skip KASAN for GFP_HIGHUSER
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
 Wu" <olvaffe@gmail.com>, "Dev Jain" <dev.jain@arm.com>, "Ian Rickards" <ian.rickards@arm.com>, "Jann
 Horn" <jannh@google.com>, "Jeff Vander Stoep" <jeffv@google.com>, "Jeff Xu" <jeffxu@google.com>, "Kees
 Cook" <kees@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Peter
 Collingbourne" <peter@pcc.me.uk>, =?utf-8?b?UGllcnJlLUNsw6ltZW50IFRvc2k=?= <ptosi@google.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Tomasz Figa" <tfiga@chromium.org>, "Will
 Deacon" <will@kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Miklos Szeredi" <miklos@szeredi.hu>, "Baoquan
 He" <baoquan.he@linux.dev>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Allison Henderson" <achender@kernel.org>, "David
 S . Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, kasan-dev@googlegroups.com, kexec@lists.infradead.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
In-Reply-To: <20261123033111.2349160-1-jeffxu@chromium.org>
References: <20261123033111.2349160-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 03:41:34 +0000
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123033111.2349=
160-1-jeffxu@chromium.org

