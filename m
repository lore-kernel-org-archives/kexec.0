Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E0606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WJGsAQtg;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEyyfGKb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=57V6s2DA2QuI3YTMeMjUYH5QdNawJY9LsrUvguSD+mc=; b=WJGsAQtgcdrJw+RI2iQ0RmZ7MG
	3Qw2VOGvVESxLxfqdoYhg1fK2cUY/aZ/rjqVqotGZ8ipJHp9+vCEuk6cKfwS0UfS4EvMwK9BqSKTd
	UZ5RguUp/JrubPk3SMQ26wcoph7i8UBbNBg78jshnaVP0POgyDIrsamB1XVo1VPIw1GhRowt/VhPQ
	1DIT2H2RGscS0hBk2V/LWtSYlvbDMeQJrmqlf8lai2DyXXguv5ZDO3V9jJeEkn74KTq95IShTKoUV
	yDihfQ2wXC1ateIhhJ+mAhOwPISdUsE7tMmuG4xkiX+EyNp8Un4j8t3XiujIEbvl4MZPeuO/MsmM0
	x1zPjRJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTcD5-00000008PtH-25dz;
	Wed, 18 Nov 2026 09:44:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTcD2-00000008Ps9-3vHW
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 09:44:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AF6E04562F;
	Wed, 18 Nov 2026 09:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B7C1F000C4;
	Wed, 18 Nov 2026 09:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995048;
	bh=57V6s2DA2QuI3YTMeMjUYH5QdNawJY9LsrUvguSD+mc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BEyyfGKbzZ+aJAPF5gaCcsUSCthAbh5vJGIC35vHL0oFaIsFrS+FuDi29JPizoRX9
	 srQhhD/PmXvpQaG3cbbAGAkNqwmB6cOUUpA7hijk905QxNKYK6AN+gHSeKAqhDbTpg
	 ZcEpn+QRNQPUBE3Bwo1OQL5z6SL2g1VtQpKqk770NyIJBrlsPKiWdPamz7LnWBaggz
	 p+kxcSoHxZQlcZ2LGiez5GiUGHOs2yUhEQ9GHBfMwsRck/4mB1UN4cj8Dp5+6kUWe5
	 Gt81h4++5M4iiqBFR3UuSFMNpvgHBD54O33Z2/fGRS95esLUiVRT+j7DAJ+VSccyel
	 ISjwX13H2XtRQ==
Message-ID: <sashiko-outbox-220614@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] riscv: Add support for KHO
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261118091603.979-3-cp0613@linux.alibaba.com>
References: <20261118091603.979-1-cp0613@linux.alibaba.com>
 <20261118091603.979-3-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:44:07 +0000
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

> The generic kexec handover (KHO) paths are already in place on RISC-V:
> the outgoing kernel publishes the handover FDT and the bootmem list in
> /chosen of the DTB built by of_kexec_alloc_and_setup_fdt(), and the
> incoming kernel picks both up while scanning that node. Only the
> architecture symbol is missing.
>=20
> Set it to 64BIT && MMU: ARCH_SUPPORTS_KEXEC_FILE is already 64BIT only,
> and KEXEC_HANDOVER selects CMA, which depends on MMU.
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091603.979-=
1-cp0613@linux.alibaba.com?part=3D2


