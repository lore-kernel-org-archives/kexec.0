Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F7606A31B
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zHq2jwRT;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SpObzaeO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0gwt6Ynp33uPT9qKYNGSAYnSSq3jTikCgaJyvlI74z0=; b=zHq2jwRTvYEHtuLGPTL11YxO1C
	ZzG588tyeM6ozFFAoqvEZ28aJ0kNJQm6X80DgU3a8/wx+S4yK9DAFfOijnVsm6xPeHm24eMKF5mOe
	UDuTRv+QVB3PecTnWOG0kyPirvRw14QBql1S2DS9fgJ0mF1GrmFapOkgRmmIEArsXfa1weE0qRAie
	0EtsKakFTlf8hEC5I0AVufRV5F6btNM2KiHmj8wBJdADjIMy/5ljuuT9R4zahWw8sOJAZ11HyYv0j
	jfe96Ko7eUoFnQDEyYZdQ5SnSrYG7LznpV16Pk5WLaOtljjOPxYeTZs5Gx/YZxIjkRTSkX8ciXdHO
	KQztd2yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9vN-00000001aRK-0bKN;
	Mon, 26 Oct 2026 01:54:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9vL-00000001aQc-3YM7
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 01:54:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 99F5F43693;
	Mon, 26 Oct 2026 01:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141CD1F01825;
	Mon, 26 Oct 2026 01:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792979695;
	bh=0gwt6Ynp33uPT9qKYNGSAYnSSq3jTikCgaJyvlI74z0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SpObzaeOflt9vuWb9uM92IB8v3iDGc6qlUPP291C0ztsyeE+TJ28xVpzCS3KqiSXy
	 JcI+DTmgjdKea7rsDo6DzREJe9VYlR+JIOZvy+0KFwwTcM/Ugse3ruuLmeeI6VEB5G
	 VPk1Oq/HEGUIbqsmWZqS/XI/OBwrK1XlMfQcReMC+RZy1aHyZ8iGJWoXqK4HuUvOpw
	 b65FNAisMb6Vq+pCk/CXtpRErZlnKbf5z8yXRm08BgECJ6oKP+jgnaRiSdOirKkKdN
	 D6Kj9sR7blLGZaQPBuD/mBx0ppeSxOjho42R6te2ns+ITvExrr741NSQNHuHAtwDr8
	 aYVs4hMqLxBQA==
Message-ID: <sashiko-outbox-184591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] selftests: liveupdate: Add tests for
 LIVEUPDATE_SESSION_FREEZE
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261026014948.162559-4-pasha.tatashin@soleen.com>
References: <20261026014948.162559-1-pasha.tatashin@soleen.com>
 <20261026014948.162559-4-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 01:54:54 +0000
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

> Add a luo_session_freeze() helper and selftests for the
> LIVEUPDATE_SESSION_FREEZE ioctl, including freezing a session before a
> kexec reboot in luo_kexec_simple.c.
>=20
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026014948.1625=
59-1-pasha.tatashin@soleen.com?part=3D3


