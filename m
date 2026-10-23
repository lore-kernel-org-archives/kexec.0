Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D906606A31A
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jttvN5U8;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rrh7lgmG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BS40WpU49k6s5fZ4bgGr4MMNOiSR3MGE222xs5ZQpUI=; b=jttvN5U8w2WueVD/tlxDq1sRTm
	mAIpuutxgSbQa5niKVjIz4QCyFN8PzKCbChMe6M6F8908YtpwLE8TzmVhI/uzzbc+Nf8xmX0V8IH6
	4RpXRbLSpBOVJo/0CKY4wpxnIfo6FfkLldm5kjTlorMtzcR/8MuSRChCkVpJT4pdnkQh4pt/IMGUe
	+elp5Rj2eszlgu6qTVAUnoCJLo6LiMiNFUcwrRYXs3qErRzKy/5RauoCSucxSgvNque5WL0W3RrSi
	T3Tnzl3EsmWyE+WqX4Jz0tncjLA12rgH2QzNHiEas/dJqV5cmBw7IHL5lasiN4sLnVme79pqSUUoc
	G+3SkEeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK89M-0000000FXhv-0g9t;
	Fri, 23 Oct 2026 05:49:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK89K-0000000FXhU-1SWc
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 05:49:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6DC1460211;
	Fri, 23 Oct 2026 05:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B339C1F01825;
	Fri, 23 Oct 2026 05:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792734545;
	bh=BS40WpU49k6s5fZ4bgGr4MMNOiSR3MGE222xs5ZQpUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rrh7lgmGeEab++ld7MOw08X80f7X03eRVWChcwdqo6isbVzstPL8XC/NJvTlaGJr+
	 S88hCj2LySv79IoIfgeDfxu6hxw0Ynb9TbEST7/BmwCmV1BPK/QEt3RSOaIYWDsSZU
	 9OinsAFy5AhbL1nEUqkmR/hlklmkk9IvLuNJbug88ji62y4oOnv3oUzOmO30ngM2ay
	 kYREzbWzDaCRv1VqVirFZd1mus8+4DrtC9CyKrDOVucPy2R7sD9QehYOTei0NQfaCg
	 +NKt0qMbnoXDrHq7r1KIq/jYkuwZpaOUnQms2VWqdMXuHCFlg3m6VoBpTUjVw+VOAq
	 MOm7FNz+LnSOg==
Message-ID: <sashiko-outbox-182333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] kho: check fdt_phys in is_kho_boot()
To: "Greg Thelen" <gthelen@google.com>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Alexander
 Graf" <graf@amazon.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Evangelos Petrongonas" <epetron@amazon.de>, kexec@lists.infradead.org
In-Reply-To: <20261023054518.3258350-1-gthelen@google.com>
References: <20261023054518.3258350-1-gthelen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 05:49:04 +0000
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

> During arm64 setup_arch(), efi_init() -> reserve_regions() calls
> is_kho_boot() before arm64_memblock_init() initializes memstart_addr.
> At this point memstart_addr still holds its initial sentinel value (-1).
>=20
> When booting via kexec with KHO enabled, kho_populate() sets
> kho_in.fdt_phys from the /chosen FDT node. Calling is_kho_boot() ->
> kho_get_fdt() invokes phys_to_virt(kho_in.fdt_phys), which evaluates
> PHYS_OFFSET and triggers VM_BUG_ON(memstart_addr & 1) on arm64 kernels
> built with CONFIG_DEBUG_VM=3Dy:
>=20
>   kernel BUG at ./arch/arm64/include/asm/memory.h:377!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>   Call trace:
>    is_kho_boot+0x2c/0x38 (P)
>    efi_init+0x94/0xf8
>    setup_arch+0xf0/0x240
>    start_kernel+0x84/0x490
>    __primary_switched+0x88/0x98
>=20
> Check kho_in.fdt_phys directly in is_kho_boot() instead of calling
> kho_get_fdt() so that early boot callers do not invoke phys_to_virt()
> before the linear map offset is initialized.
>=20
> Fixes: d6d511639185 ("kexec: introduce is_kho_boot()")
> Assisted-by: Gemini:gemini-3.8-flash
> Signed-off-by: Greg Thelen <gthelen@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023054518.3258=
350-1-gthelen@google.com?part=3D1


