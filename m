Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C25CC25B74
	for <kexec@archiver.kernel.org>; Sun,  2 Jun 2024 05:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kE8MjWfXcR6wKBrLZO5V4ZK1sktqpIqNWvRwUC2YFfE=; b=j+YRaBqE08HQcMKmMQZ71DAQdQ
	a+8rvnBAG+iOc1qzOR5JlpXMJd7Yx6Ec3ph/9kQ612K3OIcWNWX5dQ5WqlG1JO/wJJjVD7OjF/+PK
	h/xGfRsa0I38FTQVq1RKuFej0ew/RVWvvR7vOzDCRt2T9wEzgfhpTr2vPTXKJ7fLR4gGYmYSGVlGn
	gNWLKGTBP5QKMCmbCY/sBcxqlBqZFimpwtTZi5auVqbSDZrcryDUVXywmMebvdh06k2eaaSsOrBO4
	TnD6acYIBoXmu/CXANv/ox2LhXWJTcwCn7daiWocDTvHOay1oWurp40x0sB9UUL/8LWPi+YGsl872
	ERJsYYZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDdel-0000000DnR9-2n0L;
	Sun, 02 Jun 2024 05:21:23 +0000
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDdeg-0000000DnPC-3PZ6
	for kexec@lists.infradead.org;
	Sun, 02 Jun 2024 05:21:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1717305664;
	bh=2DwQizc09vDj0hOjBYqRErLzcC3C4KoGCg/eObaIELQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kQKqP7vzTVSHQ0UhYzQS+fJfdSjUIRTz68+/tuhR49fK+SsRzk4Vw1vNGEsXbfNB5
	 fGOuy6Yiiw227C0/JWf+ik0edpxXuEdM+AvWSavHHfWZD1Y/E+tSesT+4lCfVay0rf
	 GYBiJIyk8fpTM7sp8KrCOgYAb1B+4kMu3nJ/M1wMgL/rwkcIIQqfVJupqnETH+5OQk
	 fr0RpL+/uT3OZ7AOOvH/hKQmDZTQVgcm1mGP7x4OTp/AOVNGiRNzwBawuVslTZSSuA
	 YzsPafN1/y8kCjWABXqB0SrFohVLUvelemj9OTG7dr2u8f7ft6SGR+IyZavSh02sFo
	 izYrZmMzumNmQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VsQDv4xCLz4wcg;
	Sun,  2 Jun 2024 15:21:03 +1000 (AEST)
Date: Sun, 2 Jun 2024 15:20:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, <kexec@lists.infradead.org>,
 <sourabhjain@linux.ibm.com>, <bhe@redhat.com>
Subject: Re: Please add powerpc topic/kdump-hotplug branch to linux-next
Message-ID: <20240602152058.276df8e9@canb.auug.org.au>
In-Reply-To: <87mso42pag.fsf@mail.lhotse>
References: <87bk60ji79.fsf@mail.lhotse>
	<20240424074023.43932cca@canb.auug.org.au>
	<87mso42pag.fsf@mail.lhotse>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240601_222119_003437_563BDCCC 
X-CRM114-Status: GOOD (  15.67  )
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
Content-Type: multipart/mixed; boundary="===============7609520334838580380=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============7609520334838580380==
Content-Type: multipart/signed; boundary="Sig_/kx7e0nSXIXyfuOD1Yc5aE8u";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/kx7e0nSXIXyfuOD1Yc5aE8u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Sun, 02 Jun 2024 09:53:27 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> >
> > On Tue, 23 Apr 2024 23:56:42 +1000 Michael Ellerman <mpe@ellerman.id.au=
> wrote: =20
> >>
> >> Can you please add the topic/kdump-hotplug branch of the powerpc tree =
to
> >> linux-next. It contains a series that touches generic kexec code as we=
ll
> >> as x86 and powerpc code.
> >>=20
> >> The hope is to have to get it merged for v6.10, so it should go along
> >> with the powerpc next branch in the merge order.
> >>=20
> >> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/=
?h=3Dtopic/kdump-hotplug =20
> >
> > Added from today. =20
>=20
> This branch has now been merged and can be dropped from linux-next,
> thanks.

Removed.

--=20
Cheers,
Stephen Rothwell

--Sig_/kx7e0nSXIXyfuOD1Yc5aE8u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZcAToACgkQAVBC80lX
0Gw/4gf/Xpxz7iv8f7mNzqzlovFpBO0pdnSSU2Ui6uHaRbl5irBMzCK5n+S6JpKy
EFMO2NWyzrMI2g80hQjkve0Q5bygdABPAEjBJBMM1Dsp6sBgCZHU/hj8qnxfNh2c
ZVP2Jp90JdK37Iu8usPBJKTDX+OkX2l1dxcxiBjIOwGEI9UZ/gIvifoWlrSUFHb0
uKzGxKmsqUdc3wjY/f5MGgVaWnTK9Kr3Tj/iLFA+dvAbIkGjDbXEd7Q6XbWvg8A6
zPSsD/ph4RBfUOM26R3GcwGr8Su/wNm2qfG/0TcD3+a25j5DjBSjbetZxjav1fQr
sFqgwtONYNnL+JbVrmzNz8G5VlLosw==
=mtNi
-----END PGP SIGNATURE-----

--Sig_/kx7e0nSXIXyfuOD1Yc5aE8u--


--===============7609520334838580380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============7609520334838580380==--

