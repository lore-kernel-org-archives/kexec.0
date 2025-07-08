Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7523FC83F10
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 21:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FPbGDVquPjNFCdLnk3gjYikEVK1iQ5FM8B55Z2acikM=; b=4QTRWZA15ep6UrIJIgtihPsx6L
	QxhyW8z/73EnckvD5yRRB+Ewz40Hv7OLvbB4xNZCRIARcsrXCDP99ob4Rc+ScL07XbUKkB92EYkqJ
	SmFtlTMJD4dXmuJjtoUmY0JfM48O2nw1b9RS1nFkSyeqdvA3i26rLaT2JlNwowKR0h8yoUJy2HLg0
	NbKIAG/yTZ4TxiJFDWysfSQxPC00LiFlWywh1aq5qOiJ+RF1lhIkoYH2ycXjksqm4YmQgOT3JIQBI
	KSZqM17V/6qaVdasFoLJsJ6zfX3Vde/KFvnNdSER2pZvb9lGKf6nby1ufJKZwQYhDD+v1tlZrxYs6
	+0JXBaOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFmA-00000006eCu-138o;
	Tue, 08 Jul 2025 21:22:54 +0000
Received: from jabberwock.ucw.cz ([46.255.230.98])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZF4M-00000006XQH-0Z15
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 20:37:39 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7AA711C008E; Tue,  8 Jul 2025 22:37:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752007053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FPbGDVquPjNFCdLnk3gjYikEVK1iQ5FM8B55Z2acikM=;
	b=qwDekM2XCgBC2riOL+ehBllLuBtozXQ9xCvJmUp/KvGErYDb1V3W1ZFBhrDQ7/TCM7TlSO
	i402zsDt6M2zI2p+vPCFkpfzEO7q7WIG5xfbRQfLQoRYxbWxYWVqvvWdkiOeMFlTVMrOsq
	Z8i9Nt3tw4TObWT5mSZRY+8O5X9PXPw=
Date: Tue, 8 Jul 2025 22:37:33 +0200
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
Message-ID: <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nNCUwPYE9969vNp4"
Content-Disposition: inline
In-Reply-To: <aG2AcbhWmFwaHT6C@lappy>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_133738_609104_542721BF 
X-CRM114-Status: GOOD (  14.72  )
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


--nNCUwPYE9969vNp4
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

Can you read?

Your stupid robot is sending junk to the list. And you simply
blacklist people who complain? Resulting in more junk in autosel?

	  	     	       		    	      	 Pavel

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--nNCUwPYE9969vNp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG2BjQAKCRAw5/Bqldv6
8uqrAJ9aR2BgDB5TDKwRlvnzo5jPapRSRQCgsgZWldJBSXfWXm/fdwX6FNodniY=
=gTnq
-----END PGP SIGNATURE-----

--nNCUwPYE9969vNp4--

