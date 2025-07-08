Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58470C83F0F
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 21:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B6e+VUwwKAkVhrA42dAu+CepDrK4drho9sSBVbt8xn0=; b=PV05MxNNkEA5y5bT/wVeFZ9RWv
	MKKo2e+5bZynfFK83LHpPGpbP0AAHCQuUcByHP8bjENE6+9MKXAY8ku4oIBXugnI2jCkH8/XEt1U6
	IkA9qwRm6HwaxcDh6Zg6nzo8U+JxCWoTMAEdynVcN6Q6knTPYkPaY9dF43lZ9RWXjLTLVR0iT4Lp2
	msgVLe/12sam2XnS/ypZFuQEZbhtjAbOYbsv7+sYbwi9dm/TqCdlsAkOibY9PlwvnS9zCN0/ZMeQR
	r/2XDc0andOn7fxWP1a0uIk+fWmwGCWmg+a2gFjCPir7pGNL4M7Z1faJXFoGWDAKfp4Oys6TvaW3s
	IPggSCKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFoV-00000006ek7-40Q6;
	Tue, 08 Jul 2025 21:25:19 +0000
Received: from jabberwock.ucw.cz ([46.255.230.98])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFGB-00000006Ytw-1jSV
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 20:49:52 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EA61C1C008E; Tue,  8 Jul 2025 22:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752007789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B6e+VUwwKAkVhrA42dAu+CepDrK4drho9sSBVbt8xn0=;
	b=VcLLmneHsxHVSgw6vwWj2fWBquaRQe6L4Xuvs5NRXfKZB0BGYgEG4f/K5v6nWiYg6+FKaK
	C5fdO9qGaH0SMJmlTGF/5DdBRG7m+nj5iUutZGVXBw2JKvR4NGJqngzBZ1HbmfMko+zVBE
	P/keGjFSPpseZyRV/rtetdyl51LW7Xk=
Date: Tue, 8 Jul 2025 22:49:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Willy Tarreau <w@1wt.eu>
Cc: Sasha Levin <sashal@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG2EbUlZJQ/MxwfY@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
 <20250708204607.GA5648@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kf9+gjiYr3G8QaDc"
Content-Disposition: inline
In-Reply-To: <20250708204607.GA5648@1wt.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_134951_743687_FCD5C2CD 
X-CRM114-Status: GOOD (  13.53  )
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


--Kf9+gjiYr3G8QaDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2025-07-08 22:46:07, Willy Tarreau wrote:
> On Tue, Jul 08, 2025 at 10:37:33PM +0200, Pavel Machek wrote:
> > On Tue 2025-07-08 16:32:49, Sasha Levin wrote:
> > > I've gone ahead and added you to the list of people who AUTOSEL will
> > > skip, so no need to worry about wasting your time here.
> >=20
> > Can you read?
> >=20
> > Your stupid robot is sending junk to the list. And you simply
> > blacklist people who complain? Resulting in more junk in autosel?
>=20
> No, he said autosel will now skip patches from you, not ignore your
> complaint. So eventually only those who are fine with autosel's job
> will have their patches selected and the other ones not. This will
> result in less patches there.

That's not how I understand it. Patch was not from Eric, patch was
being reviewed by Eric.
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--Kf9+gjiYr3G8QaDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG2EbQAKCRAw5/Bqldv6
8oqVAJsHwmGC9LtixX8rObtxca3u89YL+wCglZXkSkKVM9/SY0h33Hhigs2PI08=
=LJAt
-----END PGP SIGNATURE-----

--Kf9+gjiYr3G8QaDc--

