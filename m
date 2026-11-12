Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F52606A321
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SCV3jyho;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYXs15zo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cySOhdHwQyGmWbz/j0SgtLEOST6AQDNlBfOAsEjaJYk=; b=SCV3jyho6flFmpSBjQMU0uuGDc
	ekjZlaU45yveiW7je849UOvKr9rCPiG4iSukMGtxzfAx/lfBRpMnxOort+rqb5CrC8kDdZVH7AJky
	2VyenFsDXPRt5j8/JQmZeg1KT+izKImSdYNphjxG+QgT0MbTnSca8gonwHbru9a0rjSalTeanemia
	UqWHkAcHBEQSbpUeAEeDcYffQd102nXpRpq1Wsl0fD4t/bFNzC5B1Y9BoU7ORHMMaASvyfKQdwGRq
	5A0O9orG62cVwhgIQGAb3e2msqVT1h9zywWEoNrmsGKsyADrc4tegdeFn7dJqTCbameJdfEjTU6So
	pCqBG7Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIjC-00000008Ffs-3Vkc;
	Thu, 12 Nov 2026 00:31:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIiw-00000008FTo-1mmq
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2EBC14040C;
	Thu, 12 Nov 2026 00:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DD01F00A05;
	Thu, 12 Nov 2026 00:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443490;
	bh=cySOhdHwQyGmWbz/j0SgtLEOST6AQDNlBfOAsEjaJYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VYXs15zofWVgqkf5r/jgfPgGxJc8At+omxv2bkGVpsNm81XmVD4YBmUwnqV0Z0J/i
	 ZwlFLhd/4rBhCpBhOJhUEyEh0qsfHhR0t159Hz4/nFs/DC1odI2pD8PhpCAF8CAnjk
	 et5kfvUBDxWrEDs+JnnBb4rtlLEJcoWFEhUo4o//9OLJU8MbwMQnxND4fCT7AZo9lC
	 uZn8rFyvdf7CVAKuvZJWjDINJzaS08fbGxi9o3IzaAgfmBEBK3oGTdFeilUH5oa91c
	 hmvlV6ZREmKG5OvD1jKalR+dkAgPwTnrkeoly6jg7DbV9DKI3ywCCa2DKQm6nYZugK
	 18hhhmh/acpWQ==
Message-ID: <sashiko-outbox-209948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/19] selftests/liveupdate: Test memfds and LUO
 interactions in luo_tmpfs
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org
Cc: "Alexander Graf" <graf@amazon.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Hugh Dickins" <hughd@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Suren Baghdasaryan" <surenb@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>
In-Reply-To: <20261111002358.1842967-17-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-17-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:28 +0000
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

> Add test cases to luo_tmpfs that check that memfds are retrieved as
> memfds, with their seals and file position, and only without a retrieve
> argument, while tmpfs files can only be retrieved with one.
>=20
> Also check that invalid retrieve arguments fail and can be retried after
> fixing them. Retrieving a token again fails with -EBUSY with an
> argument, and returns the same open file without one. Files can't be
> retrieved from outgoing sessions. A file that LUO already manages can't
> be the target, whether it is preserved in an outgoing session or was
> already retrieved.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D16


