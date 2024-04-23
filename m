Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817AAC4345F
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 21:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6sNn+42HL6Q3kXs+ERDIYvYu+MKsOG7ww16PPL21FK4=; b=hBG5lavgRE3e1oQpGMtFVj3IFC
	k7QYJ0K/7lRElUh39pbE5ubKqYaRT3pX+0WU8cdLX2K0VWm5xEx1O+5VSOwHg6jFvG0w+qme2S4Up
	I89IUCo0Ft9mwSrj1fhCdh2GVd2rUnhmDKYpWwbkdnJmn/hw/mGhJohULRIp8lL0ki3xZBkJISz4r
	CjLRrs8rNb7+hDnvBMwve7uNEymPKP1s72bM3vjogQTk0mMS8xZe3/ZFwQ5CvXxMCbPok+NXge9kT
	v00H6iN9+zGeYrVKi+tEjgkXpvCWedR8CdoDT2VwCQyYorkT+Mza0PhIBLd4cavI0VfEUiJFw3mNo
	9TYaZH4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzNse-00000001b5k-0b7Q;
	Tue, 23 Apr 2024 21:40:48 +0000
Received: from gandalf.ozlabs.org ([150.107.74.76])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzNsa-00000001b3c-28BZ
	for kexec@lists.infradead.org;
	Tue, 23 Apr 2024 21:40:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713908427;
	bh=wHYxct6asNImlbeupPEFHpTTxlZt2liy9+CRSPwAYVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hV+LMIhLeShhLbbuSeOQACQUCwvMaCJajbPMaBmdA1nt+3efGfvv5XCRRWY8QMgMH
	 h/z9n6gMxzzNDZk+vrohsItjtT7IdFrtiItiPC4IcPOSVZc6jjCalCsQaBei0LSK9Z
	 6EsFkhmhhCIRVO5HUYy410IA1L/+j4HxWmloflDGyobq4t6fKkPuzHU9rEO5H2rset
	 dffwhCAjvSs5MXtDNrt9jsUyaFa11FtPz4Ck2IGwisQx2GLust2FpoThSHcYuQX0N8
	 FvC+wALA+kYwqHw9gL+JbvVpQPdaXVS1hhX/Cvc53h6ClgrTN94djyP+NRM/J7s+iT
	 8/j9cFPP+S9gg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VPFsQ4vX0z4wc5;
	Wed, 24 Apr 2024 07:40:26 +1000 (AEST)
Date: Wed, 24 Apr 2024 07:40:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, kexec@lists.infradead.org,
 sourabhjain@linux.ibm.com, bhe@redhat.com
Subject: Re: Please add powerpc topic/kdump-hotplug branch to linux-next
Message-ID: <20240424074023.43932cca@canb.auug.org.au>
In-Reply-To: <87bk60ji79.fsf@mail.lhotse>
References: <87bk60ji79.fsf@mail.lhotse>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_144044_712463_D946BB5A 
X-CRM114-Status: GOOD (  16.74  )
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
Content-Type: multipart/mixed; boundary="===============2899494768465646461=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============2899494768465646461==
Content-Type: multipart/signed; boundary="Sig_/ATeAZrrv2EJbPtCU7.6+XEM";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ATeAZrrv2EJbPtCU7.6+XEM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, 23 Apr 2024 23:56:42 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
\> Can you please add the topic/kdump-hotplug branch of the powerpc tree to
> linux-next. It contains a series that touches generic kexec code as well
> as x86 and powerpc code.
>=20
> The hope is to have to get it merged for v6.10, so it should go along
> with the powerpc next branch in the merge order.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=
=3Dtopic/kdump-hotplug

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/ATeAZrrv2EJbPtCU7.6+XEM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYoKscACgkQAVBC80lX
0Gyc/QgAoeBb/nq8jS4FDhTR1whXCAYnYtDtBfITZ+rhVw+j8iIMfMNpdjWIuHKp
EmcHHvC6tkE3aFbNIALtDH3oHVmGD9GNJBnkWvJxefymoLOGxaNH44ld2o+lX3WJ
chIyEnZzqcf7hO+CdtobArpLdPkrfRX7FU+yIsNCCdJYYhzPcdUvnvBE7ZJgZHGB
sgrCoMjOEMDfQO3ZYUw7AYbZiZt5imEq/UH0pIf6CK5qXfnrtc9iXA0GoA1/Pg14
aF+B1RX24/4Tk+lkvnOsT/YGk7bFzhodDuQvnMUb5Ht13MbyQZQj4749q2BUg5L8
DVcqvB/sysHxdGcFJjM0dQKNjpf3Zw==
=IxtL
-----END PGP SIGNATURE-----

--Sig_/ATeAZrrv2EJbPtCU7.6+XEM--


--===============2899494768465646461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2899494768465646461==--

