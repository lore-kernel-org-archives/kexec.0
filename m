Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E989EC04E69
	for <kexec@archiver.kernel.org>; Tue,  1 Aug 2023 06:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FwFZuqviMTq8GoVPx8eOG3q/SlpEe0upWNiuRc7udtE=; b=pGDpw0Smz9fC8KaSP6EECCBFJe
	12HGwt7K5VX6LJ8G9DCY21atXHFPKdSBfu/SqvZ17xa2Ytoy7Di/xg/+4ycv9mEd7yLE8jcd9/6iR
	wLVR/y7XtHA06CLKR4hGaiWJcD9f3zbtvGi+nFLbujwwUieFP40BUiFANcXG7aLC0KXDfZ0Lxxg4b
	riYXmGf1L63Lyl3Rck4IhE525dfBHTUYGEiZhhixBOBMIPXZrdIp6XYxsvv7RHTdpTQO+JbrEbl8F
	L6EcW3ZsZJI8CAupjh3DU2U+JNJHeMdkokhb9hE8n2eyI5dzsMb9E5qTaxmM/Imjopa13DXh6f2aD
	VuNUqD2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQinT-000Rd5-2K;
	Tue, 01 Aug 2023 06:23:55 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOhWl-00B1nC-1v;
	Wed, 26 Jul 2023 16:38:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0F0C161BD1;
	Wed, 26 Jul 2023 16:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF0CC433C8;
	Wed, 26 Jul 2023 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690389498;
	bh=JIDm8LyfxJE7RRvIDFBtu2mHaYm7IVhXvOfm9XgAH7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVe0wYl0pfbTfi8Yk37HxVES1kUaLlRdVU18c+4qLYdbqDo0CkkW2g7EcfDSgzYPJ
	 NA5avCass45oAveyV92sZS2dnLsCv9hYu2IOOxxERW6z5ffcDTqHWvqAeDNiO/w8o0
	 2SEA6Xny8d1OJ9Bl8vFkUAxs9OSQjY2Huro5SATt91BAgNMvoY/b5Mfj+XsJWSNoTc
	 UgE9m9/vfyW+G6CLZ1gO9WTA+yUUMyq0wyPKF7DpzWQ531qwanBBLIJlomoPdBhRuV
	 LH4X32oE8eZxhEog8xelaNnyovVs45f739gtIVMaSsCEQupavG1K3g2SGwAzTXp3Al
	 myPgA/ueGseJw==
Date: Wed, 26 Jul 2023 17:38:12 +0100
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
Subject: Re: [PATCH v2 3/3] riscv/kexec: load initrd high in available memory
Message-ID: <20230726-busily-marsupial-504e9ff2d873@spud>
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
 <67c8eb9eea25717c2c8208d9bfbfaa39e6e2a1c6.1690365011.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
In-Reply-To: <67c8eb9eea25717c2c8208d9bfbfaa39e6e2a1c6.1690365011.git.petr.tesarik.ext@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_093819_675557_E964648F 
X-CRM114-Status: GOOD (  16.52  )
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
Content-Type: multipart/mixed; boundary="===============1215412254050122323=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============1215412254050122323==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4IjUavm2DX17Tscu"
Content-Disposition: inline


--4IjUavm2DX17Tscu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 11:54:01AM +0200, Petr Tesarik wrote:
> From: Torsten Duwe <duwe@suse.de>
>=20
> When initrd is loaded low, the secondary kernel fails like this:
>=20
>  INITRD: 0xdc581000+0x00eef000 overlaps in-use memory region
>=20
> This initrd load address corresponds to the _end symbol, but the
> reservation is aligned on PMD_SIZE, as explained by a comment in
> setup_bootmem().
>=20
> It is technically possible to align the initrd load address accordingly,
> leaving a hole between the end of kernel and the initrd, but it is much
> simpler to allocate the initrd top-down.
>=20
> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> Cc: stable@vger.kernel.org

Trying to align it might be worthwhile, but the simple fix makes sense
for now & w.r.t backporting.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--4IjUavm2DX17Tscu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMFL9AAKCRB4tDGHoIJi
0kQrAQDAjVabAm/0oUxhkPidOB7m+J9yy16ms3S4tX5CRjFpMgEAwbU91VszeYbg
yTGfUV46zID+fbBShPEqsNSCrR3Qlgs=
=yUks
-----END PGP SIGNATURE-----

--4IjUavm2DX17Tscu--


--===============1215412254050122323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1215412254050122323==--

