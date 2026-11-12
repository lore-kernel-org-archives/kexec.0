Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A70606A326
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=5DOsIA6e;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ae1yNHmZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Y7nBRu0zBrqnlywd8D28Co2Gul1FjWiIuKmuLyRXkZM=; b=5DOsIA6eSSMunn7U1NnyINGojN
	CRDjLVqcPbOzTbhq3YrY639pFfFcAJCb3VCXfHSRWfSYFNlDcJWx2Wq/1RiYiZhMJjTru0ZSREHRk
	X3MciTHoqOTuKuxxYt6WA7DSx29stYWSEmO2tQ3hzvFytsKX91EX1cPTvtXp2RH5cWF9S2hWzv5dF
	7TIcV96o6TeAHRULGO7RcJl/QMaIN1x9KScISNhPRUrRU3Pyig/Jpwhq6vmzW8dfykpFztuNpTfbw
	1NlSDxa2CEoUBKygOQahUCBdzrA6buQ1faJB+oA4rbnhxbT9KJuh2JJO0fo2sdCbxRRdD5z9Wuh8H
	CYZaOSow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIjD-00000008FgN-0HzX;
	Thu, 12 Nov 2026 00:31:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIj0-00000008FWL-1uFG
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CB30560052;
	Thu, 12 Nov 2026 00:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A8B1F00A05;
	Thu, 12 Nov 2026 00:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443493;
	bh=Y7nBRu0zBrqnlywd8D28Co2Gul1FjWiIuKmuLyRXkZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ae1yNHmZDfZ0GaKU7htGuym705BwUjluVGThnT00xaFdTzRi0NVYWzKRIb6gnsXvg
	 tDPZkhKTK0MOuRTr3GbImqlH9vZ/fD+xkt6Kk+DKo7ysfbAg4ZNRa74qqXMgF+z4Pu
	 /DqbHeKFi2yuM4oZE+uTJZAbwyTEQpkDYbI7eaizZXLmXLdjP3mcNqdPrd1bXpSwkj
	 ZPmim9aj2spnLMF+gk46evsjqo3pm1jnJj8aw6/TDvL0SizKcVqRl7LkT+E+jdhSHh
	 wg+c0d0fNsWT2h6OkEqQ49rp3ov/PNwHpTlnxyxUluE3OyGNETfK5d4xNEyrQOpaqz
	 wsCox8Rz+W/SA==
Message-ID: <sashiko-outbox-209950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/19] selftests/liveupdate: Test retrieving tmpfs
 files preserved read-only
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
In-Reply-To: <20261111002358.1842967-19-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-19-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:32 +0000
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

> Add test cases to luo_tmpfs for source files preserved through a
> read-only fd, through a read-only mount, on a read-only superblock, and
> immutable files. Each of these cases except the first also preserves a
> sparse file, whose holes are filled when it is preserved. Check that
> the files are retrieved with their contents. Also check that the size of
> a preserved file is frozen, even when the file is opened by its path,
> and that writes within the file are preserved.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D18


