Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9980606A31E
	for <kexec@archiver.kernel.org>; Sat, 24 Oct 2026 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gspNXeHq;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hnust00J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Vzjv6IHCNSSO5ZeDhxjZBQMNQOBJW4dA2an9jRAq4Po=; b=gspNXeHq8HW4s3A3TDqNDUNVp3
	2K2U/Z33TJym9MFB5xU1xS9I5QNYT3B7BA3LqVCoTxgJfihwcAlh0ACvzoOTPJqFgJtWXrIW1W7Pp
	cfKfRSUg1mmbtFtnOGsHr0prqr5AwDIL3qDuyh+iqQkg1aKJGKr9SZZjke0z+HJJd1xoID3BM8LFQ
	bwr/t5bNjV/zutuz8PkQA2EbPXvj+iijjb87+vF40PoeSNHa1YnsJvDvUE3MAjVLxo12Y5LZC4xfG
	D0jieBacmIfAmGHSGKfrJd+QIKFWr4VRqLmlV1pXyc9/ojamPxiIOhE+KOAGTcGOj3uplDT/qE2bo
	IsGK/o9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKZjq-000000007hg-1V3x;
	Sat, 24 Oct 2026 11:16:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKZjo-000000007hZ-3sh0
	for kexec@lists.infradead.org;
	Sat, 24 Oct 2026 11:16:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 52C0140A02;
	Sat, 24 Oct 2026 11:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63821F01825;
	Sat, 24 Oct 2026 11:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792840596;
	bh=Vzjv6IHCNSSO5ZeDhxjZBQMNQOBJW4dA2an9jRAq4Po=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hnust00JpVgXhYl8h3MMm7ralx3mBTXHm94+DFkDTh2YVVvidQOP6XuJJZcy1K8ro
	 s8aRwZL2uHtTexNsW3TcfHiT9QyaE8j2ge9IxVCUNPX+5Y1VDIx7e4CJQub4jB1E30
	 AIxALCGhEP/C8TzbDN+l2bx8peBknhltc+p5XeETH54dQsoMUZbJNg/siA4EeOxWGO
	 rF6m5gZec3AaoWAOB3OgNtQ40juJ5AtPhAs2ijVEfgOq5kgW42i8zi30N1OwR3GvBg
	 tIJ7RWrAyRMhi8O2ASGtDuRUAf4FnZRG85n3OyxDMzTegJSveNX9/kxsslUkcMsBpE
	 +8Vu8cyXmMnyQ==
Message-ID: <sashiko-outbox-183677@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] riscv: Call early_ioremap_setup() before parsing
 the DTB
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261023111612.2134-2-cp0613@linux.alibaba.com>
References: <20261023111612.2134-1-cp0613@linux.alibaba.com>
 <20261023111612.2134-2-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 11:16:35 +0000
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

> early_ioremap_setup() fills in the slot_virt[] array whose entries the
> return value of early_ioremap()/early_memremap() is composed from.  On
> RISC-V it ran after parse_dtb(), so an early_memremap() reached from
> the device tree scan returned "offset + 0" -- NULL for a page aligned
> address -- and the caller could only report a mapping failure.  This
> stayed latent because nothing reached from parse_dtb() asked for an
> early mapping before; the DT based kexec handover parsing is the first
> such caller, as kho_populate() maps the handover FDT and the scratch
> descriptor array with early_memremap().
>=20
> Move the call to the top of setup_arch(), which is how arm64 and x86
> already order it (early_fixmap_init()/early_ioremap_init() before
> setup_machine_fdt()/parse_setup_data()).  The BTMAP window is mapped
> into early_pg_dir by setup_vm(), and RISC-V neither calls
> early_ioremap_reset() nor defines __late_set_fixmap(), so the virtual
> addresses stay identical across the switch to the final page tables
> and nothing else in setup_arch() depends on the previous ordering.
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023111612.2134=
-1-cp0613@linux.alibaba.com?part=3D1


