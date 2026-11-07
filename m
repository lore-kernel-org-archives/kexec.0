Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F2F606A326
	for <kexec@archiver.kernel.org>; Sat,  7 Nov 2026 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=d1cFlzVq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQUZRBNV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pnSXCbbDPV1lCDGg2y17BXskbCpHs6LyuHwUITlKYOU=; b=d1cFlzVqBI1Q5oZb6Z/JhwWfFD
	iaqP7BnVs/CaKEUG7O3BB3Pyy+vlJTznw0+OzUAtlGHvdy5YNLgj00Fl93KPQrMhM/qgCf7w6hkox
	URh+mX1ymVxdnw116/eZyMepINxN7Ns1aIM9XcvO6hFh3jpl9nmjW5OE9j3U5WanMknRdFRI2wufu
	o4sq1ZwSd4L7vRiutB0DjAYK03b/Xg3pBlm8XuE6R6vq8qy5zzem68jj2LAOHxs5QvZDuzf9BwzuM
	df2XZl5kzJ8bP43ViUoyFHRSe6Z0OzEtYgleDF0pgKqSBIhi7YBFLC5hPYIOk4eHqjH2Oyy42IrQo
	7Mq3V2rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPaeM-0000000EIxh-49KC;
	Sat, 07 Nov 2026 07:15:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPaeF-0000000EIwg-4A9R
	for kexec@lists.infradead.org;
	Sat, 07 Nov 2026 07:15:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BDCC242B97;
	Sat,  7 Nov 2026 07:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250FE1F0089F;
	Sat,  7 Nov 2026 07:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794035735;
	bh=pnSXCbbDPV1lCDGg2y17BXskbCpHs6LyuHwUITlKYOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gQUZRBNVkiSQ73P2Ma9pwvdhACPswzCoKFYNCrKNpMj140nlhi1hiq4/red72+unG
	 R5YUSNuDdB1vEPfpD5U1pKKYdRU3ANB25Ffh4ufdw4/9znXUs0aXR3j2k2LR3N2Zda
	 5Ob+abhOfOq0IkfXy/E8oHFuuzkeGv7Qw/P+KORqxkvR0JP6l3DzXAXT61UjBtVz4Y
	 Rb818gXjWenNZWd1MhXsVdNiRoWzC6XRWOSLcdjSowk222ITEdCoFbZOfxafQ2ywJU
	 YdU3Vkja3gNLR9uRtXqDHzObxGjY/6Sf68UH7Uh+yjqG6iHFP6KiytbcfYXuEDIyCI
	 7FjGOjpsihtzQ==
Message-ID: <sashiko-outbox-202684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] selftests: kho: Add riscv support
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261106071459.2003-4-cp0613@linux.alibaba.com>
References: <20261106071459.2003-1-cp0613@linux.alibaba.com>
 <20261106071459.2003-4-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 07:15:34 +0000
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

> Describe the machine the KHO vmtest runner needs to boot riscv64, so the
> test stops being skipped on this architecture.
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106071459.2003=
-1-cp0613@linux.alibaba.com?part=3D3


