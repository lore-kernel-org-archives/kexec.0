Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B69606A31A
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ed2vqDj3;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcIz2p7d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=123WU0va+mkzLwQaSOYxlfZwXCZ2FTDl3dovOxK96xI=; b=Ed2vqDj3j9+XCl6q47DtvbUnvX
	PVP9vwmQbuv0tnzPEf5uyEWbfc14hqxD9whLQmnzE5CMmEMwlT4SuGEYrhYdS6h3/IwZ0gHKAFBJ0
	fqgoXfPcJ7Z/TLvJ+3+kwAZOVwvhU72I+p1QK0ZBJVDxlJPnx/1CusZdc9lAlNZ7J+8KmNYcZt5TS
	PKkot0vFzp72sii3NE22Z/Sf8thC4+2ZCq5WSy/bfJ5m+6CUoLaJY2forJu6Pn9bbMW7EW+ABW3t+
	O5HjE53Al8/afl6ibugHhjYvQJz46RUSj+GGrbwtxgC7hLHcIqYS+oy6Z9aZ36Hha8s8A5UVkQVEj
	Kg5q1fiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Sr-00000001GhS-2WnJ;
	Sun, 25 Oct 2026 17:57:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Sp-00000001Gfz-2vF0
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:56:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 27A2C601EF;
	Sun, 25 Oct 2026 17:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6A91F01825;
	Sun, 25 Oct 2026 17:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792951018;
	bh=123WU0va+mkzLwQaSOYxlfZwXCZ2FTDl3dovOxK96xI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fcIz2p7dt2AMosAyMTUvZxng5eXnGRK6Cm4NPzMYNiWgjS4qz4rdd1vLDx/CVMhGD
	 IpW42RMMrteZs39ZgZ3qxoszS6bmKLkHNJDCIE/W7EtzH3s/e2nBivkA5Tug6ep4NQ
	 RcsFm+D244tP5A9xbGxQcWKigMqrIv3RebzJqY5w1mdp8Li8K5pTPwknyzvhXMtmgC
	 xUKEM0pvKcUXolag+OemFpim6SGKP3ywt3eKA626MvEAgYKXXNOQ5O+DYcS7r5U5UM
	 hKB5dJI42+wAejaUG5SiRjOWyJtUA0OT4kO1UwcGOcX+9cf39Hji2Fn6A+MFD1ACVc
	 qMzhElPRRFTJg==
Message-ID: <sashiko-outbox-184303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/9] kho: validate preservation metadata in
 kho_restore_vmalloc()
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261025174017.3870481-4-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
 <20261025174017.3870481-4-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 17:56:57 +0000
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

> kho_restore_vmalloc() currently dereferences preservation before
> checking for NULL, does not reject unknown KHO vmalloc flags, and does
> not validate preservation->first.phys, preservation->total_pages, or
> preservation->order before allocating the pages array and shifting by
> order.
>=20
> Move kho_flags_to_vmalloc() to kexec_handover_common.c and introduce
> kho_vmalloc_validate() and kho_vmalloc_walk() so both regular KHO and
> the upcoming read-only KHO mode can share vmalloc header validation and
> chunk-list traversal. Converting kho_restore_vmalloc() to
> kho_vmalloc_walk() also restores each chunk page before reading its
> contents and rejects non-terminal chunks that are not completely full.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025174017.3870=
481-1-pasha.tatashin@soleen.com?part=3D3


