Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC3606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ht/sFtJM;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewLabXiY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7JIM9H1Hkg6mudVqbg+70+z7PVgGq6zLBZ3HI5AzVhA=; b=Ht/sFtJMj05yLQ/KVNf24a+hJS
	CqiRbXwmd4InC7axIu70I+eRGsx4zrGZv3OpYvHo1X3J1wPk76pUWSsuH0P0bFApOkZ/5RiYjc++y
	FoQrBTdUnnsk+5lSzVa49scvkIkJxL6Scn1BSt61rRyiVlBjrAAbOFQdIkHBMoE0lBIdBAzOITIbM
	x/oFQfUFN1peub+gER7vf75Q8QNp2NVK66A1o6HiCs+x3ZwDC8QzC83JNplUJNl997fgRS9CZVwOG
	xmJ7pt3mAr9lkcBjtbnuRSkzeQToPvJWoXa+L4krkLuvu31nc3FBviJO6hKoUrU/HhQpne0uAZPSc
	5JUPUkYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnIs-0000000AKjq-28Av;
	Wed, 18 Nov 2026 21:34:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnIq-0000000AKjM-3vjb
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:34:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9DEF3419E7;
	Wed, 18 Nov 2026 21:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030C71F000C4;
	Wed, 18 Nov 2026 21:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037692;
	bh=7JIM9H1Hkg6mudVqbg+70+z7PVgGq6zLBZ3HI5AzVhA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ewLabXiYKpoQVrJmHi2J0N/6/hOTT6MSAH3e78NuqhSU+5cUUb4p1+z2NFc17Nc10
	 LdNQ/VEO/6Wlo8p7E6C5N1cofkwiZi9m+LXSl0Ax5d0Cvc2bh7dEWCB4RqjerNviya
	 3FJifC1/x2o1BbQyQpMNHl+c8IOtIQQHp1eXzIBqAkAdseFzKR2OAc4BgT+63XTfw5
	 9hZhU1lJqNxe/mUjuS8S8s0EOc7v5G1eNZ7qD5z0I3MCqUDoKTBB1gdGrzwPIipdmf
	 Zvgq/lkNrZ9mhNzBtqOpSLv7AdCfUar0ry6RNswR92yiWArLnTzf/RgBXr7d+R5g2k
	 h24zJS3+U/gOA==
Message-ID: <sashiko-outbox-222008@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/7] selftests: liveupdate: Add unit tests for
 LIVEUPDATE_SESSION_FREEZE
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, vipinsh@google.com, corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, graf@amazon.com
In-Reply-To: <20261118212845.2855249-7-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
 <20261118212845.2855249-7-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:34:51 +0000
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

> Add a luo_session_freeze() helper and unit tests in liveupdate.c for
> LIVEUPDATE_SESSION_FREEZE. Verify negative cases (unsupported flags,
> double freeze, and preserving files after freeze), that closing a
> frozen uncommitted session unfreezes and returns resources, and that
> closing a committed session retains LUO ownership of the session and
> its preserved files.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118212845.2855=
249-1-pasha.tatashin@soleen.com?part=3D6


