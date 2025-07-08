Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA4CC71130
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 06:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bGgcpchThyaS8l2Hc36HS7Y6M+lQ4b+fg61q8zxLeOE=; b=jZ0ZCC29v7rrXTrHV9ZnBzOJdj
	L15sBsft+V/36Rf9ekki5UBPbe1lhSnW7uNsgxJT2IpqSeyXkRF3An3WAxstlMredRUwVBddzq4kQ
	UHtsUlzP7/iU9j8i5KPzZAhIPnkVO3lsU8I/a5OO790Z9CvbIf3OOZt5BrCad9CsM71bc7TsLRoWq
	zVy03HsM6ZaE1DCzcf78GrxsQLqBja/NFDD0IXUVCls/6uLEQo0qzESPxwDq0jpHEXCEYN6156w4W
	gsuNidyq8IegOXq+e84LMyMQ0/GirXdY4Ouvttp/kQQegIbNVNtEIi/dRoicP0niKEXu7SfxdcpT/
	2ttLLiCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ1nQ-00000004Qig-0MmO;
	Tue, 08 Jul 2025 06:27:16 +0000
Received: from jabberwock.ucw.cz ([46.255.230.98])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ1m4-00000004QWI-169m
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 06:25:54 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 19C051C00B2; Tue,  8 Jul 2025 08:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1751955947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGgcpchThyaS8l2Hc36HS7Y6M+lQ4b+fg61q8zxLeOE=;
	b=ZvKQPOrYin5rORTW8dGaSBJMLir7d8ooEWy9ttIcBuJyB46y+OScXquCr3SMX+IJOP50RY
	oBNFdZrqqEJNeRsXuJ0Vo1PHHh3ULHGqJW8dMeKBSOWlTlUX6UIZViM4dqfcd6vFe44yyj
	zoVmoyYZxTLY1Zd/ZwoJo+drceiC/Lg=
Date: Tue, 8 Jul 2025 08:25:46 +0200
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
Message-ID: <aGy56l2BPsD0xf2+@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2tzhd9hOi4+BcZdQ"
Content-Disposition: inline
In-Reply-To: <20250708000215.793090-6-sashal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_232552_755953_56271B2D 
X-CRM114-Status: GOOD (  17.46  )
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


--2tzhd9hOi4+BcZdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2025-07-07 20:02:13, Sasha Levin wrote:
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
> ---
>=20
> **YES**
>=20
> This commit should be backported to stable kernel trees for the
> following reasons:
>=20
> ## Critical Bug Fix for Real User Issues
>=20
> 1. **Fixes Actual Suspend Failures**: The commit addresses real-world
>    suspend failures under memory pressure on systems with AMD discrete
>    GPUs. The linked issues (ROCm/ROCK-Kernel-Driver#174 and
>    freedesktop.org/drm/amd#2362) indicate this affects actual users.
>=20
> 2. **Regression Fix**: This is effectively a regression fix. The PM
>    subsystem's early swap restriction prevents AMD GPU drivers from
>    properly evicting VRAM during their prepare() callbacks, which is a
>    requirement that has become more critical as GPU VRAM sizes have
>    increased.

Stop copying AI generated nonsense to your emails while making it look
you wrote that. When did this regress?

								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--2tzhd9hOi4+BcZdQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGy56gAKCRAw5/Bqldv6
8nU4AJ48cp7MxsYXIM3PB6GjjjOtV38NtwCeMtGtDDVKEWDjWn+LFSykRx1TfbU=
=alWM
-----END PGP SIGNATURE-----

--2tzhd9hOi4+BcZdQ--

