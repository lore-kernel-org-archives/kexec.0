Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3EA606A32F
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cA5CGUdg;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPKIoING
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kTT7Dsx9X9PpjaeyEGwz9MttR0qrfvG6TEXWwsL/a4I=; b=cA5CGUdgKqQi7XAdn11V0O5yaM
	rL0i68/+/+mSIKizdMuvyfYmhKuiVas6GT2ktid4J28LDGLzzXJ8z6ufbnErvTDWYtpzUoczJEZad
	Io6KVndtnGrMPf5OuGO0Au51aLj57xslcWA9hTM1RVFGYJbfyluDXdqdTN9FaFR0Vu2UE6yW/FHmu
	Ff3P1awNU+NeIgPI02XjhPSTOhoP2SHV54eyZwBbI0pejxyt1H6tSD7j4VJYyyOD+kV71IZXsvney
	jnp1Frpgf5u2JXJLE8YTkCvaB65oCK8kftQbz0WfPvuH36plvrE4Vzzw09PvvD1KZLybl/lHmUv7Q
	0xHhw7Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAIu-0000000FsPc-1M4U;
	Fri, 23 Oct 2026 08:07:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAIm-0000000FsOc-46Al
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 08:07:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A912441AAA;
	Fri, 23 Oct 2026 08:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A981F01825;
	Fri, 23 Oct 2026 08:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792742820;
	bh=kTT7Dsx9X9PpjaeyEGwz9MttR0qrfvG6TEXWwsL/a4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPKIoING2m+4nufl7BdxRnmhA2J4XdzdQdjbcXUhLLD0XW6JHhtx7+7UxvAdlzmyT
	 eyLVXeJeq+4r4jl9fgWWUvWLQ6rdUl4pm72DFZRBYfIhRijKT9lNZs6sVL+Qj91hzm
	 CBaZXr3578A57adzLa2029AHOHEd1Sb9xNQ9ubPj2C1Rz392NK5YTFC7z9RWdVKChY
	 IqOeZW0hZNBYYc1V0iJ3Ow2uYAhvEhTcJR5iNKM7nF19C5PX3hLrFnpi/Rki1Ud6rw
	 6jF6KxmF9dmPP0LobypIWL0n4xpO9/ufHB3uxsDltnZLPZxfD7ZU/VZlGqCJ4KWWpD
	 6PR6BpYa+CooA==
Message-ID: <sashiko-outbox-182473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] riscv: mm: Reserve the DTB before scanning reserved
 memory
To: "Han Gao" <gaohan@iscas.ac.cn>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Yao
 Zi" <me@ziyao.cc>
Cc: "Han Gao" <rabenda.cn@gmail.com>, kexec@lists.infradead.org
In-Reply-To: <20261023-riscv-kexec-cma-fixes-v1-5-825b90ea23c4@iscas.ac.cn>
References: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
 <20261023-riscv-kexec-cma-fixes-v1-5-825b90ea23c4@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:06:59 +0000
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

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> setup_bootmem() reserves the DTB only after
> early_init_fdt_scan_reserved_mem() has allocated the dynamically placed
> reserved-memory regions. A CMA pool described with size and alloc-ranges
> can therefore be placed over the DTB, which is later handed to the page
> allocator and overwritten.
>=20
> This happens after kexec_file has put the DTB of the next kernel in CMA:
> the next kernel reuses that range for its own pool, and a further
> kexec_file_load() fails with -FDT_ERR_BADMAGIC.
>=20
> Reserve the DTB first.
>=20
> Fixes: ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap regio=
n")
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-riscv-kexe=
c-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn?part=3D5


