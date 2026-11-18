Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E1606A333
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wGMRzKgc;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFkJOEKN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7iyiA15Lra8dC3NIy8IcJ9TxehM68cQQGrV3SSR991c=; b=wGMRzKgcrCmuGesNPqqEZZAyXl
	ISaVq4cwFU1ZESJrEPW3yYr6IRK1GzICzwjffqFnzQwRpKzNW7IjTiY5WUCY77cXVRxVPDZL6XnP4
	F3FZBI8tAjh6DattMzZo2WipzSYngXhs2t412oSXVravTUGP7LZWsl+cEg9NSkT+MHOm2+SZfHKBc
	cktqMsqA9NN352nSt03/Pg6q9Rp8k10rzos/N5N+E9c2REN1l8nhSUYzyDzlGmWZxgTMEgWEqJHY3
	1FpNPO99lmnUz8LVwiX6EhCh7xOFxObe0P8W8oQ66SVKIhlMsyFa9V6pivh6d2Xbf9df8q9mcm3yv
	N8PAdxBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnLm-0000000AL8q-4Bna;
	Wed, 18 Nov 2026 21:37:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnLl-0000000AL8j-0xtP
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:37:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9DAC263EBE;
	Wed, 18 Nov 2026 21:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61001F000C5;
	Wed, 18 Nov 2026 21:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037872;
	bh=7iyiA15Lra8dC3NIy8IcJ9TxehM68cQQGrV3SSR991c=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UFkJOEKNtIYX73ey5FuzHL1TdNs4vezV+jgA9s/oktY+TDDqReGHmPsf0q6RbuVa2
	 4yfmhDVRMWNhda7ZInZpk06gGo0LYWl7UWXJGB+1OhUZLkKJDen0nEqPRi3tjL3z3g
	 E1OfroCTLRZjW4opJvW/CBBg4pIXi1NDMlXKpLI0KzpTT+PIMectL2TDa/gaRE6B2i
	 Ngr49l+sAjqe3/hC4itDy7E+OMEbTNLjGXaMLzM/TJtgXkRHz5hMlUhQvH2zdc2uSp
	 eK+AHLkB6u3WJmEfArnADUbzPYcoRap2uFdfNwL3j3hd4sPqBM5cDPN9eRzNWqZrnF
	 xzFIdUlFi6hPQ==
Message-ID: <sashiko-outbox-222015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/7] kho: link outgoing blocks lazily in kho_block
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, vipinsh@google.com, corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, graf@amazon.com
In-Reply-To: <20261118212845.2855249-3-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
 <20261118212845.2855249-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:37:51 +0000
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

> Currently, kho_block_add() links each preallocated block onto the
> serialized chain immediately, even while it is still empty. This
> assumes all preallocated blocks are populated together before the
> chain is referenced by KHO.
>=20
> When sessions are serialized incrementally ahead of reboot, extra
> blocks may be preallocated for sessions that have not been serialized
> yet. Keeping those blocks linked leaves empty trailing blocks on the
> KHO chain.
>=20
> Keep preallocated outgoing blocks unlinked in kho_block_add() and link
> each block lazily in kho_block_set_it_reserve_entry() when advancing
> into it. Also unlink blocks in kho_block_set_clear() and stop at
> unlinked blocks in kho_block_set_it_read_entry().
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118212845.2855=
249-1-pasha.tatashin@soleen.com?part=3D2


