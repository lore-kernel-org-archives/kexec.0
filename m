Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44089606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0sBVViJl;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=POPt9ZrM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WLuhSeVZwuII/ekv1nip2GKGXdiQcjbbqK8UL4F59aU=; b=0sBVViJle93Y2ayZYgx/AE1mRK
	zQbYbUmzMyIoUccVRXZ/lSylqU7kDOYUr/aZirOOf0EHsPpurrT8/TA7CRY8H9PiUaXcX1X1Ohqh2
	1pvKX3mXCMWtqYNh9urlAaL89QD/jNTicVbWENjKR0sA53gM262Pog2/Aj16Fc0EvX6e8RS6S8GON
	wMKIRjnrtG2cymwktHLd3t2fvhFUF4cSQlgrUs2Chx5KIQ2jfg+neKiTC5rNsLHFZUld9As5HXNe+
	/0q/gmk7NLZ53PydbdGwlnnErdVZ2doRtUyW8iDo/0EvJUhFLDiGqQqFu5gmj0oYKW5CbCAT9iBts
	osKaJGLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNXK-00000008zwJ-3IQC;
	Thu, 29 Oct 2026 10:39:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNXJ-00000008zwD-0Nwe
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 10:39:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E1D98601E4;
	Thu, 29 Oct 2026 10:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163281F01825;
	Thu, 29 Oct 2026 10:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270347;
	bh=WLuhSeVZwuII/ekv1nip2GKGXdiQcjbbqK8UL4F59aU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=POPt9ZrMal3PFiSdrCMVbJIHwKWEd2RurdJ1Hj3Flxs+2Cp6Xh+USRJIzC3CxrBjt
	 qBW5uWW9s4y41ODt6EDHeLruUxSWVX7xBvVqHr6TsSE3akawow9h953tToY3jyPLUo
	 vzRgJYNxWPgQj3DkzXYKAO3oRiazGdJxqz1ValQrrujpsus4vw9Wz/INaCdSk43wt2
	 2W64ljK5JurhXgGW3a6tFwF3xdW0nExF3Syx7zT/+TJVzN7GzrdZ276yXA1dF2yWQI
	 GzWo+SybHIRp1WKOEu/rtzG9uRA7owDV1fUmzO0uS1vRDgulaNnwb0QaHfFolbN3+3
	 YkWCDb4XSI/rg==
Message-ID: <sashiko-outbox-189142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] liveupdate: kho: calculate per-node bootmem sizes
 before allocating any
To: "George Guo" <dongtai.guo@linux.dev>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org
Cc: graf@amazon.com, changyuanl@google.com, akpm@linux-foundation.org, chenhuacai@kernel.org, sourabhjain@linux.ibm.com, liukexin@kylinos.cn, guodongtai@kylinos.cn, kexec@lists.infradead.org
In-Reply-To: <20261029103425.14689-1-dongtai.guo@linux.dev>
References: <20261029103425.14689-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 10:39:06 +0000
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

> From: George Guo <guodongtai@kylinos.cn>
>=20
> kho_reserve_bootmem() calculated the per-node bootmem sizes inside the
> allocation loop, after the lowmem and global areas had been allocated.
>=20
> Without CONFIG_NUMA, memblock_get_region_node() returns 0 for every
> region, and memblock_reserved_kern_size() attributes a region to a node
> by memblock_get_region_node(). Since allocations are marked
> MEMBLOCK_RSRV_KERN, the newly allocated lowmem and global areas enter
> node 0's baseline and are scaled again by bootmem_size_node().
>=20
> In the original 1 GiB QEMU reproducer, the default 200% scale made
> node 0 request 672 MiB: twice the sum of the 98.45 MiB baseline and
> 224 MiB lowmem area, rounded up to 32 MiB alignment. The reservation
> failed and KHO disabled itself.
> [ ... ]
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Reported-by: Kexin Liu <liukexin@kylinos.cn>
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029103425.1468=
9-1-dongtai.guo@linux.dev?part=3D1


