Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DA2EB64DD
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cuC1DFcZ9siL7joG+DOtNMdlFT9quYRnt0zGstpVvks=; b=oYU5yb/2UXEXb7oVg1u8XKOLm0
	CPw3FQ3xWl5Fw8K9GrqeZBUis1wOZn+OIHElgHhym5USLk6I/3GO8qtsLg2IYl6c62HkY3b8QPfzR
	gzNwCwGDzaQUetmmeZrP3UvQDldJxGc2fO0rQEn65vnodtrujX5fTo9o0ToGhzY0W4Qshz8frvtlN
	G3M1omkdspdR2PmKYKUOOObvDGsfcWPBjbb1XlE6dYYClOKLCtqWh933oikox67tbMG0dUHPjrSTj
	imveqJDrp6ThxcNtsvWRK2ztA/YT8l8AKjVCHDY6EjjvEalFj2bZrXH6iX1B3OsUK6PePQQpp33Qe
	ZgNjzrHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRa52-00A9Fc-1g;
	Thu, 03 Aug 2023 15:17:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRa4z-00A9D1-23;
	Thu, 03 Aug 2023 15:17:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2549761DF1;
	Thu,  3 Aug 2023 15:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B6EC433C8;
	Thu,  3 Aug 2023 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691075852;
	bh=JOtFsu4qKmc9AW5VOUQjU18SjRDgCLlAIYX0MJ1PV5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O69IF48qzzndoTOv9OXwlGg9LS5RbsTklNaedcNctCKKvUzLOj22sDlOq/FXNjj+e
	 VYD8tfdH9weG0OucMALKPFLSJSegdIeNmqoZU3LU78trZn5szQyuPXI8u9EmIcMgA2
	 GqHdzbax5G5U5N41PsTZM1HJeloSmhKhYGMneR15BEdrNleuafAneq3utGvK3LyC5Q
	 VQZZSS45877+WeDlRihmWibGFWaoUS8/kYzTHZfknAOCnAMeV73YxjVvCcywoaVXXu
	 VLxjhPUM0X+vGftlUtVz+Pb+OCAx3YbhI6/vZb4JFDc0JIWkr9W/yvKJlTSPnMQDAa
	 8t2V43ROmh+Pw==
Date: Thu, 3 Aug 2023 16:17:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: petrtesarik@huaweicloud.com, Paul Walmsley <paul.walmsley@sifive.com>,
	aou@eecs.berkeley.edu, Conor Dooley <conor.dooley@microchip.com>,
	lihuafei1@huawei.com, liaochang1@huawei.com, masahiroy@kernel.org,
	keescook@chromium.org, akpm@linux-foundation.org, heiko@sntech.de,
	ribalda@chromium.org, hi@alyssa.is, lizhengyu3@huawei.com,
	linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, duwe@suse.de,
	roberto.sassu@huaweicloud.com, petr@tesarici.cz
Subject: Re: [PATCH v2 2/3] riscv/purgatory: do not link with string.o and
 its dependencies
Message-ID: <20230803-buddhism-hardwood-eea45fdedd6e@spud>
References: <20230726-excavate-swoosh-424ede98f63d@spud>
 <mhng-45e67c5d-6969-43da-9147-b53dc9a78612@palmer-ri-x1c9>
MIME-Version: 1.0
In-Reply-To: <mhng-45e67c5d-6969-43da-9147-b53dc9a78612@palmer-ri-x1c9>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_081733_761993_C30C0FCB 
X-CRM114-Status: GOOD (  28.48  )
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
Content-Type: multipart/mixed; boundary="===============7119218316542303396=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============7119218316542303396==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nf/A7HXcD+iE9Bxb"
Content-Disposition: inline


--Nf/A7HXcD+iE9Bxb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 08:13:48AM -0700, Palmer Dabbelt wrote:
> On Wed, 26 Jul 2023 09:33:49 PDT (-0700), Conor Dooley wrote:
> > On Wed, Jul 26, 2023 at 11:54:00AM +0200, Petr Tesarik wrote:
> > > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > >=20
> > > Linking with this object file makes kexec_file_load(2) fail because of
> > > multiple unknown relocation types:
> > >=20
> > > - R_RISCV_ADD16, R_RISCV_SUB16: used by alternatives in strcmp()
> > > - R_RISCV_GOT_HI20: used to resolve _ctype in strcasecmp()
> > >=20
> > > All this hassle is needed for one single call to memcmp() from
> > > verify_sha256_digest() to compare 32 bytes of SHA256 checksum.
> > >=20
> > > Simply replace this memcmp() call with an explicit loop over those 32=
 bytes
> > > and remove the need to link with string.o and all the other object fi=
les
> > > that provide undefined symbols from that object file.
> > >=20
> > > Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> > > Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> >=20
> > This version keeps the automation happy,
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Oddly enough, this breaks my builds.  I tried fixing the first one with
> something like

You say "tried", does that mean it also didn't work?
What's the config?

Cheers,
Conor.

>=20
>    From 41c5a952f77e53bf4201296abff0132725aa19e6 Mon Sep 17 00:00:00 2001
>    From: Palmer Dabbelt <palmer@rivosinc.com>
>    Date: Wed, 2 Aug 2023 20:22:33 -0700
>    Subject: [PATCH] RISC-V: Include io from timex
>    Without this I get some implicit declarations.
>      CC      arch/riscv/kernel/asm-offsets.s
>    In file included from linux/include/linux/timex.h:67,
>                     from linux/include/linux/time32.h:13,
>                     from linux/include/linux/time.h:60,
>                     from linux/include/linux/ktime.h:24,
>                     from linux/include/linux/timer.h:6,
>                     from linux/include/linux/workqueue.h:9,
>                     from linux/include/linux/mm_types.h:19,
>                     from linux/include/linux/mmzone.h:22,
>                     from linux/include/linux/gfp.h:7,
>                     from linux/include/linux/mm.h:7,
>                     from linux/arch/riscv/kernel/asm-offsets.c:10:
>    linux/arch/riscv/include/asm/timex.h: In function 'get_cycles':
>    linux/arch/riscv/include/asm/timex.h:25:16: error: implicit declaratio=
n of function 'readl_relaxed' [-Werror=3Dimplicit-function-declaration]
>       25 |         return readl_relaxed(((u32 *)clint_time_val));
>          |
>    Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>    ---
>     arch/riscv/include/asm/timex.h | 1 +
>     1 file changed, 1 insertion(+)
>    diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/t=
imex.h
>    index a06697846e69..1a4d181193e0 100644
>    --- a/arch/riscv/include/asm/timex.h
>    +++ b/arch/riscv/include/asm/timex.h
>    @@ -7,6 +7,7 @@
>     #define _ASM_RISCV_TIMEX_H
>     #include <asm/csr.h>
>    +#include <asm/io.h>
>     typedef unsigned long cycles_t;
>=20
>    --    2.41.0
>=20
> The other two look fine and are somewhat independent, so I've picked thos=
e up
> for fixes.
>=20
> Thanks!
>=20
> >=20
> > Thanks,
> > Conor.

--Nf/A7HXcD+iE9Bxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMvFBgAKCRB4tDGHoIJi
0krhAPsHeWuR7/VBvITrvcsf0/CMFwYy6FCA83Pn8tfUoHHlAwD/XbC/Sm5QCAXk
tXpKIgYHUYa+igPS8LCenkLVW9qHyQs=
=/RnV
-----END PGP SIGNATURE-----

--Nf/A7HXcD+iE9Bxb--


--===============7119218316542303396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============7119218316542303396==--

