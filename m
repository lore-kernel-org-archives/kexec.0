Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B56CCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KWG/GLzE2S3ocz1WloUZ5Vv/t61RLBOkn4+vdFrOnXE=; b=ukoRJuzAhIE4+49pabLfw11RAb
	rDISykTJJTSiM0NEVlbAK0itKrKEVP3l+oAQJwN4sEU+KwRhw27yK7pQgDIeIKbQTaii1Djx6Mijg
	SsLCz+07Qx9xieRIzz0o4JTrThv/aDwqhXYe08P2wl4Mdr4BZb/wm/6dGPBoEFCcKj+morlHZxP1/
	R8Xy1G3Kpirx8ZkcwD7InmMTzZkER7U16RQMqgIcZTPXrBKd/8C4oGFmwrxwYwioYFmJjzQuJf2Nz
	NN0sTvb/Az9CBLdkO6c8KcyHnaPbkn26eKjNnvJIEQ5GMKaxD+HtKZVt6H1C1DSmj5/Vn2EAZ2eAn
	Q+DrJw4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbOI-000000027W1-3BoR;
	Fri, 16 Oct 2026 06:26:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbOH-000000027Ve-1YCc
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:26:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A88F60018;
	Fri, 16 Oct 2026 06:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29981F000C4;
	Fri, 16 Oct 2026 06:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792131964;
	bh=KWG/GLzE2S3ocz1WloUZ5Vv/t61RLBOkn4+vdFrOnXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WXKhnGW52ECgiIM0IFflVYy58bv0xGveDVryrW3bdu6k4U+MG2gYR1uZfhcyx7Nww
	 3Lsl5NdKlVofhf4bMNTnrycYu549Uw80MDlnc8GHeSsFRRSXoIUxYLvqvAxZcp52xp
	 wKnuQC8vOjZKHbOCSzFY2IDhpuynrxIeCPRvDwTYBRj2dsUnbiuvoliCMY9BEaqiYQ
	 V3bw6uAgPv3J2ZBVkRhwDgmtQmfiSl0Bu/HzVq/FxFFYB7Zj1soJBmUrW+KDpfuVRw
	 aPLAQzgcPCBIuHJLKBkrdUhjPPnyhB4gZvZLa94zcdElgb+BjsVm2DwUypBw+Z9IUw
	 y9Cqjke3rLXsQ==
Message-ID: <sashiko-outbox-173858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v8 5/8] memblock: introduce MEMBLOCK_NODUMP flag
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, kexec@lists.infradead.org
In-Reply-To: <20261016061549.4181390-6-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
 <20261016061549.4181390-6-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 06:26:02 +0000
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

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> Add MEMBLOCK_NODUMP to mark regions that should be excluded from
> kdump vmcores.
>=20
> The flag is meant for reserved memory that carries no data useful for
> crash analysis. Reusable reserved regions such as CMA may hold useful
> data, so these regions must not be marked MEMBLOCK_NODUMP. Subsequent
> patches wire this up for /reserved-memory entries.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016061549.4181=
390-1-chenwandun1@gmail.com?part=3D5


