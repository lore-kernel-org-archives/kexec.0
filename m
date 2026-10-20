Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C0606A328
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uU8ektmk;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k/ga6WF+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QuoJwrzfaeEyHDMqRpkWNSXjdoub6etSxoTDCL2evho=; b=uU8ektmkgOObj4V/5CiY4JZqhc
	PsCBSyyWnHoBl2oWa2g37i/UneHrNth1mEtWLJLqHIrkMpWLwr0oHeYTyAJ/4NctgrJjClRJhTL2f
	ebEkXctlg4fwyKzf8Uk6xXMEi6I2aCqywlrtX7FlquxlklOGURcxpNkL8PpZh3OmkPEfScVqBc9Tz
	/bOb8Mz/ytzUWarjWyf7u9FJdolrFSDodAPznhWGUJ4CTLKjFA6/7PfH20adsJze9khmfotxQfT8O
	EkJit0O1VfO6+FKB0u+D8MsH2MwKI41gQoDjQxNS0hRwdzD3o1PWDo5K4jfb8E56Hy0jLHdefVmO6
	iU8fuzKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJBCa-00000009zpP-3Wq1;
	Tue, 20 Oct 2026 14:52:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJBCa-00000009zp0-1Dc8
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 14:52:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AD79C43AD6;
	Tue, 20 Oct 2026 14:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CCD1F000C7;
	Tue, 20 Oct 2026 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792507951;
	bh=QuoJwrzfaeEyHDMqRpkWNSXjdoub6etSxoTDCL2evho=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=k/ga6WF+Bh2qG9YwF/5fJaKvGG8OK39VCU52LbpBJUcAifJmR+a6dewqrpQFaROc6
	 RZmaUPKRo2kWLp7KdteSnjL1CDGuy0MCktTGWpF8/wWXyK4GNLC408ff8f/Jgr/zl2
	 TOQDzntYfp6Irct/SB2XGZM2Hb5d+EPTyv9tH+Bro3EdMuOxdCWgBZe2wL2a9OgdTe
	 hNbyDyThyEC7veaHpGvIgMmgJ80reKTGk7BKy1pV2x8JUy70M4yL90/TpsmPG0fNe6
	 /9CqXCmmFbKBCOs1xq0sqI5kr4fXsLnmzFVyeucC+WcF1nOsb1hyE764v3xpyYe4Uk
	 YuXXUB57Ug1Gw==
Message-ID: <sashiko-outbox-179199@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] selftests: liveupdate: Add tests for
 LIVEUPDATE_SESSION_FREEZE
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261020144710.4154339-3-pasha.tatashin@soleen.com>
References: <20261020144710.4154339-1-pasha.tatashin@soleen.com>
 <20261020144710.4154339-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:52:30 +0000
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

> Provide luo_session_freeze() in the liveupdate test library and add unit
> tests in liveupdate.c covering the LIVEUPDATE_SESSION_FREEZE ioctl. The
> tests verify that non-zero reserved bits are rejected with -EINVAL, an
> outgoing session with preserved files can be frozen early, freezing an
> already frozen session returns -EBUSY, and attempting to preserve an
> additional file descriptor into a frozen session fails with -EBUSY.
>=20
> Also freeze the test session early in luo_kexec_simple.c to exercise
> LIVEUPDATE_SESSION_FREEZE across a kexec reboot, and verify that
> attempting to freeze a retrieved incoming session returns -EINVAL.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020144710.4154=
339-1-pasha.tatashin@soleen.com?part=3D2


