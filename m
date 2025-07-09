Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD2AC83F09
	for <kexec@archiver.kernel.org>; Wed,  9 Jul 2025 05:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AgGo0D6w/UsINXs2Wle7uc8mU/aFWH/QOKQE3QW+Hgk=; b=G3aLJ9dF4pHTv7ALUNXJ4lrueM
	DoWtsxVzbalc8vWFdYFhcmJq0+m2DVQvN/4Iv78V3Ke5qE2Q+/I5I/h5SM8qPDWq2lOfWW7eFJ+6p
	OWOWCGKkxg8pGf0+OmToOeIHEK1qlTioMYbn/+jzvpxJAQI2qyhCWHYhknSNTglnZBP3b3Ddgqn3E
	pR/whlBZ3bJJhwAgeR0U4aABFGkR+yTZ+wYocoL7Yvzl1ZMP8DIO7C7VL5DOx8yezMawGR/68yCgf
	jG8k4nluL1wNrAti1TpgsqMDro5zbPnjrN/9lSQ5QOt98gqj8tlvgBJpRHeXAYpiqcFJ1Ukq3Hv5y
	QjtvUgHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZNWh-00000007bYx-3JgI;
	Wed, 09 Jul 2025 05:39:27 +0000
Received: from jabberwock.ucw.cz ([46.255.230.98])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZNWe-00000007bYH-1T6J
	for kexec@lists.infradead.org;
	Wed, 09 Jul 2025 05:39:25 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DE9F61C00B2; Wed,  9 Jul 2025 07:39:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752039562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AgGo0D6w/UsINXs2Wle7uc8mU/aFWH/QOKQE3QW+Hgk=;
	b=Iod5xTBHZgdsUmi51ar9v5dLDyhumMRHF8uBR4dIFbZ+ES0dYu7ki4ZhoaDGPmY90IP/DA
	CkV1368WIXJKNOOIzFy0W16xRNktUAbJ2ZruolHwgA7Fy4N4W54g35tmUf3VIcYjnsrHVD
	R5W7pldd1tuedKl6w6PruHRYq4chheE=
Date: Wed, 9 Jul 2025 07:39:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, patches@lists.linux.dev,
	stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG4AilDpnqrqHXaS@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <87tt3mqrtg.fsf@email.froward.int.ebiederm.org>
 <aG2bAMGrDDSvOhbl@lappy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlasF0qNpP9A3mRg"
Content-Disposition: inline
In-Reply-To: <aG2bAMGrDDSvOhbl@lappy>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_223924_710597_2962F29D 
X-CRM114-Status: GOOD (  15.26  )
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


--WlasF0qNpP9A3mRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> In this instance I honestly haven't read the LLM explanation. I agree
> with you that the explanation is flawed, but the patch clearly fixes a
> problem:
>=20
> 	"On AMD dGPUs this can lead to failed suspends under memory
> 	pressure situations as all VRAM must be evicted to system memory
> 	or swap."
>=20
> So it was included in the AUTOSEL patchset.

Is "may fix a problem" the only criteria for -stable inclusion? You
have been acting as if so. Please update the rules, if so.

> > I assume going forward that AUTOSEL will not consider any patches
> > involving the core kernel and the user/kernel ABI going forward.  The
> > areas I have been involved with over the years, and for which my review
> > might be interesting.
>=20
> The filter is based on authorship and SoBs. Individual maintainers of a
> subsystem can elect to have their entire subsystem added to the ignore
> list.

Then the filter is misdesigned.

BR,
								Pavel


--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--WlasF0qNpP9A3mRg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG4AigAKCRAw5/Bqldv6
8gTIAKC/zQyWgLHgvPMd65NHV3TkdPwjRgCeIAbYyb9XFecAJ4qXIm2LIa7gI/o=
=taVt
-----END PGP SIGNATURE-----

--WlasF0qNpP9A3mRg--

