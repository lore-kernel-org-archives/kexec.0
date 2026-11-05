Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F043606A32D
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e7f0J8CG;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CkQcS1I7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oDlmtBhgomUPqiZyazrw3tUkObhqK+9ogHz/6XWWKto=; b=e7f0J8CGaEGHirUlVn7bCMH34p
	PffU8qKD9DWPHiFOR9zkSIhqdxRaw20fR7lFWdaWynmkU5SnKMUO4CY5EEA43Z5nRJiJlVjwjo9lK
	oxnz67v+QTsjesJUMGlVS316jN2+kaH56bLomn0dM6LSX8DXl0ZcXrFinQa2R98bY7IsfmOLhL4ls
	0mYUBHVqs2SewScT3PSfbaUrCFR1v1On1uYBizlfWQUsqw8Kyny6gz4/MzhUH1WerxSPf7ZbLQaZB
	GZOOp0zGnnNZre98NYapgU2pc/h2vku4cqCE5X2TBjaHFhjoS2IbQ62Hllqlx4nrlz07vD6o2PfS8
	vK1pJodA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOx9A-000000093e9-4BHV;
	Thu, 05 Nov 2026 13:04:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOx99-000000093cC-0qcs
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 13:04:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A1DF1419AC;
	Thu,  5 Nov 2026 13:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3411F0093A;
	Thu,  5 Nov 2026 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883890;
	bh=oDlmtBhgomUPqiZyazrw3tUkObhqK+9ogHz/6XWWKto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CkQcS1I7NeTJRxM/5do6GZ5zblnTyhInKphurUtRSflzFpKChzy3s9EnmP4p23r1a
	 YcDGCGVIjXT/YGRQW/h/uaD8ssnodT6sPPqLu+pypTWtJ4lG1j9juZCNe/yB+k9SvA
	 B+rtEVE1FdAP5SMcTRl9yzFTn52VUBgBAV1/RQsfyNX3R492OCpV64LLUq8fUoE0ec
	 rW9cU9q9tE+6nkDtldJWfjbrgcb3dg+FK01s6u5IAFHU1eyZNRylBD1WYD2pA+N+kL
	 6duT7HW/GduKUe4I2FA0ywulWJ11QpLDCEkUqQJsnNTvCeLXhGEd9Vgmb6tMsejTEa
	 SB0TMR9Mx/v2Q==
Message-ID: <sashiko-outbox-199114@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 2/3] selftests/kexec: select tests using the
 target compiler
To: "Sasha Levin" <sashal@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Shuah
 Khan" <shuah@kernel.org>
Cc: "David Woodhouse" <dwmw@amazon.co.uk>, "Nageswara R Sastry" <rnsastry@linux.ibm.com>, kexec@lists.infradead.org
In-Reply-To: <20261105125701.1605281-3-sashal@kernel.org>
References: <20261105125701.1605281-1-sashal@kernel.org>
 <20261105125701.1605281-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:04:49 +0000
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

> The kexec Makefile recognizes PowerPC only through the ppc64le spelling
> of ARCH, so the canonical ARCH=3Dpowerpc used for cross builds omits the
> tests. The x86 jump test is selected with IS_64_BIT from
> scripts/Makefile.arch, which describes the build host rather than the
> compiler being used. On other architectures the Makefile includes no
> lib.mk rules at all, so installation and runlist generation fail with
> missing targets.
>=20
> Select x86 and PowerPC from the target ARCH when it is given and from
> the host's SUBARCH otherwise, without assigning ARCH, so that lib.mk
> keeps choosing the compiler's native clang target. Ask the selected
> compiler, including USERCFLAGS, whether it targets a 64-bit x86 ABI
> and whether it targets little-endian 64-bit PowerPC. lib.mk expands the
> generated program list before it appends USERCFLAGS to CFLAGS, so the
> flags are passed explicitly to keep both probes consistent. If the
> compiler cannot be run, select the jump test so that the build fails
> instead of silently dropping it. Include lib.mk unconditionally so that
> unsupported targets build, install and emit an empty runlist.
>=20
> Fixes: 65e38e32a959 ("selftests/kexec: Enable secureboot tests for PowerP=
C")
> Fixes: 7615b94b6371 ("selftests/kexec: Add x86_64 selftest for kexec-jump=
 and exception handling")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105125701.1605=
281-1-sashal@kernel.org?part=3D2


