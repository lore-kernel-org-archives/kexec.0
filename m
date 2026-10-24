Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB3606A31F
	for <kexec@archiver.kernel.org>; Sat, 24 Oct 2026 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=g8JedZCI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kiqo9dYP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MTgxqj2r7i6Z/Ce9+AOYH1DerVm+Dt5ogfG8Z/OLnKU=; b=g8JedZCIbOnGmKnk43qnex50Y7
	LyFoJt3kbvHA0VcusW89wFXoYen1Ip4hp+DuxqoohnDyJYnQuPV8qGrmB/VcViiJsDhIhLexrseFv
	F0aPOSMlZ42eHz5nhulS+ZDK9kcvARjfQvzxcuWAK5sqKZxF9o6/BCLlNng74ly1rZ+eQUCioBbFS
	mDz05Mv7xhlGBSzd6OyMdQauLM6jAB+lbtl3ZLuRXYqrLgviIGmNGYon90xtXGPaUbLXSXjUAgt89
	w5cPS40VWOotRQIA2QwdWWsWYRs9GL0ZSsctStR75JPLr0QmNXzmXaesARAeXrjEeLUHOzoU00aBb
	RXTAQXZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKZjs-000000007iM-2EEu;
	Sat, 24 Oct 2026 11:16:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKZjq-000000007hn-2zWM
	for kexec@lists.infradead.org;
	Sat, 24 Oct 2026 11:16:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 79AE743D4A;
	Sat, 24 Oct 2026 11:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDED81F01825;
	Sat, 24 Oct 2026 11:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792840598;
	bh=MTgxqj2r7i6Z/Ce9+AOYH1DerVm+Dt5ogfG8Z/OLnKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kiqo9dYPJLnHaLEdOV8v1C6ys/D3J3EdhUWprLsiEEk5ez+gZ6tqGQ39UEL4fdCQq
	 DhF8/ykE1EqgDRIY8vf/lxnkc4X+VQxMedQlJtbs1O973vjToc5gsEtHGujlQZoaPL
	 b8EzkjeRWmeMKQy4OZbvpPCYBawJ5eO6BA78eIM1HGeyxYnhQTrqa10cWAmT6P0/Wq
	 zDd+D+gTvppQU+rCjHvXQrtnadn4fyEuEFb6Zp8BPNmBwfXHtnm9MQ+vkcHjmOGQmQ
	 TdhNk00UqaSg0Xp3D6lbyOS+GgM5+ckE2/prTRW9FU9GEv9nQeLqMexDhZzEmNVFPU
	 oKF8Pkd+t09hg==
Message-ID: <sashiko-outbox-183679@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] selftests: kho: Add riscv support
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261023111612.2134-4-cp0613@linux.alibaba.com>
References: <20261023111612.2134-1-cp0613@linux.alibaba.com>
 <20261023111612.2134-4-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 11:16:37 +0000
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

> Teach the KHO vmtest runner about riscv64: map the target to ARCH
> riscv and describe the QEMU virt machine, the kernel image and its
> console -- a 16550A port probed from the device tree on virt, hence
> the SERIAL_8250{,_CONSOLE} and SERIAL_OF_PLATFORM symbols.  Also
> select CONFIG_SPARSEMEM_MANUAL: the runner requires
> CONFIG_DEFERRED_STRUCT_PAGE_INIT, which depends on SPARSEMEM, while
> riscv falls back to FLATMEM (no ARCH_SPARSEMEM_DEFAULT), so without
> it the test would just be skipped.
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023111612.2134=
-1-cp0613@linux.alibaba.com?part=3D3


