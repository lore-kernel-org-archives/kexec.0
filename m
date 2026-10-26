Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B89606A31B
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VEOtYVEM;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UkLFfKrj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CeUIauYH4vhzlw+Pt9b+jo+fkjX+6o8RVCGLQsTQuqw=; b=VEOtYVEMd9Kyu9fp1i3YZF+0sv
	YsXQQTqqT32skYhqKhQtkt/Zr449NNYJH3KYeAqPXmfWLXgJTU/4PBhA6Qi4/FO3YRw/bBRHBODgx
	HjPTmMzM8Lc6OV9ffzDPNppTK11boqW+gRDF+7vMawWeWYSBVXBOlDhp1+AfZZDXAoQ1GiW3jBQ9A
	bNDIhWBSY7CHxwWLTEpYEsIkPucvYF7oVqe5saifuYT99YjFyVItFfDFL6sZhDsoSYVECOjCtuglf
	Q0Y+1pJd300kkCrdQR4RhOoAkOergxL198SUr0MZVsqMqDc9Vqc3aXsVJ+UzzVve95BSH/ILJG4DP
	UpwVDSPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9vK-00000001aQD-3oiv;
	Mon, 26 Oct 2026 01:54:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9vJ-00000001aQ6-3b0H
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 01:54:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 51FC04357E;
	Mon, 26 Oct 2026 01:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC07F1F01825;
	Mon, 26 Oct 2026 01:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792979693;
	bh=CeUIauYH4vhzlw+Pt9b+jo+fkjX+6o8RVCGLQsTQuqw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UkLFfKrjnatvEZU2JLeL6O4EllXJagc/CQFTUlrcoq7UQEU4qOmU4CZfwsWLrLmzy
	 mRy5wjPlV4rTQ8E5QF8k7RJNdVNRBkWhBDHpTTtk9kPKRk9k7D9nDQhatWj1pxBO5j
	 84eYPGyqSPdHorTHtvo7XuIU1GVWOBzoKtsh5I0p1vEIekhPkA8JFptWLNPAwFLYje
	 B9LIPJYfeaf8Q0CJ2TKvGgi2q1hiPtHZfptEfnn/xC5LS89sxYsROCS91GKVG/br0m
	 EinNEaLGW4/PLDxbAEU3QvNqt+PuPFcZWA7UZ8M01HK11533O5q36jXRq0YfA63hs3
	 0kgaC3G2LlDbg==
Message-ID: <sashiko-outbox-184589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] liveupdate: Move file_set_ser handling to
 session serialization helpers
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261026014948.162559-2-pasha.tatashin@soleen.com>
References: <20261026014948.162559-1-pasha.tatashin@soleen.com>
 <20261026014948.162559-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 01:54:50 +0000
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

> Currently, struct luo_session_ser is populated and cleared across two
> layers: luo_session_serialize() writes and clears ser->name, while
> luo_file_freeze() and luo_file_unfreeze() write and clear
> ser->file_set_ser.
>=20
> In preparation for allowing userspace to freeze a session explicitly
> before kexec reboot, luo_file_freeze() and luo_file_unfreeze() need to
> be called on session->file_set before any struct luo_session_ser entry
> is reserved in luo_session_serialize().
>=20
> Drop the struct luo_file_set_ser pointer parameter from
> luo_file_freeze() and luo_file_unfreeze(), and rename
> luo_session_freeze_one() and luo_session_unfreeze_one() to
> luo_session_serialize_one() and luo_session_unserialize_one() so that
> all fields of struct luo_session_ser are populated and cleared in one
> place.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026014948.1625=
59-1-pasha.tatashin@soleen.com?part=3D1


