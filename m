Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE78606A31A
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=o1QwF56E;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOY5+RCa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yTUX9iDubn2htDzTrk+z9U7DcbGcrc1sbmGaTs2Tj6c=; b=o1QwF56E8KoIW/J+52WT6xTDih
	bGCCv1JesNLxXyC3PLYHaoDsaWH/tFaOX81mlH/H6aFzNO3/16iZUiOPdx7BBMlQOPniI5QJ8ymVH
	oTBKMWKkdycRAYSAHWPJ3U40mxuMM/cZhnkS0K+EYQ5OnMHi+wCwpJRxSDvAezleeA6xLN6aH3aYd
	0gl6cAjJ3byIbhv77u4F8km5oBHNm7lXBDglwuOi5s9c2D2xSDmAGH7u2I9rZY4CIZkEZm7bOUAyI
	oegBHdkz+VAaMhHlxcLaN7lfP9mrPVpNKiLNI8aWXIHayTUTQfXWCV257yfY965g6i/KgkMV/pDhi
	lKzXMB5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Sy-00000001Gqt-1DhO;
	Sun, 25 Oct 2026 17:57:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Sx-00000001Got-1cG7
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:57:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1F2D640E05;
	Sun, 25 Oct 2026 17:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CEE1F01825;
	Sun, 25 Oct 2026 17:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792951027;
	bh=yTUX9iDubn2htDzTrk+z9U7DcbGcrc1sbmGaTs2Tj6c=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hOY5+RCa7Wq+gn5O4zWpT/FWCjCb8khr2bBvqugovhjQJFElOTHNF8SSitMiyw4O0
	 aROP+Nifu3v6Ifyev/YY9K6RFhe1WVekoKHQgyrb6rZBkn0iG3w8OgjwNu5bX/9V2p
	 /ibtv3bT1aU1hNLH9WFPmLvsYZejYNsRjP0+rcjFVNz0KJWvVnZKkIwhL4vImh7FXx
	 lwdFmu45X4XU8TzZh/otgcJ3nRMyYobA/+35EIKuQQkQNh5hQ8WTU3Hr/n1noXMwyF
	 9vWLi8CBhAYA0vDfmz5P3HUch848w5K4hUs5UgB/+T5Eoc2s/WbPUj+4BVvCxn1Yst
	 r6fZVZeSgCdkA==
Message-ID: <sashiko-outbox-184308@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] kho: test: support read-only KHO mode in
 test_kho
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261025174017.3870481-9-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
 <20261025174017.3870481-9-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 17:57:05 +0000
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

> test_kho currently depends on CONFIG_KEXEC_HANDOVER and restores
> preserved folios via phys_to_virt() and kho_restore_folio(), which
> prevents testing preserved KHO state when booted in read-only KHO mode.
>=20
> Allow CONFIG_TEST_KEXEC_HANDOVER to be enabled with
> CONFIG_KEXEC_HANDOVER_READONLY and update test_kho to verify preserved
> state when kho_is_ro() is active. In read-only mode, retrieve the test
> FDT subtree, map the FDT folio via kho_ro_map_folio(...,
> PAGE_KERNEL_RO), map the preserved vmalloc folio descriptor array via
> kho_ro_map_vmalloc(), verify each folio's preserved order in the KHO
> radix tree via kho_ro_lookup_folio_order(), map each folio via
> kho_ro_map_folio(), and verify the checksum over all preserved pages.
> Also guard kho_test_exit() when no outgoing test FDT was allocated.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025174017.3870=
481-1-pasha.tatashin@soleen.com?part=3D8


