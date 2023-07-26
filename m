Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D7DC41513
	for <kexec@archiver.kernel.org>; Tue,  1 Aug 2023 06:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8V7WM6mAdKYsSLLK3ekZ/JqePDAlI6czLtTf/U5CIS4=; b=t/8QqJZ2lFerLXEOuwBTfts0Tr
	DkZTxHy3Dk2plE3mLV7L2O3K6aS96i2T/SVxyB7jaOt94rJrJhxy5WZyJ3drETErrkp1zx9t0ebJe
	zd9oDOlF7nx/HFdP9dRSPIUpkX0BCygSpCbcZ36OUGAgKhNGKaHFJqspP7tZfkpePlzDE6CnEzW6/
	3Vizg5PW4XSezB0D02UPGjwmBTXfSXUfK05bt55jctPfl2pztyeuINhzSIF10GuOUskOOQVabFbow
	0ihPSaTlHlJYiDfEOLq0xSgAoMaXXsKGpoY9EzXB0REFp10TZGNurLU2o3n87yWb9UUgIsY2csbl1
	rpxnXpWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQinS-000Rch-2B;
	Tue, 01 Aug 2023 06:23:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOhOv-00B0TB-2D;
	Wed, 26 Jul 2023 16:30:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F121361BAD;
	Wed, 26 Jul 2023 16:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBA9C433C9;
	Wed, 26 Jul 2023 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690389012;
	bh=CtseXuR2b1gVCty2ACeXPRH8foj3zXYwQxfeGFmkA/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7p6VPuvvuD4zq0VgCKzv1nfUo1r+C/5JO/YzgpyxyhVKS8CjHWLPbzDNV+b0uJnF
	 xNxdBkZ00dTkU7T9LlfRbMLSjvEkliC9c4/eBx3rR/WrVcL2c/Xt+T2WrTeK7RDucA
	 m6awjWW7Fy/tI70vU2BuXXtwv8QBv6DASpYoc6/f03bjKRBneGusMGuc+5iyLhCRmh
	 rSfPUPMRzAuE5JETF9+6rZf/c1faIowogzHv2u8F2yKE6tqcKaBHBNnbbu6TDjEOFx
	 BuFSBsnvrutziUtHalQlKn94hsuf/+217Qz9j877L6hPV8IPnQA4aXpjP6CBMGCpBK
	 8+FnCRwD9K8tg==
Date: Wed, 26 Jul 2023 17:30:06 +0100
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
Subject: Re: [PATCH v2 1/3] riscv/kexec: handle R_RISCV_CALL_PLT relocation
 type
Message-ID: <20230726-cough-vitamins-ec47ba6d611d@spud>
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
 <b046b164af8efd33bbdb7d4003273bdf9196a5b0.1690365011.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
In-Reply-To: <b046b164af8efd33bbdb7d4003273bdf9196a5b0.1690365011.git.petr.tesarik.ext@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_093013_768399_FD38064F 
X-CRM114-Status: GOOD (  10.99  )
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
Content-Type: multipart/mixed; boundary="===============8258461772239265814=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============8258461772239265814==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UIaLJjVO8+XCunHJ"
Content-Disposition: inline


--UIaLJjVO8+XCunHJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 11:53:59AM +0200, Petr Tesarik wrote:
> From: Torsten Duwe <duwe@suse.de>
>=20
> R_RISCV_CALL has been deprecated and replaced by R_RISCV_CALL_PLT. See En=
um
> 18-19 in Table 3. Relocation types here:
>=20
> https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-el=
f.adoc
>=20
> It was deprecated in ("Deprecated R_RISCV_CALL, prefer R_RISCV_CALL_PLT"):
>=20
> https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a0dced85018d7=
a0ec17023c9389cbd70b1dbc1b0

Ideally, these would be Link: tags, but that's certainly not worth a
respin. This looks fine to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--UIaLJjVO8+XCunHJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMFKDgAKCRB4tDGHoIJi
0rBWAPwI4gbOKalorI6lw3HBpf/e4X6L62YHnlNEGDK38uD65AEA5D9m3ptjNQ8P
V8EYRqN4eqO+PK+WLVbRvH37sXghRgw=
=lYlX
-----END PGP SIGNATURE-----

--UIaLJjVO8+XCunHJ--


--===============8258461772239265814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============8258461772239265814==--

