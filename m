Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA6ECA5FA3
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=56BxWF8z/reF8ypYDw5KpTL0l2aDGF9pTpnE6xZCNrs=; b=HQcnP/dbrWdRddWwupGusZmssE
	ngyoog/RROtTocIfRGNera3eW+CP1k3qFu0leO8li3WR5uUz/IUcc/nL+56jW6JG+bb1r9zYqoa/m
	VS1Qz/IqRtxzkp/fxuQvbW3ZudXaxjqPNLrbgLeP3qGTtyz1Gv/jDQd+fvhhWi0bdaM+e+3NDsK7L
	uXRQ6ksqJB84CfTNmQkHBkJpX1Lu5Ni6oA0gDSdKHurgjjbc+gpq1IQqMBjm22aDvRXa2C5wNZ0pn
	M9iY/FdO8wtpteoFLBN1XjKnHMRyY3XRNzZJa8LNufEOwdwRL/i9MIpnIlbvyJPTwJGoSIEWf7cWo
	TrFSQOaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFFK-00000001B4n-1HYb;
	Mon, 28 Sep 2026 17:34:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFFJ-00000001B48-0Ytm
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:34:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 90F89601FF;
	Mon, 28 Sep 2026 17:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC311F00893;
	Mon, 28 Sep 2026 17:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616872;
	bh=56BxWF8z/reF8ypYDw5KpTL0l2aDGF9pTpnE6xZCNrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZsTmcLgE2/ZooJgOsZcL7H3uFx363nXNblOsqsLrv9KBo5qclY8yqU/RGP9ph1cay
	 D4qe/gVrzVxzSGY/rJn76bN1oyx64b32IVcL82LLVALwybXed2fn3B9YrKUfvXCzKn
	 msmVgZOSrFNny3hQzgTgj4AxKsxHvxyhf9QbvW1AnxwbtV6xOan9MNFsoczC7mYUZd
	 b8xqU7WZyVxBhKSrQOSwqAJ3MniYckmJ9LyHVOPnmEHv/tFNcg6jUjqViK7nIjUajt
	 /V1swvrD/XLn6hx3M1ck2lQxR5MTFg31cASPRsnAgK6C4OfELwmgUYzZ6OYovJB300
	 9G7shR8rJAhCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] kbuild: Move gen_init_cpio and gen_initramfs.sh
 to scripts/
To: "Nicolas Schier" <nsc@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Luis Augenstein" <luis.augenstein@tngtech.com>,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Alexander Graf" <graf@amazon.com>, "Nathan
 Chancellor" <nathan@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Willy Tarreau" <w@1wt.eu>, "Maximilian
 Huber" <maximilian.huber@tngtech.com>
Cc: linux-kselftest@vger.kernel.org, linux-kbuild@vger.kernel.org, "Askar
 Safin" <safinaskar@gmail.com>, kexec@lists.infradead.org, =?utf-8?b?VGhv?=
 =?utf-8?b?bWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20260928-move-gen_init_cpio-to-scripts-v4-2-f437a33c40ac@kernel.org>
References: <20260928-move-gen_init_cpio-to-scripts-v4-0-f437a33c40ac@kernel.org>
 <20260928-move-gen_init_cpio-to-scripts-v4-2-f437a33c40ac@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:34:31 +0000
Message-Id: <20260928173431.8FC311F00893@smtp.kernel.org>
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

> gen_init_cpio and gen_initramfs.sh are part of kbuild and required for
> all kernel builds w/ CONFIG_BLK_DEV_INITRD.  Move both to scripts/ to be
> more clear about their importance.
>=20
> Link: https://lore.kernel.org/all/aSdrCFkUQup3qb-q@derry.ads.avm.de/
> Reviewed-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nicolas Schier <nsc@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-move-gen_i=
nit_cpio-to-scripts-v4-0-f437a33c40ac@kernel.org?part=3D2


