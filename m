Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95467606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aF1ehC+Q;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jc2W+RKT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DHRLcWcplobWklM9RNdBWIVkEOnF4e5sY48egnPpvuA=; b=aF1ehC+QcZGa8LvYoA+qHIpx7e
	K1w+YwEpaVe8TMumqlDOYpXfmNHTvF6gOWH3eRPcLWVefqyLOj2l1tRMwGsllPWSHjNhV0Pjbx2OZ
	+DlahgbzPa3jgTi8PY/MehlOAu51pc2EPW+FZB6qgH67qyLh1u30ldPWZffqitTIaDDUzlPY+L8QE
	S7Gq6tDfu4HRp6jNETBBnUcHYLg4HP73eNAO2UMHaXjGE+UoWGlHoUmOEUdbBfCtJ0bauE6n/g1ip
	NopsWiMsH2E/u0VUeN0LJdw2KAHvK2NDmSHVxzgdSRAxL8PiFxGrb0v7LitnTeAflEohRJVhqd7gq
	WRrrXWMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXvx-0000000AfFM-1v7E;
	Thu, 12 Nov 2026 16:45:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXvw-0000000AfEq-0yJf
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 16:45:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C9A8B404B8;
	Thu, 12 Nov 2026 16:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB5D1F000C4;
	Thu, 12 Nov 2026 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501955;
	bh=DHRLcWcplobWklM9RNdBWIVkEOnF4e5sY48egnPpvuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jc2W+RKTyvCajaqlfScYQfmdoFbm06EutfhW5sh4ob8Dqw0PJo830WHGbiiqLukIS
	 HzF/r2Um/yB/SA/KV7hJoqg2d7qNcONW7BVDoM1bUaA+X3iPpfF/dOvoQaRfQYFiyZ
	 us7amNut9g1Cjn7at+WKpOXh0k4+AAr+eyulxGLannm82pnVreCpMTqulc3LM9U3vN
	 LuGSYFTq3AkrHw3sGCthGowXml2M1ecsfn8R9rWR2R5I/WOfONcIXZzLzkSlnjrgKa
	 Mkm+PIeNrPbtgz3shxxwd9WkUGSOV/JcCLtqWeA/9G1zQAI67Uwbis7eLn2le0m6Wr
	 QMHF4Njwcc56A==
Message-ID: <sashiko-outbox-211531@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in
 copy_oldmem_page()
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Breno Leitao" <leitao@debian.org>, "Chris
 Mason" <mason@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, "David
 Hildenbrand" <david@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
 <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 16:45:54 +0000
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

> copy_oldmem_page() maps a page of the old kernel that isn't in the
> linear mapping with ioremap_cache() and copies from it without checking
> whether the mapping worked. If it didn't, the copy reads from an offset
> into the NULL page. That oopses unless the copy happens to be a user
> copy, whose exception table entries turn the fault into a short copy.
>=20
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns that into -EFAULT like any other short copy.
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_pag=
e")
> Cc: stable@vger.kernel.org
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-work-procf=
s-oldmem-v1-0-ecdcafd99265@kernel.org?part=3D1


