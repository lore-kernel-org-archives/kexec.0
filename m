Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC8606A31E
	for <kexec@archiver.kernel.org>; Sat, 24 Oct 2026 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UyHgOM+7;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iq8+oVE1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VmG661DarIFpMV979eRzaqnmXdaWA2QCBzoS/ZpyW6E=; b=UyHgOM+75efeh7DMYl+iNhEifg
	w8AXHNlAZ6Mq9d8Zmg6Z+E0RJ61dwqIVsR42GtqKL8dcFhoE8GUWsah7612k2tmt3/D4rBbVi+7WC
	F8MToAmOtIvgbnBlfvXtZHE6CvHXtujwnSv3Np8UoO3ernkXlnRp4JyuDWIWw5f9qEICzKoxqvb7p
	+/Yprl68zrwX+Nw0dyjtjlgSbcwDmGvyWkTzhJ0vR+6nR51jJkN5rp81bYxP9hcKBAO3ucfAJ/8ly
	alFtKn4NrXNMvOt9RXrouoPvwEYoJEHIXfwB8e0bDg5cV9qMeSpgxyvqWSbdC4DfKnPBTFgCG4/jt
	EhgZY6CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKZju-000000007jx-2ccj;
	Sat, 24 Oct 2026 11:16:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKZjs-000000007i4-24gq
	for kexec@lists.infradead.org;
	Sat, 24 Oct 2026 11:16:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B45F260A54;
	Sat, 24 Oct 2026 11:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44571F01825;
	Sat, 24 Oct 2026 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792840599;
	bh=VmG661DarIFpMV979eRzaqnmXdaWA2QCBzoS/ZpyW6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iq8+oVE1e6pdHVLsDCvdR5CVjDh2NoC3cqQ6WI+P2hF2a9j9+Rs3NCb7sdGQNM8JM
	 hyjjg+4cPbvyv2H77kAYyeWwj7o+KyE61uBWaIED8pCaEEwZ8DWapnlQuwQM29GuNO
	 TcX6xBaflx7UQstsElluXkmjnL4xElfFzNaTvsYBjIjd58gQH94imDz1+naS/jIDlq
	 65KeAto0D/MO6if/J+xooHH9oe/s+WPdso1U6xDk/TU54CzrQDyiLxuwMHgfyYqdPF
	 phhFfFbxx0H+92PcUtCZjIlzFBW1jRuU6AYcrz39FIPShoPSHaEuilxoaXtxoQCQjV
	 NPH0HGT8qBUTg==
Message-ID: <sashiko-outbox-183680@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] selftests: liveupdate: Add riscv support
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261023111612.2134-5-cp0613@linux.alibaba.com>
References: <20261023111612.2134-1-cp0613@linux.alibaba.com>
 <20261023111612.2134-5-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 11:16:38 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023111612.2134=
-1-cp0613@linux.alibaba.com?part=3D4


