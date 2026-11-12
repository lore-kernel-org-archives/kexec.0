Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90B606A326
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jdu17cy7;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4YIVq7Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SSdv0wyk2rlJG6ciU4dq52+vBtW3OJU7gH3UwSloYGQ=; b=jdu17cy7MYHzEgk3AIKKAXUx7D
	i5GhX4oepVJUnxQTez3VzeSvsu4u9ioAP+k4152Lw0KnZ1MWoqFG7sNbc2FyWxX5yb8lAlyKtAtEw
	0ZcqwbE6J8SQyqnvEii3J4WoU1baUcbyR5CQdkgP9vjbY2U4JtNtxruy7tLVYGWPkkNfSbAfbh9Bb
	dpxs5WC5WKbDksM6+jSfbraWrSw88BU6eIBZ+Z+YtI5rEHaoBaPffpjadsQybGtLEL2u9RWbN/d2b
	za8Fmz/5D8ZiwbluZ44jwvicGlTng7MuH/sFUL8MhcOfCyROJfdVjSnQ8glj9ii5u4BtOO6vAG7rh
	GMJmhUpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIiY-00000008F13-2zus;
	Thu, 12 Nov 2026 00:31:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIiY-00000008F0s-09jM
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E4ED42282;
	Thu, 12 Nov 2026 00:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A28C1F00A07;
	Thu, 12 Nov 2026 00:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443465;
	bh=SSdv0wyk2rlJG6ciU4dq52+vBtW3OJU7gH3UwSloYGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V4YIVq7ZsbrM79OpFCOHHWRcmFbBUyTBdjQdtd1ASSYdh41PqJKNh8nzdjV0OLO0/
	 trM0yTlaiBoKIY1IzcyHG7Rm/I7E6cF6383U25zfsA8xNH59h/uxf/kYxaDtlaKcYC
	 XOF+Sa4E/QlNFblSkAGBl0dz7d+ZBezpQf6doap1aF/cT2l5/qYQjca1pvLjo5INym
	 bFSISRZai2mMfwyPSlcj9O/FlEh04/evtULO/xcV0/Tm78nmSRBm9OTZeNma6blQgv
	 Y83nrDpR7heOfmtCRseHiKWSeZnVYDyzy5UBD4GJfJogHQUpSMq1/Lv60Y0qf5kSEr
	 TA8siNYSUypXw==
Message-ID: <sashiko-outbox-209933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/19] liveupdate: Remove the list of steps from
 luo_preserve_file()'s comment
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
In-Reply-To: <20261111002358.1842967-2-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:03 +0000
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

> Remove the numbered list of steps from the kernel-doc comment of
> luo_preserve_file(), along with the sentence that introduces it, which
> repeats the first sentence of the previous paragraph.
>=20
> The list only restates what the code does, and goes stale whenever the
> code changes.
>=20
> Suggested-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D1


