Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6092CC83F09
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 21:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eo6RLYnfDwilrvMsNkS6FuRCCx3qPpmVDAwaxfXrbHM=; b=zQLCkM30HAYoLsq3Nr1kX0xFjl
	am8/SNrlpvDwtsfXwLdaUPedX7s7tS2DBbLYiywf0DRWEjRW4YzVXGdOI/DTseu4erG6+FJTVKVlK
	ZrFvadwcJHn615rM6ukGZdmvn6XW6qf08v9XaHtsVIB5Ezut5eOvIeWDgE3IQw//i9vqroRhv1K6P
	vUUAHG25n4OHbSO9utBL77Qius0T0DOEVgmcCpRfALFonSnfRtLqvyfeX6SXKx7igSKXvyu+jg6MB
	BXYoCjv3SkLOQLlFRR8N6rGtBmH+pF+YUnZnfuPes3THYtdMwnAakj9nN3/JdUf8M77Yx0V8nLFwj
	qfpVFTUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFmA-00000006eDB-2gZR;
	Tue, 08 Jul 2025 21:22:54 +0000
Received: from jabberwock.ucw.cz ([46.255.230.98])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZF5Z-00000006XWu-32TZ
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 20:38:54 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7AFFF1C008E; Tue,  8 Jul 2025 22:38:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752007132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eo6RLYnfDwilrvMsNkS6FuRCCx3qPpmVDAwaxfXrbHM=;
	b=RCtuY5pt6EofRPXHAagFGKHELeg6upWbmkojqAswlpCA9UP4sIMf3oc9I5ssIKPXGsMV15
	2VoLCpFlAejpZzresIVvMAWAZV5rdQ3Q3jKsyaAKBwguMyEeaPo8ZMwwOEZC0+4Ba9Hxop
	JfSmbBao6709cOZnUikFu40vKL6ST20=
Date: Tue, 8 Jul 2025 22:38:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
	stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG2B3PvCNmI51bqI@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AJONLeuTvitsawye"
Content-Disposition: inline
In-Reply-To: <87ms9esclp.fsf@email.froward.int.ebiederm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_133853_908522_ECDC7A36 
X-CRM114-Status: GOOD (  14.88  )
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


--AJONLeuTvitsawye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> Sasha I think an impersonator has gotten into your account, and
> is just making nonsense up.
>=20
> At first glance this reads like an impassioned plea to backport this
> change, from someone who has actually dealt with it.
>=20
> Unfortunately reading the justification in detail is an exercise
> in reading falsehoods.
>=20
> If this does not come from an impersonator then:
> - If this comes from a human being, I recommend you have a talk with
>   them.
> - If this comes from a machine I recommend you take it out of commission
>   and rework it.
>=20
> At best all of this appears to be an effort to get someone else to
> do necessary thinking for you.  As my time for kernel work is very
> limited I expect I will auto-nack any such future attempts to outsource
> someone else's thinking on me.

I'm glad I'm not the only one who finds "lets use LLM to try to waste
other people's time" insulting :-(.
								Pavel
							=09
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--AJONLeuTvitsawye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG2B3AAKCRAw5/Bqldv6
8jHUAKCBRM9dpSXf/a3kW2TLJphvmrhL2ACffbxa0/7En8c+6ZvpDgJvwb2nW78=
=gVSQ
-----END PGP SIGNATURE-----

--AJONLeuTvitsawye--

