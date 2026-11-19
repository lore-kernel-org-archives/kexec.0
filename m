Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DFD606A320
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sWRlG++5;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSgVZYYN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kRMMyLepfhmQuZMScgXg7oFuwK80OTXeZecTq6+JlA8=; b=sWRlG++5on/6A1VtvdZiGlghCu
	aL4M+58Rk90mZLJKOrOVMSfr8CNT4hbS+NdiPrhh2m0rtNrU9Q0x2RCSgVe4LIOeLClvczdGrRbb8
	Z8DsiQ1Pc9C2yP6CKFmMxLQjhLgXfDxOZKGSg3RQwqdslNhbXHBQJtaFIDE0rSxdaf4eas/Idxmhi
	31hI8MLsPj7U/OUojXgxMGuXtWr2IS5hdjZ5bVG2CjOJVUCNjsldIgsZrxVxChnFsd1VUv/NIv4xM
	iKVEH5LJdVIf0D5TfWrYq9FKqjf/E/5WGRQhy7znESc5VyW216WE36wI8ZriYd9fyxUyJSrTF7HU5
	11Z/eoFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTvwu-0000000B1Pv-1Wbb;
	Thu, 19 Nov 2026 06:48:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTvwr-0000000B1PG-2jpV
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 06:48:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1725940141;
	Thu, 19 Nov 2026 06:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66ECB1F000C4;
	Thu, 19 Nov 2026 06:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795070925;
	bh=kRMMyLepfhmQuZMScgXg7oFuwK80OTXeZecTq6+JlA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fSgVZYYNjEF6ThygczhdXkYoSq2rxuM+c1G4pCVfAycnywa/dqUu6p25ky1JXZeP0
	 1EKnfWeEVF6yiKbgg54iHb76CFC9+LvTjLfozg0W8Sh7/dK9guWzvoV2QaHMu3Thkv
	 7+I0dcl+Ge7aAthfKAu3x7mrtT52NXsrq3OKW8JV15EroF57kdalXyA1FqwkyUOuaD
	 458M35bJXlH79zs4NUb2g9OUi2IQ4GURosBP7IW2CxyP/JBvEO/Tc3fSyN65VrJKMc
	 AwHLYmJCscN3c6R7AjlkOVutqVd/6Khhd7/JLpS42OGlTXl7TLnvzk1hug28kVrHSI
	 F9n8JdQ8rcBFw==
Message-ID: <sashiko-outbox-222529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] docs: kho: drop kho/in/sub_fdts description
To: "Long Wei" <longwei27@huawei.com>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, akpm@linux-foundation.org
Cc: graf@amazon.com, leitao@debian.org, corbet@lwn.net, rdunlap@infradead.org, kexec@lists.infradead.org, hewenliang4@huawei.com
In-Reply-To: <20261119063800.698863-3-longwei27@huawei.com>
References: <20261117092951.4017931-1-longwei27@huawei.com>
 <20261119063800.698863-1-longwei27@huawei.com>
 <20261119063800.698863-3-longwei27@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 06:48:44 +0000
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

> The incoming sub-blob debugfs directory is gone, so remove its description
> from the KHO admin guide.
>=20
> Signed-off-by: Long Wei <longwei27@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119063800.6988=
63-1-longwei27@huawei.com?part=3D2


