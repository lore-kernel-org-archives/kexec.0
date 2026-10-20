Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B48606A31C
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fIORYJ/4;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F/S6ZaNE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gYAMJZMYYUr28qOA5v4U2pNPBiDWRbWqBW+VYpTbCGA=; b=fIORYJ/4uiXFLeeZMgVEXHSl6J
	51sEVXNiwJ1kz74kF0TW9Ay1Ul56iUjoa+rgIOf8u5DsR3SIzeUAYiKZGBBMOxNjCtKQf8I75Bmy8
	P9b0USEM5kOZg8B3Iy/p5bVImQTagRIjUIHOoH6w6MP3f1ZHZJyLTh+tXy1u28mPBDX/EZfJwvY5/
	5hx6c1i4/A+jPnjUDIxGnTzehQJFmpAk6Kggbu38FfxZWRrbidfJ73MY7/88tkC9QSKzGM31nCUuY
	G1KFz7VlR04mmWIYFjEelOSmKQpMs7kB7szTY3biEMKyaIus2XFQCj98q/2gZrFue7f2I94X/Cr0m
	dOg0VwHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJBCa-00000009zpK-3F6y;
	Tue, 20 Oct 2026 14:52:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJBCZ-00000009zoZ-2RxP
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 14:52:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C3CF760052;
	Tue, 20 Oct 2026 14:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20511F000C6;
	Tue, 20 Oct 2026 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792507950;
	bh=gYAMJZMYYUr28qOA5v4U2pNPBiDWRbWqBW+VYpTbCGA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=F/S6ZaNEcgjM8UucaDGgQnurw8MYlORy/wLcm/Ax6KuIJL3qBtEWMUAtpqhYAKUPa
	 9nBIDLrIZGru+KY+Rc7tYgVXMGzCh/SqF/UJxwWp4Y6g9cSgha8WVet2VsPc5beBJN
	 Ceq24mpq/NjxSd8amMcrH5pDUJaNnUB7DBqnnvnGdS01p0IlWwNCQY+7ITK6zV1SXG
	 NwVzE1vnXMMBWy9cjl7yoOyYszsKLKiU/aB0K9Y6grAT+X/Nud4BvPXTnhZn3n9UVs
	 MStL/h/PfZEP9w2h4FfCeKMqDOJe+Bdh1bwQmIIrpBPnYBtZKQSP6AO0vjAEOQN0BA
	 aPVML2kYjDwdw==
Message-ID: <sashiko-outbox-179198@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
 to freeze sessions early
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261020144710.4154339-2-pasha.tatashin@soleen.com>
References: <20261020144710.4154339-1-pasha.tatashin@soleen.com>
 <20261020144710.4154339-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:52:26 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Currently, LUO sessions are frozen automatically only inside the
> reboot(LINUX_REBOOT_CMD_KEXEC) pathway, where luo_session_serialize()
> iterates through all outgoing sessions under global write locks and
> freezes them serially during shutdown. Allowing userspace to decide when
> to freeze a session once it is done with it (and to freeze multiple
> sessions in parallel, since luo_session_freeze() only acquires the
> per-session mutex) avoids postponing this work to kexec shutdown and
> reduces blackout time.
>=20
> Introduce LIVEUPDATE_SESSION_FREEZE on session file descriptors to freeze
> a session early. The ioctl runs .freeze() across all preserved files in t=
he
> session and serializes their metadata. Once frozen, no additional files c=
an
> be added to the session, and subsequent freeze calls return -EBUSY. Freeze
> is only valid on outgoing sessions and returns -EINVAL on incoming ones.
>=20
> During kexec, sessions that were already frozen early are skipped, while
> sessions that did not invoke this ioctl auto-freeze as before. If an
> early-frozen session is released before kexec, its files are rolled back
> via .unfreeze() before being unpreserved.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020144710.4154=
339-1-pasha.tatashin@soleen.com?part=3D1


