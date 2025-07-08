Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92028C8303C
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 21:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZhTr8BNsb/IuarKIUCHdKLZrZHK9BdGzp5OHwK+lhU=; b=ODOUa9IalKRIzphyNM2lb0E9ob
	lU56NE1uSD1GzF9/37HhwmruauE511Z2f9X0StHVV8L3WCSrq3Q/9VJLt8nfYlmf6YTXXh8zdy7Ov
	E93aFRdHoYHRhE/c2q/jQu99WFmsHlods4vwhbbJXtYY8RD7gaBlM9aPiftJvlyijTh11IJdizK2a
	9QyJW/kSxmiEYZEFCcMKqC2mFul/4Yyk+dno20mKRm1Z7xxTmFC5bIgGd6MbOyCbnWscITgDY560K
	BMEmZzespk/ik2FrElYCM7bGpwDoH5Y4bRvj/bcUPFgewshMzmTHmcs1jFY4FfwG+dtvVIVIjxf6l
	cA4u0dtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFoV-00000006ejB-0Sac;
	Tue, 08 Jul 2025 21:25:19 +0000
Received: from jabberwock.ucw.cz ([46.255.230.98])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZF8Z-00000006Xtx-0NDD
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 20:42:00 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CD9461C008E; Tue,  8 Jul 2025 22:41:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752007317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZhTr8BNsb/IuarKIUCHdKLZrZHK9BdGzp5OHwK+lhU=;
	b=RX7Jeon8wS2ySxsAnXhakzhF4H3VSMWaw2X6XumJhMHs5hLCtDfHE/FGnpDqRkxP3rlcIO
	Ood3GWLZu+1jQtnixserm+7FLHxEdRvWRKon8HEn1RqE7HnvuZEHRHoeutXkb7244c9VDx
	//T5r7vYBnWF/LsuR0a0LuGGlT0NU/0=
Date: Tue, 8 Jul 2025 22:41:57 +0200
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
Message-ID: <aG2ClcspT5ESNPGk@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FIQQfs2YSIsZNrSH"
Content-Disposition: inline
In-Reply-To: <aG2AcbhWmFwaHT6C@lappy>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_134159_271597_6BB752BA 
X-CRM114-Status: GOOD (  15.83  )
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


--FIQQfs2YSIsZNrSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2025-07-08 16:32:49, Sasha Levin wrote:
> On Tue, Jul 08, 2025 at 02:32:02PM -0500, Eric W. Biederman wrote:
> >=20
> > Wow!
> >=20
> > Sasha I think an impersonator has gotten into your account, and
> > is just making nonsense up.
>=20
> https://lore.kernel.org/all/aDXQaq-bq5BMMlce@lappy/
>=20
> > At best all of this appears to be an effort to get someone else to
> > do necessary thinking for you.  As my time for kernel work is very
> > limited I expect I will auto-nack any such future attempts to outsource
> > someone else's thinking on me.
>=20
> I've gone ahead and added you to the list of people who AUTOSEL will
> skip, so no need to worry about wasting your time here.

Do you have half a brain, or is it LLM talking again?

You are sending autogenerated junk and signing it with your
name. That's not okay. You are putting Signed-off on patches you have
not checked. That's not okay, either.

Stop it.
								Pavel

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--FIQQfs2YSIsZNrSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG2ClQAKCRAw5/Bqldv6
8oVqAJ0R4LSUicsx/XcVgjLO2Is7LGBfcgCgnqYVuoQFYklyJ2fQpX6V5XYDkZ4=
=0ktO
-----END PGP SIGNATURE-----

--FIQQfs2YSIsZNrSH--

