Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AA5CC6B33
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 09:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kGcVXkWaBziCJY8bVVkt3QDnUVCLK5NFlX5MlwftMa4=; b=hbetwsdL30+kp96xKfUmjEya61
	kbcT72bXUKQsMB8BOzJ/5ppmKQFpM9htDIel3peJ2sJ+Jtt88LTKkDCCG0X6XqR+tDFn0aceCTT+c
	Tq//AqrKFjZ/A/BypSIvG4brlUSIsA9NEedu1bMJHf6YvesKrKaqAfaM+TISQCICbbuUF238uA+NH
	7zLl6S7So/2TevkBy9opOiInNAD+CTUpl5QROuWsWeaqfwRVR8TbTJezj7iIuuQqxmqZDs5JClHWC
	ZKgzAFmKkaSNzNTHcCAjqbSPpftriI8O/isORuNAJIXkim04uC1uTE2UyfSEmYnzhAkfgW64vZmcU
	NTIbiwFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHI40-0000000HKOF-0peZ;
	Thu, 15 Oct 2026 09:47:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHI3z-0000000HKNQ-12fu
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 09:47:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E991240486;
	Thu, 15 Oct 2026 09:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA8E1F000C4;
	Thu, 15 Oct 2026 09:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792057670;
	bh=kGcVXkWaBziCJY8bVVkt3QDnUVCLK5NFlX5MlwftMa4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ASfc/1tFtxJJVnBCvJZK5W2HQSbs/NwGc986ipla880diqdRtk75LRR43eml2GXP/
	 LKrthyZmV+XDmlszeqANXqG2hS/dHCsBo3Okf7U2zPgnp4N2JrQuPBYR1jDt3YMn4o
	 AS68wCPBUam66B366VxL0m0z87tOC5ZvbS5KGl3MzqPGnWsSFS+zIhtadF+HYWKfnm
	 5iOWIZiTLELI7t6ZfxWKkoU12ISeEMlRwZegKeUXIYkxIoOVnW4L3nFehBVtX0wT3y
	 vm5rw0njXVa7DAILMwThCzkKRT1pFWcT1QuCb3C3oOkZvtxfY/wSvrCYQWhfcHJVfC
	 CmZyMUdP19ypA==
Message-ID: <sashiko-outbox-172596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/7] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
 to freeze sessions early
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261015093816.2438942-2-pasha.tatashin@soleen.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
 <20261015093816.2438942-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:47:49 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015093816.2438=
942-1-pasha.tatashin@soleen.com?part=3D1


