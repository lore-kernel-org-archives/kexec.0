Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C1606A327
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dvIsqMHq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQqtPBkz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P2HyOyZhlvFE7xY22hVCwduU6Gi5r8P6sIExsoodR4U=; b=dvIsqMHq8ofwUrP5ml9E7iK//a
	CnqVim6PEj3z6Uo9rboNtwYT5JDedTz/iShORpVDIjp+s0PVj8XU9HofP9hlNlJc8j2NodDyN2w+v
	cz6DiCSqezgjwt77PTR+mmMZpYEtkdX0lYWCi3qQH/4dSlkOGdGUrCFFbplrxQv8cvCEbPxg/nbEh
	X8wXpl1Hvice9cogncKCQ38ErgXb5O9ETC4pCFDCa4LQ8Bn3pwEPGUyJzb+x/Gs2udaIEpdTLSvt1
	Cu/ZsuqHW2mQ69y3EDtbZ+uEzx/FTMOyLJPTreWmY84xv2+KB/dT1V6HEACK8yDqZsMu410wM4B8y
	Pb84pIMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSLb-00000009aQF-2mv6;
	Thu, 12 Nov 2026 10:48:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSLS-00000009aKt-3gic
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 10:47:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 15A87479FA;
	Thu, 12 Nov 2026 10:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435761F00A06;
	Thu, 12 Nov 2026 10:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794480474;
	bh=P2HyOyZhlvFE7xY22hVCwduU6Gi5r8P6sIExsoodR4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HQqtPBkzcBsvHywlAT2r7Yg2Q4C175aKMBT7K5yurnq+Ho8amb0/BkPdbOZzk3ng8
	 QLbYF1fs/P2SyddtqHpDbRVP4L4xJAY0o+FjxcbmlkWzvgIfaWvZaYr9U/WH44f60t
	 h4eTTvhC3c7I9pgs5jbaJ8WaT6VQAPmF2bJLe6HcVRk2jEND4b7oMVTzaYDcL9FrvM
	 gg+ZnKBD+BwFRI4cHXExASS4Obxf0dOgw/3F4EHPLXw77rZnly7V699afSAWDN9vBk
	 jZOna4wpbp5u4PtRnEHPjax4usI6skifn8Y3TZ7Wf21F3VOi7IXqyz6/8pH4W9f1+v
	 F0zCt8TP3qA1A==
Message-ID: <sashiko-outbox-210972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] kho: fix bootmem sizing
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: "Alexander Graf" <graf@amazon.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Chen
 Pei" <cp0613@linux.alibaba.com>, "George Guo" <guodongtai@kylinos.cn>, "Kexin
 Liu" <liukexin@kylinos.cn>, "Randy Dunlap" <rdunlap@infradead.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Sourabh Jain" <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org, "Jose
 A. Perez de Azpillaga" <azpijr@gmail.com>, "Mukesh Pilaniya" <mpilaniy@redhat.com>
In-Reply-To: <20261112-kho-bootmem-sizing-v3-4-f0c8d00295d5@kernel.org>
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
 <20261112-kho-bootmem-sizing-v3-4-f0c8d00295d5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 10:47:52 +0000
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

> Bootmem areas are sized from overlapping views of the memory reserved in
> memblock:
>=20
> * the global area is sized from all reserved memory, including memory
>   allocated on specific nodes, so on NUMA systems everything allocated
>   on a node is accounted in both the global area and the area of that
>   node.
> * per-node sizes are calculated after the lowmem and the global areas
>   are reserved. With CONFIG_NUMA=3Dn all memblock regions belong to node =
0,
>   so the lowmem and the global areas are accounted in the size of node 0
>   area and scaled once again.
>=20
> As a result, bootmem is about twice bigger than it should be on NUMA
> systems and about four times bigger with CONFIG_NUMA=3Dn. On small systems
> reservation of the bootmem may fail and then KHO gets disabled.
> [ ... ]
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Mukesh Pilaniya <mpilaniy@redhat.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-kho-bootme=
m-sizing-v3-0-f0c8d00295d5@kernel.org?part=3D4


