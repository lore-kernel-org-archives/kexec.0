Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06731606A319
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RM9Dg2fH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PlFU6zRJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kjHOdY22MN6pbOJTq4d/1oLyvSDaQLul7CW75DferAk=; b=RM9Dg2fHC1gxdf0+qtUzywNjmc
	FLmpqZ92+rveUFolDQeAVK7dlGx0te5IShosDvZ6fstWLsLWnpjQKDHJH2/UHiVU8qGjCOfkFTef+
	hHoM+ggPtHmWT+yhMvxFOp2wPn5EFDP7N+b1/mF2sFJpLmfoqLDJSG7mkymwulB6AcmGF9ci6MNyj
	0Kkw6TbOyxvauzPLvLiI1R+7D8oi3wn2so3sSJvdTDPKpT1YvukX4TcOxgE5kqD9nBK5vnt5AIHRx
	aEO+sH4tcw0p0OnV2R+Vx9a9jryCldq9rI/02gXKs4m5Ydy1UMNYOPduO1/ZNp8w+mQ5bAPXeTxK0
	4NnXsmcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJoEe-0000000DfwV-2VdL;
	Thu, 22 Oct 2026 08:33:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJoEc-0000000Dfty-3wmX
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 08:33:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 640FD6057A;
	Thu, 22 Oct 2026 08:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F211F000C2;
	Thu, 22 Oct 2026 08:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792657994;
	bh=kjHOdY22MN6pbOJTq4d/1oLyvSDaQLul7CW75DferAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PlFU6zRJzjofwx+C2dvyhsbF/Q9SsZIm3IKiwyYJ3Cljg99oK/8YihIm0kg3NzMap
	 2lwrf30Lr2VYrxwfhKTJua3XZtjA7IOB/E64/VwCyEzWiFGa7EZToXz/GRSEWHv8d1
	 h4ZSA7REJ1XLysLEWyjHVpCeMFVUApHPxUzariFVu4GLVAYwjASwMTtA26Edpdn6AQ
	 Cm6rXuxXvLl4MJNJnMAw+K0cbJiQ44xjelnyzLi5fGY0DZSdazVUwINvbvRsOwGdsb
	 2BQ7FezwmNmJfFN6/cob+dUD7TYuVksmuXVgdcNIFOlZhP74ue+BGjTUuEabI7vSjN
	 j3Gc5UVXv7Gjw==
Message-ID: <sashiko-outbox-181181@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/8] memblock: introduce MEMBLOCK_NODUMP flag
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, kexec@lists.infradead.org
In-Reply-To: <20261021083011.2170525-6-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021083011.2170525-6-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:33:12 +0000
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

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> Add MEMBLOCK_NODUMP to mark regions that should be excluded from
> kdump vmcores.
>=20
> The flag is meant for reserved memory that carries no data useful for
> crash analysis. Reusable reserved regions such as CMA may hold useful
> data, so these regions must not be marked MEMBLOCK_NODUMP. Subsequent
> patches wire this up for /reserved-memory entries.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021083011.2170=
525-1-chenwandun1@gmail.com?part=3D5


