Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37643606A32E
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NwXtU9tc;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oof1Pi1z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DcLhttAabVuarolB3jw46A6xVIta/9w1GIOqgNc/Fw8=; b=NwXtU9tcwyl/q6mQc/EPRJhrHV
	/CcHzNaOauLSAofvfTmcjDstK8HMnmRWvswUwVifFOMQGjplUgF9pSyfVeHYEJl795XyBygd7qwgI
	YXmXLDmCf/umAdw2eOy0yEYrdsmaIwQH1/266bek30n9ZrQ9HhbwOswgjCfF6TwnqXEaku9wS1m4D
	mG0H/NyS6+rey1rIaz3exusSPoAvE+Z0ApiGVQBqAWdsjiMQc6mvFv+Ew1NdHZhB7UX1i5r7u16A0
	qxYh5hhiRZ5GF4nk0negwt14rHgVu7LDKKpkhaVl7ncuZaGL4TGXabdrdqkqIJZrqLQ5Mc104jQhh
	4TcmlzaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOW4j-00000004edP-3n1V;
	Wed, 04 Nov 2026 08:10:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOW4h-00000004ebH-0Fi4
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 08:10:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CD53643BED;
	Wed,  4 Nov 2026 08:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2AA1F00A02;
	Wed,  4 Nov 2026 08:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793779826;
	bh=DcLhttAabVuarolB3jw46A6xVIta/9w1GIOqgNc/Fw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oof1Pi1zN2vu7RGZNsPgAKDw9qPK0H1fe6KlzyHXEmmSzfWN9yjNRzVBqAkGE/iG8
	 207d/WaD3MURitjEe2x9jUuiZfUE+J3uxCA6id2gMmUFoyC1V71Q7QdHtPW7SuPj0f
	 QMdWoLF5EBJqgsfn9ef4wOf/wKhz3wS4HaSFRw945GlC1VbTP8nkOyd3k4kOwkIy5/
	 zsSeRy51jPKNZWOniAsvvHjF4NjAr2JuBNlxaLmDgWlVykp382HO/IoTPNtAhtHzbY
	 FUEY2Hq43TYsUq/CX9eknJSvdTUZe0G+12rj4aiXy62ouRcBLTmCRpNpOT/93WwacR
	 JlSzL88EVNK1g==
Message-ID: <sashiko-outbox-196859@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] selftests: liveupdate: Add riscv support
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261103080926.2079-6-cp0613@linux.alibaba.com>
References: <20261103080926.2079-1-cp0613@linux.alibaba.com>
 <20261103080926.2079-6-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 08:10:25 +0000
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

> Teach the live update vmtest runner about riscv64: map the target to ARCH
> riscv, describe the QEMU virt machine, the kernel image and its console,
> and add the arch config fragment holding the three symbols needed to get
> a console on the virt machine's 16550A port.
>=20
> KHO is the only dependency of LIVEUPDATE (kernel/liveupdate/Kconfig), so
> now that riscv has KHO the LUO tests only need the runner to stop
> rejecting the architecture.
>=20
> Add riscv64 to the CROSS_COMPILE auto-detection list and to the target
> list of the batch runner as well, matching the existing aarch64/x86_64
> entries.
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080926.2079=
-1-cp0613@linux.alibaba.com?part=3D5


