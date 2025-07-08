Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF770C8303C
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 06:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BkQDJKWFePkir3VVOngFU49HXADxPt6pfGrGXj/dAME=; b=NnkzRfwTrw0B+fGN0Zqsqon5AS
	mpJRcoXSaLjoK2pNIeWvBnUgZH4qCdHIjxcHpQLftNfUA9T/QuznwPB/jivGs/0eH34XSjIBkN/cY
	8bBsCP1tBiSQhGYDfbr1mGDGMLWN1ykKgGbHviX9ErgS+TNP3b39rDV5Z7rg6kCKt9OdkLUoW9jFX
	lP4Q+f94xConKjScTpKuMlzqF8UtFw71Dzrm6gySwpXX0NGtF48PYfSenBr+UoNh1Gsctig80REKR
	H/geRPE/ss6l1wfhAjt+nIbb7rzEnjs1DuD3Zy2Gf+A9fgWu3JXiVgupvTJXpQFC0P7u43Gw3iQZ+
	AiEQ3kyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ1zc-00000004Sai-0o3t;
	Tue, 08 Jul 2025 06:39:52 +0000
Received: from jabberwock.ucw.cz ([46.255.230.98])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ1zZ-00000004Sa4-1Vab
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 06:39:51 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EA5551C00B2; Tue,  8 Jul 2025 08:39:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1751956787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BkQDJKWFePkir3VVOngFU49HXADxPt6pfGrGXj/dAME=;
	b=pi9S06D/6cVWHJpKxkRtDpDBSlrWst1CBY0sx2rT9xV6TtgDCsNaqgO3WyNekmrrEgNPKv
	2IsGB0eSptYebbZJzyzlSLJjSkePo25qvzS13RPNykBqBw7sYCXVrzeaVATXOK/U9Llx2c
	9RZ5v8uUF+67/IdD+irc9CBiQX6zQmg=
Date: Tue, 8 Jul 2025 08:39:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, ebiederm@xmission.com,
	linux-pm@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aGy9M3zEX7rgo5sS@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1kwsET5uSiv9nLtr"
Content-Disposition: inline
In-Reply-To: <20250708000215.793090-6-sashal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_233949_699572_FD3F48FD 
X-CRM114-Status: GOOD (  13.78  )
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


--1kwsET5uSiv9nLtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> [ Upstream commit 12ffc3b1513ebc1f11ae77d053948504a94a68a6 ]
>=20
> Currently swap is restricted before drivers have had a chance to do
> their prepare() PM callbacks. Restricting swap this early means that if
> a driver needs to evict some content from memory into sawp in it's
> prepare callback, it won't be able to.
>=20
> On AMD dGPUs this can lead to failed suspends under memory pressure
> situations as all VRAM must be evicted to system memory or swap.
>=20
> Move the swap restriction to right after all devices have had a chance
> to do the prepare() callback.  If there is any problem with the sequence,
> restore swap in the appropriate dpm resume callbacks or error handling
> paths.
>=20
> Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Nat Wittstock <nat@fardog.io>
> Tested-by: Lucian Langa <lucilanga@7pot.org>
> Link: https://patch.msgid.link/20250613214413.4127087-1-superm1@kernel.org
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>


> ## Small, Contained Change
>=20
> 3. **Minimal Code Changes**: The fix is remarkably simple - it just
>    moves the `pm_restrict_gfp_mask()` call from early in the suspend
>    sequence to after `dpm_prepare()` completes. The changes are:

This is not contained change. It changes environment in which drivers run.

I have strong suspicion that you did not do actual analysis, but let
some kind of LVM "analyze", then signed it with your name. Is my
analysis correct?
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--1kwsET5uSiv9nLtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGy9MwAKCRAw5/Bqldv6
8ghtAJ9sA/huV29bml+0HHb127MElooywgCgnva6bxPc+31mjS5JfXMx0Nis0Ns=
=KqmG
-----END PGP SIGNATURE-----

--1kwsET5uSiv9nLtr--

