Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A74C8303C
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 21:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LD0jV/9ETPDQjueVoxO1J46hQbXvI3qr0F5qgo1rUzo=; b=NdMEuIU5v9F8rS2LLnablMm4aZ
	0RuvORzoPPy6yG/XkCk9HcQKhVQBmRN+0x2ONeKVOXuuzzJZcCF4qUNjeyYOLOQ5DUB/kzFilegcE
	5UoLCBJL1h2WwQxg8dUSKqY31KXWtuDFpQ4KdRfwzal6HxFv+V4MXwMcLmhWyTWtJb0XQOBUawXEQ
	FTwtY9prZY7iEfF45unsqAp+FPOD/dKOldD7i3hNZT3ImWeue08DBWmLyMbMHWfz3vVgAB8eEewg8
	RyA2E8CWA/69LKfVZaJvYva853Dmg51YbMqCUk62RP0gCBISP6+7sBm1qLLRbcbl5OIa/H9g35ge+
	kqOZtbHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFvS-00000006fyh-3YfJ;
	Tue, 08 Jul 2025 21:32:30 +0000
Received: from jabberwock.ucw.cz ([46.255.230.98])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFpE-00000006ew3-25WO
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 21:26:09 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 05F791C008E; Tue,  8 Jul 2025 23:26:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752009963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LD0jV/9ETPDQjueVoxO1J46hQbXvI3qr0F5qgo1rUzo=;
	b=Zv84NmEP5bfltdOq3XEN/eXdbg0FvJCc/LZpS56h+bEs8887Iv5R2048NDz8WLn8d78I4c
	Zc9O9iDl6jhYjOXACo1cXjl8Unddaqq2WY705WKskpHTxrgdnb8B7Pq85ir8bYGs61RkyA
	bHBSv6MtZlfCuDQOCj++FDbuah82SM0=
Date: Tue, 8 Jul 2025 23:26:02 +0200
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
Message-ID: <aG2M6rmyLqsub8/8@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
 <20250708204607.GA5648@1wt.eu>
 <aG2JzsVKuBkFcXj9@lappy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYDyTl+a+81TEOKE"
Content-Disposition: inline
In-Reply-To: <aG2JzsVKuBkFcXj9@lappy>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_142604_678996_211856A5 
X-CRM114-Status: GOOD (  18.39  )
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


--TYDyTl+a+81TEOKE
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
>=20
> We have a list of folks who have requested that either their own or the
> subsystem they maintain would not be reviewed by AUTOSEL. I've added Eric=
's name
> to that list as he has indicated he's not interested in receiving these
> patches. It's not a blacklist (nor did I use the word blacklist).

Can you please clearly separate emails you wrote, from emails some
kind of LLM generate? Word "bot" in the From: would be enough.

Also, can you please clearly mark patches you checked, by
Signed-off-by: and distinguish them from patches only some kind of
halucinating autocomplete checked, perhaps, again, by the word "bot"
in the Signed-off-by: line?

Thank you.

Hopefully I'm taking to human this time.
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--TYDyTl+a+81TEOKE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG2M6gAKCRAw5/Bqldv6
8uWXAJ9iwtaQ4B9BUZoI/jwJndhFnx3B5gCfY34DANR721Opp073dZHhyFfrv4E=
=dg3Q
-----END PGP SIGNATURE-----

--TYDyTl+a+81TEOKE--

