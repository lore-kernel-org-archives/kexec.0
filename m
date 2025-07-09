Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CFAC83F03
	for <kexec@archiver.kernel.org>; Wed,  9 Jul 2025 05:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=svwnB+Z4890tufsaoGz9vRW/N/RBoDGCgf6HDoGv1HI=; b=44UlLvvwQcK68DzZ5lThpKNRma
	OCoIIkyFK0kEmVxdQU/KLpkONBwo45h1INu7MzuiMYcmt2gjR0MG1926pVoT/YuzSCvvvjLwf5ZTe
	TR/9XH7FFV9XjmLTzcNiL3SlMkqvLiuXJTXbl7XQrvwRTJnpA8SaCTlZtobCjh+bxi9dJbSc9dgfe
	fQiHQUus74R9dlqZcRmEsDbG1So1KPBEO6f2OCGUAJvkAMdrOuzVRMiSRlUj18wsr916TcB01nXh3
	wkjK2Ofx2B+wfE32PYpk7rJtuDaBLQndYwP6tjqONwz1tBLg0+IBO2z/Idbfc0+8Wr+UW8B3GWLAf
	pRr/E+ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZNRX-00000007bCK-3Lj2;
	Wed, 09 Jul 2025 05:34:07 +0000
Received: from jabberwock.ucw.cz ([46.255.230.98])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZNRV-00000007bBy-0Edm
	for kexec@lists.infradead.org;
	Wed, 09 Jul 2025 05:34:06 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 621F01C00AE; Wed,  9 Jul 2025 07:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752039242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svwnB+Z4890tufsaoGz9vRW/N/RBoDGCgf6HDoGv1HI=;
	b=ZLlVWrlRUQqnMifGmK3yjkLxLl1p7B4ZowLIPRsJOzvRmjvFiSiSid5Sd40vG2PMEOs85p
	4jQhfVlBnpSS/vQubGpk1igKOLft3dq8LDhyaUVHZqQiUzhAZqYzR3wnYJdU9LJFi2TClc
	1H6nRB/2N9qxKNQV1bmHAub/sBTDPRQ=
Date: Wed, 9 Jul 2025 07:34:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, "Eric W. Biederman" <ebiederm@xmission.com>,
	patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG3/SUPgejAU8I0f@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
 <20250708204607.GA5648@1wt.eu>
 <aG2JzsVKuBkFcXj9@lappy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9YTTCnEuj//7jxM"
Content-Disposition: inline
In-Reply-To: <aG2JzsVKuBkFcXj9@lappy>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_223405_554867_6B847FB1 
X-CRM114-Status: GOOD (  14.06  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--q9YTTCnEuj//7jxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2025-07-08 17:12:46, Sasha Levin wrote:
> On Tue, Jul 08, 2025 at 10:46:07PM +0200, Willy Tarreau wrote:
> > On Tue, Jul 08, 2025 at 10:37:33PM +0200, Pavel Machek wrote:
> > > On Tue 2025-07-08 16:32:49, Sasha Levin wrote:
> > > > I've gone ahead and added you to the list of people who AUTOSEL will
> > > > skip, so no need to worry about wasting your time here.
> > >=20
> > > Can you read?
> > >=20
> > > Your stupid robot is sending junk to the list. And you simply
> > > blacklist people who complain? Resulting in more junk in autosel?
> >=20
> > No, he said autosel will now skip patches from you, not ignore your
> > complaint. So eventually only those who are fine with autosel's job
> > will have their patches selected and the other ones not. This will
> > result in less patches there.
>=20
> The only one on my blacklist here is Pavel.

Please explain.
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--q9YTTCnEuj//7jxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG3/SQAKCRAw5/Bqldv6
8r2AAJ9LEsNHdZxl57bzpvttS8LUch4m6QCggkX8D97YgfYW/zLInEjyv8Cmn4k=
=9zck
-----END PGP SIGNATURE-----

--q9YTTCnEuj//7jxM--

