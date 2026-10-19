Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30B8CCF2D4
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=edP8iTQKvWnYFzuMPDfxFMU2dumWTw5rpCXzMcb0OUU=; b=3plMJn226YvC0W83Aq+kHAzdEo
	qWj5TcgAbxxJHWZC1yUU3bgWMwSBCTR7k8E21Ql0E8VYZMUfABSjeqF7wxjf9xjDl8hleK6aeRqbE
	yhQu+G67qC/x98Hbwt8Fzaja1QRQUwm4gF7XBjFtpn097RhlO6u+1/8w29jazBo+k4+dtBVZMXGOX
	jcJya5LTFb6VbDuzfUKuu68UZMeWyRINqt3Q83FdR/QN8fsxvsqGlsmI82SiUWSqUbux9+rL8HbqW
	8wnSM/jK5a3w4rpWZoq4f4gAHDnCzBNpK7YJgoRMkb/PvWiWKubfpAhTRbbIIcwCLE6FGUCz0uMWj
	1+HSUZtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxu-00000006SVm-24Jp;
	Mon, 19 Oct 2026 02:19:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxs-00000006STG-1xU1
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:19:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3965440672;
	Mon, 19 Oct 2026 02:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CA41F000C4;
	Mon, 19 Oct 2026 02:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792376344;
	bh=edP8iTQKvWnYFzuMPDfxFMU2dumWTw5rpCXzMcb0OUU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KMVtHGfLWL2v2EL5HLDnaBAYS8LM2jbvGVOAQSYDVdYq/Pw5wq0nf4qPO+WB4ZzgL
	 j/NgtgcsM4dy5Xzlu/30SMJjoVgLRdWIgMY8KyJhbMQcH/rDFNvro1DghjH13CWmxV
	 90MqTVoUQIafz1GxgXhStyIP6RydmnWPoxAxyqf9I/egnzwUEuvi+Ix+EhPYstzR0M
	 Nn+7GmiNAVaLOwtsPSqtS5eF+SjOGAMg76aeyfO5gn9hZVo+nxdk31JoD+Vl7xKqJ7
	 94z806BKAsn1mut+uZsqkd7bEW8YAzejkDHtd+yCU7Ij9Ct8DGWynpcq43QKV/aBjw
	 jMbuVqqZqRPzQ==
Message-ID: <sashiko-outbox-176525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 8/8] selftests: kho: add read-only KHO test to
 vmtest.sh
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261019021111.990394-9-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
 <20261019021111.990394-9-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 02:19:02 +0000
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

> Extend tools/testing/selftests/kho/vmtest.sh and init.c to run a second
> QEMU test verifying read-only KHO ('kho_ro=3D<fdt_phys>') after the
> standard KHO test on both x86_64 and aarch64:
>=20
> - Build a second kernel configured with CONFIG_KEXEC_HANDOVER_READONLY=3Dy
>   (and CONFIG_KEXEC_HANDOVER=3Dn).
> - Pass KHO_RO_CMDLINE ('nokaslr kho_bootmem=3D64M,64M,64M' on x86_64,
>   'cma=3D116M@0x40c00000' on aarch64) to the first kernel in the read-only
>   test run so KHO allocations are placed in predictable physical ranges.
> - When booted with 'kho_ro_test', read /debugfs/kho/out/fdt_phys in
>   init.c and kexec into the read-only kernel with 'kho_ro=3D<fdt_phys>'
>   and architecture-specific memory parameters
>   ('memmap=3D792M$16M memmap=3D24M$1000M' on x86_64,
>   'mem=3D128M cma=3D12M@0x40000000' on aarch64) so the preserved pages are
>   excluded from the boot memory map and mapped via kho_ro_map_folio().
> - Verify 'KHO restore succeeded' from test_kho in read-only mode.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019021111.9903=
94-1-pasha.tatashin@soleen.com?part=3D8


