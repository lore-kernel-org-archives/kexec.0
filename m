Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC4FC43334
	for <kexec@archiver.kernel.org>; Thu,  2 Jun 2022 06:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nunBLXWQiDdbNqcwwHV2EU8MQoIs9Mbvm7ee6ghpqIE=; b=XfHPPQTBjIsxQ6iyG8PWBNfcZL
	DpwQ1Oxw3lAVeGHIL9Ksc7oDbwhrXxIlyO4ncJBcjMwsMwesy0hSthHSwsDWmhQ/T+ElZ5yorPcuF
	0AYctgth801r4YrxWVayI4RG3UnvVmmliixlpHH5YpfSD3bkAXPJNlGptwDVHyqMcjlbR7QDlc9rv
	/RYxuStE8L09mIjpMskYN6iYQOc2WIivM7Lgg0RTeV0Na9H19bS970oZtYXsAO4GO55UBcjP0wD8A
	GVoZ7iGPelfTQhb7lDD+Uyu0sZAxuaGuAkLwOAnKhuLe1qu7p/1R3fm7y3HxQ1VjNYtQZvlj6uVHw
	kBSbsUcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nweZc-001oOw-66; Thu, 02 Jun 2022 06:44:48 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvlHa-0084xX-Le
	for kexec@lists.infradead.org; Mon, 30 May 2022 19:42:32 +0000
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1nvlGn-0004LO-Ul; Mon, 30 May 2022 21:41:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1nvlGh-005Vep-Cd; Mon, 30 May 2022 21:41:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1nvlGf-00D9uL-Eh; Mon, 30 May 2022 21:41:33 +0200
Date: Mon, 30 May 2022 21:41:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: wangkefeng.wang@huawei.com, guoren@linux.alibaba.com,
	sunnanyong@huawei.com, jszhang@kernel.org, mick@ics.forth.gr,
	linux-riscv@lists.infradead.org,
	Stephen Rothwell <sfr@canb.auug.org.au>, alex@ghiti.fr,
	christophe.leroy@csgroup.eu, naveen.n.rao@linux.vnet.ibm.com,
	lizhengyu3@huawei.com, aou@eecs.berkeley.edu, liaochang1@huawei.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Bjorn Topel <bjorn.topel@gmail.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, penberg@kernel.org,
	ebiederm@xmission.com, kernel@pengutronix.de,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] RISC-V: Prepare dropping week attribute from
 arch_kexec_apply_relocations[_add]
Message-ID: <20220530194133.udwdjsb2l33hsiil@pengutronix.de>
References: <20220530074202.pydmbbgvbtaugw5j@pengutronix.de>
 <mhng-5872aea0-6f64-4685-8f8d-fdeb42e4c972@palmer-mbp2014>
MIME-Version: 1.0
In-Reply-To: <mhng-5872aea0-6f64-4685-8f8d-fdeb42e4c972@palmer-mbp2014>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220530_124230_737811_C5AA3EEF 
X-CRM114-Status: GOOD (  36.15  )
X-Mailman-Approved-At: Wed, 01 Jun 2022 23:44:28 -0700
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
Content-Type: multipart/mixed; boundary="===============4120239136711754872=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============4120239136711754872==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="krrdaxdkw2concro"
Content-Disposition: inline


--krrdaxdkw2concro
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, May 30, 2022 at 11:58:16AM -0700, Palmer Dabbelt wrote:
> On Mon, 30 May 2022 00:42:02 PDT (-0700), u.kleine-koenig@pengutronix.de =
wrote:
> > Without this change arch/riscv/kernel/elf_kexec.c fails to compile once
> > commit 233c1e6c319c ("kexec_file: drop weak attribute from
> > arch_kexec_apply_relocations[_add]") is also contained in the tree.
> > This currently happens in next-20220527.
> >=20
> > Prepare the RISC-V similar to the s390 adaption done in 233c1e6c319c.
> > This is safe to do on top of the riscv change even without the change to
> > arch_kexec_apply_relocations.
> >=20
> > Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> > Looks-good-to: liaochang (A) <liaochang1@huawei.com>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >=20
> > On Mon, May 30, 2022 at 09:43:26AM +0800, liaochang (A) wrote:
> > > > I can confirm that doing
> > > > > diff --git a/arch/riscv/include/asm/kexec.h
> > > b/arch/riscv/include/asm/kexec.h
> > > > index 206217b23301..eee260e8ab30 100644
> > > > --- a/arch/riscv/include/asm/kexec.h
> > > > +++ b/arch/riscv/include/asm/kexec.h
> > > > @@ -55,6 +55,13 @@ extern riscv_kexec_method riscv_kexec_norelocate;
> > > >  >  #ifdef CONFIG_KEXEC_FILE
> > > >  extern const struct kexec_file_ops elf_kexec_ops;
> > > > +
> > > > +struct purgatory_info;
> > > > +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> > > > +				     Elf_Shdr *section,
> > > > +				     const Elf_Shdr *relsec,
> > > > +				     const Elf_Shdr *symtab);
> > > > +#define arch_kexec_apply_relocations_add arch_kexec_apply_relocati=
ons_add
> > > >  #endif
> > > >  >  #endif
> > >=20
> > > LGTM, you could send a fixup patch to riscv, thanks.
> > >=20
> > > > > on top of 838b3e28488f results in a compilable tree. And when
> > > merging
> > > > 233c1e6c319c into this, it is still building.
> > > > > I'm not enough into kexec (and riscv) to judge if this is
> > > sensible, or
> > > > create a useful commit log but the obvious way forward is to apply =
the
> > > > above patch to the riscv tree before it hits Linus' tree.
> >=20
> > Ok, here comes a patch with a generic commit log.
> >=20
> > @riscv people: If you prefer, squash it into 838b3e28488f.
>=20
> Sorry, just saw this after I sent my version of the fix.  They're the sam=
e,
> but do you mind sending a full-on patch so I can merge it?

Sorry, I don't understand your request. I found
https://lore.kernel.org/linux-riscv/20220530180408.16239-1-palmer@rivosinc.=
com/

but I don't know what a full-on patch is and what stops you merging my
patch.=20

Is it that it's in reply to a patch series and b4 fails to fetch the
right patch and you ask to send it in a new thread?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--krrdaxdkw2concro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKVHeoACgkQwfwUeK3K
7AmIjAf/cIdZXzTm8ALuTDgUrKH3cNzpFjQ944mYn/qfLoGkdCnQlYzghw570rDo
0QKgHNkqRQQ7lgaXGnex5HizEMdc+++QESut+gBcrV92K33EZU3XSXUp+75SE+Jz
DjRnmCm4xkh/9zZysNW0OXLnjd4AtGMlbzXYFKsKKxtaGgd7+f06D3cTzoVOfLbL
i0DPa56ftXEmEYl6WpqIg1gb9gQMQx7E9vsscEgoOX6u9AlinTk/cxkDA6lhMNEj
03qeCXcYyUQtszhTYw3jo8cLqM1KGLVU3i9Blj0mAIQ8DVaXUd3hWx3AFqjeA55K
bErpEBzedIdALZNq1g3XX9JHLEMP7Q==
=qw7s
-----END PGP SIGNATURE-----

--krrdaxdkw2concro--


--===============4120239136711754872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============4120239136711754872==--

