Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC657606A31A
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PykdQOHz;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oymLPXF6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lKmk6tLv6L2dAKAc8GVLYo9OEWkc9cBlXHb/4fkDSnM=; b=PykdQOHzIiJLxRnyw/Ed+b6A6e
	l27k0j7+5+D8U7Wmdx3LqsAMrj2QQs6eQSKe/I66h/yeFcKRA2NfToxB4qFIbYMrtLzWekbzNjo+3
	hDUYNabpZwQeB0mW2ejMygT+9Q9OUT9r+mri4DH/sKEPMA+Cin3nQtI3Z52cIuaVZPWrgTOvVk0Qz
	3AuE3TJP1zkTpB4XxIpghi5iz1VxtXylsx3BA45haB1MybfRC+JjZ4KCvwYTU1eJY2kp2PQF6yvV6
	x3oCu7629Dsl2UNiBYpfQv7iuD8VOJJyLnidKdEYxJqhW0tYpNw6Gfp5/iHuRpK/E5HR3hSyYnQ//
	X9gzMpAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2T0-00000001Gt3-1azq;
	Sun, 25 Oct 2026 17:57:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Sy-00000001GrP-3ZnD
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:57:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 98161419FA;
	Sun, 25 Oct 2026 17:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F9D1F01825;
	Sun, 25 Oct 2026 17:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792951028;
	bh=lKmk6tLv6L2dAKAc8GVLYo9OEWkc9cBlXHb/4fkDSnM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oymLPXF6/ZNIhs+CrOQtaXVKVyberOi04NMOL+efrvecUTHfKhtfWqA4PSKYSiNsq
	 Yt+fGJ1K9VsZ4+oTVw8Rh7RssBpXCM+/5eh5jc+7yRHmfeiaf8A+Lauc+rKfBm7JBf
	 kqYekh2kUDLiL9IWVvgf45Vrp3RbBds0bkdPiymJ1tZe7NCS22oo05UoWH7yoI781a
	 JUF3YZA3M7l+BE49YdN523geQs9ITU58iMt9/BsVPg+Hwg786E1GqJo2uj/UpCZM2+
	 NbM0PchK+5alBYNWz+JfwV5Tpv+9AeOPrJLG0B9bvXQCD5Wd1FPFXHMNoOeOnyweHp
	 rzTNk5Dq3vHSg==
Message-ID: <sashiko-outbox-184309@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/9] selftests: kho: add read-only KHO test to
 vmtest.sh
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261025174017.3870481-10-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
 <20261025174017.3870481-10-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 17:57:07 +0000
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
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> vmtest.sh currently only tests standard KHO restoration and does not
> exercise read-only KHO mode ('kho_ro=3D<fdt_phys>') in QEMU.
>=20
> Extend tools/testing/selftests/kho/vmtest.sh and init.c to enable both
> CONFIG_KEXEC_HANDOVER=3Dy and CONFIG_KEXEC_HANDOVER_READONLY=3Dy in the
> kernel configuration and run a second QEMU test verifying read-only KHO
> after the standard KHO test on both x86_64 and aarch64:
>=20
> - Enable CONFIG_KEXEC_HANDOVER_READONLY=3Dy alongside
>   CONFIG_KEXEC_HANDOVER=3Dy in build_kernel().
> - Pass KHO_RO_CMDLINE ('nokaslr kho_bootmem=3D64M,64M,64M' on x86_64) to
>   the first kernel in the read-only test run and configure 4G of RAM on
>   aarch64 so GFP_KERNEL KHO allocations are placed in ZONE_NORMAL above
>   4G, outside the read-only kernel's System RAM.
> - When booted with 'kho_ro_test', read /debugfs/kho/out/fdt_phys in
>   init.c and kexec into the target kernel with 'kho_ro=3D<fdt_phys>' and
>   architecture-specific memory parameters
>   ('memmap=3D792M$16M memmap=3D24M$1000M' on x86_64, 'mem=3D128M' on aarc=
h64)
>   so the preserved pages are excluded from the boot memory map and
>   mapped via kho_ro_map_folio().
> - Verify 'KHO restore succeeded' from test_kho in read-only mode.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025174017.3870=
481-1-pasha.tatashin@soleen.com?part=3D9


