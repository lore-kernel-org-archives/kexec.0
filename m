Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DCE606A31C
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cqLG94JG;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oca6mWTB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=W700b5s8KiMkhov29D/Y1x2mk9mtS9WQJC6wHJxk7+0=; b=cqLG94JGgqT4/tERk+BgTazLql
	tcZGt6uwJsl6wTTqXOHCPM92matpDMr/f7z65z6VgN6s4JYz3Y+/B2ihpenZX2m3izACaMKdyjzCK
	h9L/8dL3+Cf5RbFGpnRPvzh/DhFTRqXS8oXzJ5YAMj9LyRLKsxygXtENs+uGouirBHGZ/MDTG35O+
	qQny2220BCUjfAdg56skVgUaQYoZyPK9KgubET1V6GGgnK8QEgzbqFsKiIBRa3tLwtGSFVuqpdgOk
	6qYD0gnFdQgm8nwsF1mau/cwImoBNPRvO9NncRUpKZTBexT+V9pGsJLYASGyvVOG9MTI6JhDOXJ20
	zWclkA4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVeg-00000001cCj-2tW7;
	Mon, 09 Nov 2026 20:07:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVef-00000001cCD-2DZ3
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 20:07:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B31441411;
	Mon,  9 Nov 2026 20:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187741F0089F;
	Mon,  9 Nov 2026 20:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254869;
	bh=W700b5s8KiMkhov29D/Y1x2mk9mtS9WQJC6wHJxk7+0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oca6mWTB3dQNdjbWLB8CKKA0PvVeN1ymZcJ1qA9YuDVXWu4udObfW1RhGT3MDHf+2
	 i7+hDUIDo9UIgpRnznbzYJgIS35HOkVDgjRworq0rhL7EVUeD63ZgmzeSTyEprOLl0
	 U4eFRK/YYC+1aejzh8+GYrYqJgjXNfh47oH1VHKesejXfp9EJDr6oZh+9B7Y3kwCrR
	 6cdbejV4AQQw1sJ1tsJiR82spMiqrtq7qgIYGwagDKUvFUY5fdX70Tn5dEYo+oNajL
	 rFHvPWsTET3oeQqkZCgneCRUPiJ15Fco5tE5VGfW64lOXji52xKpJD5o9oEZ3rTHZ4
	 MHE+DQV6iHnOQ==
Message-ID: <sashiko-outbox-205540@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/hugetlb: allow crashkernel to reuse hugetlb CMA
 memory
To: "Usama Arif" <usama.arif@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, muchun.song@linux.dev, osalvador@suse.de, david@kernel.org, jbohac@suse.cz, sourabhjain@linux.ibm.com, ruanjinjie@huawei.com, leitao@debian.org, kexec@lists.infradead.org, kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, zaslonko@linux.ibm.com, brads@mainlining.org, kernel-team@meta.com
In-Reply-To: <20261106165142.2847916-1-usama.arif@linux.dev>
References: <20261106165142.2847916-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:07:47 +0000
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

> crashkernel=3Dsize,cma reserves a separate CMA pool. On systems that
> already reserve several gigabytes with hugetlb_cma=3D (which is common in
> the Meta fleet), the crash kernel cannot use that existing memory as
> part of its working set. With hugetlb_cma=3D6G, requesting another 2G
> with crashkernel=3D2G,cma brings the total CMA reservation to 8G, none of
> which can serve unmovable kernel allocations.
>=20
> Use existing HugeTLB CMA memory first for crashkernel=3Dsize,cma and
> reserve dedicated CMA areas only for the remainder. With hugetlb_cma=3D6G,
> a 2G request reuses 2G without reserving more CMA. With hugetlb_cma=3D2G,
> a 4G request reuses 2G and reserves another 2G.
>=20
> The full HugeTLB CMA pool remains available to HugeTLB and movable
> allocations during normal operation. After a crash, the capture kernel
> can use the selected ranges as working memory. The conventional
> [ ... ]
> CMA alignment, and report any shortfall. Ignore malformed optional sizes
> and reject requests that would overflow page rounding.
>=20
> Suggested-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106165142.2847=
916-1-usama.arif@linux.dev?part=3D1


