Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56000606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JiR/0/pd;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2iQen/d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YVw/c0AYgqbqbI8tyCer2VyBKwUJPclQOcUFWARRH7I=; b=JiR/0/pdna0ovvh4lg6V7iIXHr
	9rQbc/BHox7cN1hTgQ3MvH6PdPWnXMoiUuNy/XcTRBpCpLtZVq/Tj0Fszb86iZ1xXOAzHzvzTCwbC
	auQdvp9tD3iMo0RYLtmP/cgXzikJRUmaXXTm/AYkNHN+ZzamH8TFczhmq5MAIkpRcs7+eSwDoZbi3
	Gafe2qB210uEwRzj9uODl3qumhqbSJE9Er1EfPHoP/lh0eF2Ar5gojU+wiCxeIhv2Tdb6OxagdZ3c
	ct9lGb1FC7ukWxCVNIUs6y/dxiLaXk6ztVWzovZG+C25sLp08REV0mPi0q6Mt9uv98tvb9D5Nu35A
	rA72+ahw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9vN-00000001aR7-0F2X;
	Mon, 26 Oct 2026 01:54:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9vK-00000001aQC-3fDX
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 01:54:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A0FF240378;
	Mon, 26 Oct 2026 01:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0041F01825;
	Mon, 26 Oct 2026 01:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792979694;
	bh=YVw/c0AYgqbqbI8tyCer2VyBKwUJPclQOcUFWARRH7I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=n2iQen/dcFfkaK+fyfSuedZBAn4RlS7aP0Z7bPopXd3PHjI1rwGt9mGz4kiFEBVKD
	 Mt0zqyInl25Ex6MTrAp+idAFpSuU20BW2Z8FUxx1rKqPmtN1615DoZfbvdKnVRfhF5
	 lokm+hoAbjjIRFB2iCJQftcmYl0NhHEyPmZDtTeyAMS2t2u+jKdgifqFwwde1cTmKk
	 kzk0qQYt4A7/W4wKMHXaEz3mHDj8SiGkQdrRytolTsLJbLGgLlqzCMrGdyiC4MujS9
	 pl1pq8FktMt5SDoi74WBFpg8KnaYK5qR2QCSuzqb+ztK635u9ktQAtJwFGbiqR3afC
	 xP7TDGzt/K/KQ==
Message-ID: <sashiko-outbox-184590@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
 to freeze sessions early
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261026014948.162559-3-pasha.tatashin@soleen.com>
References: <20261026014948.162559-1-pasha.tatashin@soleen.com>
 <20261026014948.162559-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 01:54:53 +0000
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
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026014948.1625=
59-1-pasha.tatashin@soleen.com?part=3D2


