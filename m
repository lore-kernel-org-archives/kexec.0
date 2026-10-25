Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E703606A31A
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GCBNcE9x;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lgogj7v4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fQZ0aBG43l9gHzJfLFUvUfmdnBCRo9j/mwX0/KqYRZ0=; b=GCBNcE9xufThOXOggdq07TGcCS
	Sa02qOCuKCwYABiG4TbCE5BZAgabyUWdQHB3Yw2R8oj5dMD4Y3nri8FRZ8Oo1MykNpRtZNgxxuy0x
	QDIPTKWy3Zt89uqRzr/iIsD1OYd3JsAF8T6LUig/wBQQkQ4oJR/htmY9QIXLsFNTKDDXziisPg5eB
	r8cNQOH9xz4WhhxexxJyggjzZggg2xO/pXcm4Ou1iOknFU+tuRryZEyx1G4p2feiTbAnXHvxbMiEB
	5o3DvVZOn8mDKf2PMEET0P1pkHHqoqLP6cFZWq28uct7X0gCiTmy56uLsHUU8tORwRFBEwWBUgWzl
	e4QI6pvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Su-00000001GlI-3xij;
	Sun, 25 Oct 2026 17:57:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Ss-00000001GiC-2vUx
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:57:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2969D600AA;
	Sun, 25 Oct 2026 17:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64861F01825;
	Sun, 25 Oct 2026 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792951021;
	bh=fQZ0aBG43l9gHzJfLFUvUfmdnBCRo9j/mwX0/KqYRZ0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Lgogj7v4k2kn/PjSkPhBGSLE+XjVsmHFNz4k0tXPkK9NASXBvHB8Qk0OhnLWxzEJD
	 km2qTJfPqZaDeS3I9KCdZV3U6kWrNIYNNhOL7uRREJkAgHOY4VSX6uNAeENN8toaNh
	 Eaa1HsltHC+0yGwbtY+fQ8BrJUhONLNUsC/G6X2b7EYKFXGwkuFSs6bt29hBsO3cN6
	 WLMpMPBD2f+ho24+8daOsB/iYquW5DdV8RsIzTOgVFKxPlmh9UjtkXDVNfPkC3igH6
	 lCMVRXp2k3GOU5NtW6lVdVkeUOxrSCG57TogV2wkgBjvMj8l5lpEF4n7zT3d9/uCNo
	 ZbJYLwEgRDcfQ==
Message-ID: <sashiko-outbox-184305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] kho: add read-only Kexec Handover mode
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261025174017.3870481-6-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
 <20261025174017.3870481-6-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 17:57:00 +0000
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

> Kernels that inspect preserved KHO state without taking ownership of
> preserved memory need a way to traverse the KHO FDT, radix tree, and
> vmalloc chains in place while leaving the underlying physical pages and
> metadata unmodified.
>=20
> Add CONFIG_KEXEC_HANDOVER_READONLY and the 'kho_ro=3D<pa>' kernel
> command-line parameter so both regular KHO and read-only KHO can be
> compiled into the same kernel image and activated via the command line.
> Map and validate the incoming KHO FDT once in an early_initcall, and
> cache radix-tree node, leaf, folio, and vmalloc mappings in a unified
> RCU-protected hash table (kho_ro_map_ht) for the lifetime of the
> read-only KHO kernel.
>=20
> Also export kho_is_ro(), kho_ro_lookup_folio_order(),
> kho_ro_map_folio(), and kho_ro_map_vmalloc() so callers can check if
> read-only KHO mode is active and map preserved folios and vmalloc
> regions verified against the KHO radix tree.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025174017.3870=
481-1-pasha.tatashin@soleen.com?part=3D5


