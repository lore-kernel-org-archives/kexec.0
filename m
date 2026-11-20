Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ABF606A32A
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WLTUyyTf;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXz2gQPP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RYx+xi7eq1oNz1emmf+Z4S8q8VO7gJMhIfDfdxFR40A=; b=WLTUyyTfAhIguaYeflD3sxgIvL
	fyriqhQWMiWMxOPyBKEELyvC31Et2Xms3GWtEL91/6A07nCpWztWwU3jV8YOE8ZCKbXeig57d2oqN
	ExW4I5b6DJx3HhUl5d9cVqJZIXp10ktJ+kofmWV8vhpWcBS/fqiYfBFfuke70h1dEUfivx+CyeYWW
	FRycPH3aBKq4LGKztZe896OwSQ+F6YRwnxvT0dhUWfDRTICPSrYgFBXAcX5l0wBpZB/Stl8BYiIzV
	CZAqrrfISD8WgpfGVig1TIC4UjdtpEVJrjMnQVkgm7jvzzELGBr393ZahDpgmZmDLIyKTc5NEhLKt
	pisBVRcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJU1-0000000EHXg-3Iup;
	Fri, 20 Nov 2026 07:56:33 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJU0-0000000EHXY-2zA1
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 07:56:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E1F586182E;
	Fri, 20 Nov 2026 07:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4411C1F000C4;
	Fri, 20 Nov 2026 07:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795161391;
	bh=RYx+xi7eq1oNz1emmf+Z4S8q8VO7gJMhIfDfdxFR40A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZXz2gQPPh+EqDdymd69LndxfT5q05g0H4xefrTOFD5/k3e0fW9EnCl+us1yrwlVf+
	 YkbJfld9jvDqX7mqYsbQUBYEW5bWPnpmwjbN2dA7Wt74+5Tq6c1nlYFnXHbgCEJsll
	 vwZy90yfmgTPLm001XeHxUsciTteWXjRBCAsIboNeAe5+E8MJVp3oI1kRBO6swngKG
	 kKnvC4chEq67WH8GJLSKj4qxB26PVA933YctuJZDptZLoXO6XohJHDBZHy3CSsT583
	 Q+sauyTuSP4NAMpoGAS7l7HrAae+Hqnrkw0uU5z7uvKYlShlpmfYZzLxOmftEKJ1Ld
	 mmDVyADft8FMA==
Message-ID: <sashiko-outbox-224665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] liveupdate: drop redundant lower-bound check in
 luo_session_ioctl
To: "Xiaotao Zeng" <zengxiaotao@kylinos.cn>, pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org
Cc: kexec@lists.infradead.org, duanchenghao@kylinos.cn
In-Reply-To: <20261120075252.684604-1-zengxiaotao@kylinos.cn>
References: <20261120075252.684604-1-zengxiaotao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:56:30 +0000
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

> nr is unsigned, so for cmd values below LIVEUPDATE_CMD_SESSION_BASE the
> subtraction nr - LIVEUPDATE_CMD_SESSION_BASE wraps to a large value that
> is already rejected by the ARRAY_SIZE() upper-bound check. The lower
> bound test is therefore redundant.
>=20
> Drop it so the check matches the one in luo_ioctl().
>=20
> Signed-off-by: Xiaotao Zeng <zengxiaotao@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120075252.6846=
04-1-zengxiaotao@kylinos.cn?part=3D1


