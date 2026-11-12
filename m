Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF4606A880
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bIVaaDrY;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6PgRtqs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QAOHUkP8mSVb3HAPGFMParJEVsdRpkeqE84YURBdhqM=; b=bIVaaDrYz78EMbk4yPmeonOJ7M
	41/LN/GLHU8HxWcn9LdLY4cOnv7o4fI/8AerieB5+5BuzANrM58JE0Qi0OmtOz9/EonbTH2WBOC1u
	2pPybhgtsTV/msUlIRyI7b7GDe9UrIEf8/hKlfGBQYzclBx1rrJ4JvOJd6vMzjpXs2NnDYwTqnHrm
	074e7ODkRc2rqGy7J8s+u5gCVJL+/Rn1AEVzLF9hy5vUcRkLy8MPT9PNxFSFHBy33K334d08QSzZ9
	fCkNfYFDVvbLtY1dTvQQHza8fTF5ll0Mdx808DQkxQVQ2XbqF4MtF953+Yzk+hZTXlp+tP3f9G2Ow
	R1n4q83g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUTn-00000009x6v-2Svy;
	Thu, 12 Nov 2026 13:04:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUTl-00000009x6g-3SnN
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 13:04:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 128D446AE6;
	Thu, 12 Nov 2026 13:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC231F00A06;
	Thu, 12 Nov 2026 13:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794488676;
	bh=QAOHUkP8mSVb3HAPGFMParJEVsdRpkeqE84YURBdhqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N6PgRtqs29KHDXsQ7UeI69eCsrzwKzK8VTk/f3dgFq0YFPGbF0m03vVBQHTM6vZC0
	 KxgTM5SsaYi4tdYDwzOu+7exKRp/LJEEZhGvARa+QxPbM0Es4Qyj4ECCECCsLJj2Nj
	 AM2cg5Ylg7RAYsz1okzRNGVkRYu7QvmXHmsA046Nw7wpI6OapmSOQmjA/ZKlKEYUAz
	 ki6oKczTdol0SkmZKXoK0oLdzA5jLwDwqUdlwhMsOJZ3ugWHrX/UGsclXtCi2Z5YY5
	 vsLDlm5xORG0V7S/BitxOfJjOXOZgYwYoysEIZCIBaZnQ0s35v1sEo6uRIWWsUPSiy
	 ZrUIHL6smBQGg==
Message-ID: <sashiko-outbox-211136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] kexec_file: update IMA after machine post-load
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>
Cc: "Eric Snowberg" <eric.snowberg@oracle.com>, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112125246.2715174-3-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261112125246.2715174-3-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:04:35 +0000
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

> ima_kexec_post_load() replaces the global IMA mapping with a mapping for
> the new image. If machine_kexec_post_load() fails, the new image is
> freed but that mapping remains. The installed image no longer receives
> the execute-time IMA update, and the notifier can write the
> measurement list into freed pages.
>=20
> Call the machine hook first. Return its error before updating IMA so IMA
> changes the mapping only for an image which will be installed.
>=20
> Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to ex=
ecute")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112125246.2715=
174-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1


