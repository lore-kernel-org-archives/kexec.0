Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B560A2614
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iHy3NpBV;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XITHLBMu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jhXhgN19x6ynOQ4DorhorwtBbN1wuclN4V1mUzl8nnk=; b=iHy3NpBVKoWPnt/DeJv8E3DBev
	HBEukKsHw16sv3+1E3fT+v/vTWbung6wOdC/pYHLo1r0UVO3Pqw//NnDXyForuu8LklCVbyDflG+A
	IxTYYgjfj+7CeZE8xwNsf9U7QDpkDh/Wgzg5KenlwS3/Di2BQrU+5BgueXd7yk2DYN2TOazOFTcRl
	7r7Tyt0wQrshcnHV0eQV/i63Mft2PMIJZsYT1H/6efFSTcJ4GVYYC2TILBd/G4Nk7SB4uMlvqvJen
	D5B6jtF2fr94uBxunxg/XHYpTguWXlzlfcSnUx4tLaIKqxE5sSh1C9o2h7TeiGYHqQOh9drYVZpKi
	MV/Q9zTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJiAY-0000000DAxx-2vzo;
	Thu, 22 Oct 2026 02:04:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJiAV-0000000DAx9-3jBI
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 02:04:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4999941705;
	Thu, 22 Oct 2026 02:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D180C1F000C2;
	Thu, 22 Oct 2026 02:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634675;
	bh=jhXhgN19x6ynOQ4DorhorwtBbN1wuclN4V1mUzl8nnk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XITHLBMuxjkOKzsOOJpYNsTSvwD5vFhNsmzSD5q6+dmwTIEyKenO6AX/HAotlW9Tp
	 usZuFN4Fz8kwIugyN5KOWBAXwqjUMQVs6yL/wwhthte53p05N00tPmQqjjG+uoJ3Gl
	 4PMCsDg9KE8Kz6+pwAl6zvCnC3eH5y/DYx3FhD47GFRcdEAhrv/ldM1xet5ADI+I/8
	 QNhbwry37y30q/ZKhmo1NAkZhxd7/36B8h/TQZZ48ALswFRi3a2dG/nA3nTmwceS/w
	 bRsawCZtWk02ERXfsBrG8b0oEemzGl4T4gov53S5XBdbpfqLQ+QKfg2Svkkjck1wC+
	 t202cg0vxPYlg==
Message-ID: <sashiko-outbox-180857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] selftests: liveupdate: Add tests for
 LIVEUPDATE_SESSION_FREEZE
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261022015844.2795816-3-pasha.tatashin@soleen.com>
References: <20261022015844.2795816-1-pasha.tatashin@soleen.com>
 <20261022015844.2795816-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:04:34 +0000
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
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022015844.2795=
816-1-pasha.tatashin@soleen.com?part=3D2


