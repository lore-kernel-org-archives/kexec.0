Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AB5C3DA7A
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 20:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DjoKhOvkOi4Zu54MYTvGlaBVWzjZuoUwlv0dKQIhKhI=; b=yTPUTJB8xWZI+kwkPKQ1kcoaBO
	JjmOb3KV7n6Aw5mryT3hRIRcH0dN4GNJgrbTTqlkSFZU7nWJWnksse0An98elCC5p2WY3b5qNHEtX
	J9ERtM3hnN4d2Nu2TVRgMql9yFPnHoinao45zo+YWg0lvCeNosf2q+nHrIrARelsbJCYRox/z1+Mt
	QScPsYAJKQ3c2QcBwzaHVJHKD6HBEfoSh/oB4c9wQZoWx4hqiWk7PRa5EblZEebQAaTqCeJnp7A3m
	Q3cNCSA2QexXenCKJuX57cKCWIXO5bCQQRzXJrhenSofc2ZhUIXD8rAkoWqWoRZfYAeifnvAKzp5Q
	UL1JOSFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH5Gd-0000000GFMk-2rGY;
	Wed, 14 Oct 2026 20:08:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH5Gc-0000000GFMe-1u36
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 20:08:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A16CA6020C;
	Wed, 14 Oct 2026 20:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FC71F000C4;
	Wed, 14 Oct 2026 20:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008481;
	bh=DjoKhOvkOi4Zu54MYTvGlaBVWzjZuoUwlv0dKQIhKhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YIFFC3/L4u/L4TBc3NwAZhuR7Q7/VQMDzPaXRo0ED0nUL6xXZamCIFruLhMa9iGP5
	 /niVIxGs2V5b/k2dVM8Lmtl7TwWzxtA+S1apJQ9uwdZcUcWGrGZfsmY8kLPbi8cNfY
	 IHmm71yoyFoZF8C96s2cn6t/5wIwVWLe/U00x/vOy3PMjrJjRPcXabtDwYOL/vxq71
	 9u2lHXBvG+AtMFlLl0wDxTA5fnxZGiMoeqTJJW8RCIqMgQLs/VRSwfb5cdpyCrHV49
	 ZwQ6zt96W+pyBHAt1bH4XLnFEiY9tYG8vuUbaar7ar+l4CXqgBpOi6Ns2bdJLKiGra
	 Jwu6n/0ecNXUQ==
Message-ID: <sashiko-outbox-171823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] selftests/kexec: select tests using the target
 compiler
To: "Sasha Levin" <sashal@kernel.org>, "Shuah Khan" <shuah@kernel.org>
Cc: "David Woodhouse" <dwmw@amazon.co.uk>, "Nageswara R Sastry" <rnsastry@linux.ibm.com>, kexec@lists.infradead.org
In-Reply-To: <20261014200127.1363472-5-sashal@kernel.org>
References: <20261014200127.1363472-1-sashal@kernel.org>
 <20261014200127.1363472-5-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 20:08:00 +0000
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

> The kexec Makefile recognizes PowerPC only through the ppc64le spelling
> of ARCH, so the canonical ARCH=3Dpowerpc used for cross builds omits the
> tests. The x86 jump test is selected with IS_64_BIT from
> scripts/Makefile.arch, which describes the build host rather than the
> compiler being used. On other architectures the Makefile includes no
> lib.mk rules at all, so installation and runlist generation fail with
> missing targets.
>=20
> Select x86 and PowerPC from the target ARCH when it is given and from
> the host's SUBARCH otherwise, without assigning ARCH, so that lib.mk
> keeps choosing the compiler's native clang target. Ask the selected
> compiler, including USERCFLAGS, whether it targets a 64-bit x86 ABI
> and whether it targets little-endian 64-bit PowerPC. lib.mk expands the
> generated program list before it appends USERCFLAGS to CFLAGS, so the
> flags are passed explicitly to keep both probes consistent. If the
> compiler cannot be run, select the jump test so that the build fails
> instead of silently dropping it. Include lib.mk unconditionally so that
> unsupported targets build, install and emit an empty runlist.
>=20
> Fixes: 65e38e32a959 ("selftests/kexec: Enable secureboot tests for PowerP=
C")
> Fixes: 7615b94b6371 ("selftests/kexec: Add x86_64 selftest for kexec-jump=
 and exception handling")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014200127.1363=
472-1-sashal@kernel.org?part=3D4


