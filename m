Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF8606A336
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=g4mECGnE;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljaSl9hF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=agNKstLXJEXNp3BKeTYt5YjcSGhrhzJiaNPuo7/BBRo=; b=g4mECGnEeRwgn3kUnHBODP+vrY
	v0wrHU+88P3ihO20KGtocJYIDvg2mvRXTLRf3D8XXnt+z4xJ7PQmkSQ+8UfHRdcc/xfhz1pDztiTt
	j1rHwNyUWgvOll0GrCHHWAT7gE1ugJivH8sao3a5Thcc5UyqN6OibOu7VoHXZMIWe8T6Wr8Tqpy28
	l3EeWJzlQQbaAgJbGkivKI4XzkRu7TEveQt+oaPWCmugQRFFzDqazKT4AJYEWX+CwrhgjMinLVf8D
	V0lwwX1AXqtKyU11P3/0Sg+Ti5j7NP2KGzMvweAbeIosQ9uX/QUFms8rbiSdPDHZLSyIK5AFSFalr
	A5H6+ZRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdi-00000008yzR-1u0V;
	Thu, 12 Nov 2026 07:54:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdM-00000008ymy-3vFT
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 07:54:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AF72941FE2;
	Thu, 12 Nov 2026 07:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF291F00A06;
	Thu, 12 Nov 2026 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470052;
	bh=agNKstLXJEXNp3BKeTYt5YjcSGhrhzJiaNPuo7/BBRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ljaSl9hFiGsUT+W3Q61qKHS565ziHtNC6CdA8JwuxqtdyNPrZduFArqxECYMEhM2J
	 CBJRXEvnBo0MntojSjBfwvfDYwTZt/D63uvQdLdhpTANk1rZQbheKPTB/jRmuxge6z
	 NGIMpuAEtPdEiIi1m0BuCAaSlAFAl3J3BQpCidi4JaTkZw8O9//0joXfEDlB3Ids1L
	 dGkOdHU7HJ6I2AbkCY6mVTWneNmN+uFtZic0HYhTBgzV6NW93AZEW5rmCYs/uSdxnN
	 /vAPXbZiGfOaTJLDjGR3AUeOYTVbGTkegvxYQwarAy4adIUN92Ywaz0L+kmY7u29ka
	 1qP0FcOzTux0g==
Message-ID: <sashiko-outbox-210642@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] kho: Expose rejected handovers that look like cold
 boots
To: "Chris Down" <chris@chrisdown.name>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Alexander Graf" <graf@amazon.com>, "Baoquan He" <baoquan.he@linux.dev>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, kexec@lists.infradead.org, kernel-team@meta.com
In-Reply-To: <abfe907e8da92802cd5e0c843d8013e4d229aab3.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
 <abfe907e8da92802cd5e0c843d8013e4d229aab3.1794383544.git.chris@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:54:11 +0000
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

> At Meta, our rollout needs to stop if the new kernel rejects the KHO
> handover. For example, if it doesn't recognise the handover FDT's
> compatible string, it can boot normally with all the preserved state
> lost. LUO's incoming/state reads "none", as on a cold boot. We log
> "disabling KHO revival", but our fleet collector reads procfs and sysfs
> and can't rely on kernel logs from every host.
>=20
> Let's add /sys/kernel/kexec/kho_incoming/state so the collector can tell
> a rejected handover from an ordinary boot. "revived" means the kernel
> accepted the handover and completed the preserved memory map walk. LUO
> reports the outcome of restoring sessions separately.
>=20
> Signed-off-by: Chris Down <chris@chrisdown.name>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794383544.gi=
t.chris@chrisdown.name?part=3D6


