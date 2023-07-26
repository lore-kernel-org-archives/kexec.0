Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAEAC001DF
	for <kexec@archiver.kernel.org>; Tue,  1 Aug 2023 06:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0+Q7BcIS3qVhhQD8LQ0CQTgv1nFy5BcKDdVGvw2bpIo=; b=2JatPs2vCk8RsV6/hZb19BlFuy
	GoFmP5kkrre+RgvLu/y5xWnVjDGNRNySDZiVNcU9R740y+gdXismLUE4fE/FZwyKnILaS4l4se6k9
	wmvMwfM6Xqrs+dSPZK9NeOaGAXM4vmo/cFi8s2Cx7xhepvIULPzPauJGYzSND4h8N2HdMRHoVkxJf
	51jqH/iuaJfT4LuWYdB/Nj43vHPXSnf0dYxzBNHg9nd7qYDH6V2nUdFo+NXGi93Qv8OOYJrKPnxvz
	4+bL50kSInwWQgmecSZs9bBtBKuANdTcZ2+CdOvFS1feVyRUDAueiGJ9sfElCVwVf0cPgv/cas7b3
	XzFV4t1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQinT-000Rcu-0k;
	Tue, 01 Aug 2023 06:23:55 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOhSW-00B0zo-0f;
	Wed, 26 Jul 2023 16:33:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AE95561BD1;
	Wed, 26 Jul 2023 16:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57627C433C7;
	Wed, 26 Jul 2023 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690389235;
	bh=qu98mFypzryfpNaKpoZ+to2I3RSD5K9vRrssyVUA0yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D54mej26YFHACyW3/VOA+ZMi36bsP/fou7ZveiThS03CWvwwpJN/kdUnKqSNHiFJP
	 FKS9xAVPUOTubYpjQIKpjkfmAuQtTpL5Aqakr9L257D1bsF/6THKz4UC9x0P16oMRB
	 9oPeimDouzi9q/Wo3+554QvmYQNKafyxGrnYBjCq0UICUO4Hh8BkYSHnM93w0hJyt0
	 WRmeAWylRa/zCCPNi3AzeeM6zGzeTYuR2aA9KQMN9cTtJj+9bZrcjmVG+udwROFsIs
	 4S6p/YUV5CCDWmweF5n1kRHjgdPpCZd/+j0cpig9S0pQCdhtdds1c800KpH6GH1k4u
	 hh/OCaAABboWg==
Date: Wed, 26 Jul 2023 17:33:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Liao Chang <liaochang1@huawei.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ricardo Ribalda <ribalda@chromium.org>, Alyssa Ross <hi@alyssa.is>,
	Li Zhengyu <lizhengyu3@huawei.com>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	kexec@lists.infradead.org, open list <linux-kernel@vger.kernel.org>,
	Torsten Duwe <duwe@suse.de>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: Re: [PATCH v2 2/3] riscv/purgatory: do not link with string.o and
 its dependencies
Message-ID: <20230726-excavate-swoosh-424ede98f63d@spud>
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
 <2832b3e5ac781a0c0ade9d77b15a80e7f2fb4ab2.1690365011.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
In-Reply-To: <2832b3e5ac781a0c0ade9d77b15a80e7f2fb4ab2.1690365011.git.petr.tesarik.ext@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_093356_288657_3775E097 
X-CRM114-Status: GOOD (  13.45  )
X-Mailman-Approved-At: Mon, 31 Jul 2023 23:23:50 -0700
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5401951964859408950=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============5401951964859408950==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1Yc8XiDptGjnzByY"
Content-Disposition: inline


--1Yc8XiDptGjnzByY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 11:54:00AM +0200, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>=20
> Linking with this object file makes kexec_file_load(2) fail because of
> multiple unknown relocation types:
>=20
> - R_RISCV_ADD16, R_RISCV_SUB16: used by alternatives in strcmp()
> - R_RISCV_GOT_HI20: used to resolve _ctype in strcasecmp()
>=20
> All this hassle is needed for one single call to memcmp() from
> verify_sha256_digest() to compare 32 bytes of SHA256 checksum.
>=20
> Simply replace this memcmp() call with an explicit loop over those 32 byt=
es
> and remove the need to link with string.o and all the other object files
> that provide undefined symbols from that object file.
>=20
> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>

This version keeps the automation happy,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--1Yc8XiDptGjnzByY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMFK7AAKCRB4tDGHoIJi
0nywAP45WUTUj6aGAMM66t2i6LtknIHriZ5AtX22HuqEfK8W3gD45i6hU1k0jKxD
iBzfCHatNLhnBRoYTPRflCChJJDBAA==
=pFZE
-----END PGP SIGNATURE-----

--1Yc8XiDptGjnzByY--


--===============5401951964859408950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============5401951964859408950==--

