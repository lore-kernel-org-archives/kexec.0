Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20325606A332
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BzR3vTmb;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0r1E82e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dU5anBaeZlRDT1TRM5DGZrpsVGDHEEaOZYhq2g6OYdk=; b=BzR3vTmbAY+xu6PMe55kXcCAgt
	WdL1V93y6TLF3gBYoOA/gqSqyYGqgMUWKsFCBhfdy7ADsHaX2wKnz6JhyHYaVxxFI8ULMnfrEXJQJ
	Fa2BDI98sUi3q7528tvoqho2J0uGNdzWW0cb3dkrdK0tJb+caB2lbx5qwS8mk1WZBlNa00boUaiy4
	nYg+RCh5I46TeMNAXMItTxEUDF1q0d4iF8yH4K815qDPx/7AS1r6FvbTrkph42byUcgc0eEAmAcas
	RzAe+xrjuV7hGZ8ZsZA4of3o/XbVIj5uzOrWMbe2fVg+XWoFe2QE5Zy2YziAJyeiJnb+50WoBg/vf
	z22gE7sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOW4e-00000004eaB-3TO2;
	Wed, 04 Nov 2026 08:10:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOW4d-00000004eZB-48z2
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 08:10:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ADB2143E88;
	Wed,  4 Nov 2026 08:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2F81F00A02;
	Wed,  4 Nov 2026 08:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793779823;
	bh=dU5anBaeZlRDT1TRM5DGZrpsVGDHEEaOZYhq2g6OYdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0r1E82eNanpaT8Zcxhx5YGLbXmbyFUCfRHstD9pDw/L9qsNc7KqddQPFV3RL1Qmj
	 EnvRcwoUxiQ6fgWKnA+qQVXfLv91W9gWy72FOPOQxXHGL8MvU4PzR70B7Na78+oh0G
	 XI6NZU3JTpWonmilGn4CmEXWhPsop52zt0UD/3uQcNXDmV5uxqYz0BVNg+BzSFN9lQ
	 qLvwEA4b/qEYabMmJqa6BjD3Fxj0Zkh2NVlnSHZpsoclKqSk5BAKkACBzfv4yfEB/x
	 1G8I0iadpusFtL978cCJ+wC2ygPC15HuZ43TvrYQ3NENNzs/RAPhtPqIGrXSdeUB1w
	 ZLjaTPuaU122A==
Message-ID: <sashiko-outbox-196856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] riscv: Call early_ioremap_setup() before parsing
 the DTB
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261103080926.2079-3-cp0613@linux.alibaba.com>
References: <20261103080926.2079-1-cp0613@linux.alibaba.com>
 <20261103080926.2079-3-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 08:10:22 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080926.2079=
-1-cp0613@linux.alibaba.com?part=3D2


