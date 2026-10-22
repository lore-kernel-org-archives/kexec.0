Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497960A2613
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 02:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2V0wusie;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+oP8EBL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3dXhVJAvltFbXjWv/MwSJt3IG8Jdyzq4Meb3s8xafDo=; b=2V0wusierJePoEZW5kF91t62DJ
	3L3hTwCQ7mspWzKo+XRTZswXI9e9/Cz5cg6geXsVVolOn8YK2wBv23OEHMi6W7a562CFn9v8iQh3q
	9NAgWTGahLh3qcsRV+hcwIx+f/T3ex0ckeeHX2MJP6Hw7kvXnK6QzBM82pb4wae9c0UmS9y2WeuOJ
	bwERXJcGBtwDYw9FivJj1MY9MYZVw4xQTb4NKYHaWhUMo1xuCX98EgAPN7Kw6nKGGHX9wuThzUOhY
	HwWn9rFZ+iXFvSWMwSzzhYtOb1inBm1Bm0O5xO9PYCnjQ0IF0j+Ml1feZumRqHyEtHlqqyQVPF32x
	2LiidONA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJiAW-0000000DAxI-2drj;
	Thu, 22 Oct 2026 02:04:36 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJiAV-0000000DAx3-0LfW
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 02:04:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8160644829;
	Thu, 22 Oct 2026 02:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5641F000C1;
	Thu, 22 Oct 2026 02:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634674;
	bh=3dXhVJAvltFbXjWv/MwSJt3IG8Jdyzq4Meb3s8xafDo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=O+oP8EBL4nPp4Myy3kn1mYXlWVPaJOEV7S5nnd+BtKA+ZNpyZKlTkGjyfclEMPuvY
	 ABqRyWNlndPvvjXM+W7NfRWfnSURe9lmC3NoWrRW0YXIQ6Q44O4J6/E3VtvcxwZp2y
	 PBsLB4hy1yyyHk1c/8X7xy/K6AlZnZB04wTnwCrni+sCZxhIrGXRrLLqJZwjD8U13l
	 /UlyipYx6LWK7kRevKe7m5FhtIBkuYKdVQ0AYo4ZSwqug3luzNW0WUomRlhRnqJpyd
	 6wCp3ulRh5jyi437E5coKpdLOidoMqMBrR7OrHoTeR0VxhYKFI8hOZIcKarcZ7hotc
	 WrwYie5y0L8+w==
Message-ID: <sashiko-outbox-180856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
 to freeze sessions early
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261022015844.2795816-2-pasha.tatashin@soleen.com>
References: <20261022015844.2795816-1-pasha.tatashin@soleen.com>
 <20261022015844.2795816-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:04:33 +0000
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022015844.2795=
816-1-pasha.tatashin@soleen.com?part=3D1


