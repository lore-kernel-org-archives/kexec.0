Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F0606A321
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3lsvFae4;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjDriSXi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xu2HskALF4vHugz1HfPOf04xInHsKZY4eA7638JxyWE=; b=3lsvFae41ICSG6q1dbp44NUtf7
	/jH1IEVU0nufyska5V2mbOBv7Z9K2FpiXXaIrKD4LmZZ1TYE7+Yp7CfOzTsVhoKfiBXLxSr60ObpD
	J9xbkPABQ8PVFwRbKdSOJqR01as5POeTrJY0kwUns8Rr1C0P8XNQgjpvLGY8GDnPB4CysoqveAFyh
	4J6zVR79T3SuzJCgs0LNzRkE59VaOYbZJgoo547uxQOQBnOEDin7vXQcEUibyXLW+TJbXOqWHnM8/
	mO41TbtoIbVc1MUq1ZtOzEyqmyvrgjfVyIoceEsjfet+PaK6v/XTeQ2Ug7Y9VHEH+8HbQsroFFV3N
	muIDUfUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKATk-0000000Fuhm-2MDh;
	Fri, 23 Oct 2026 08:18:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKATg-0000000Fugr-48Rg
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 08:18:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 128C0602BA;
	Fri, 23 Oct 2026 08:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E6D1F031E4;
	Fri, 23 Oct 2026 08:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743495;
	bh=xu2HskALF4vHugz1HfPOf04xInHsKZY4eA7638JxyWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mjDriSXi2Ds5941zxQFJXvUqJ+ePyX0z176L1xTQ7asFUkF+FUMj3kB8AVeJkjb2v
	 GhTys05eJzC6yvJgXRltnFC3JijWoMOREFdX3B1qLBLLGjdPFlGyn/4lMpYDKhx8hD
	 rgyUMm/uPrsJNay8HJPbbbj95rWcRU9KtuTb9mfPZTaekGmVUbnY360csfjS627zzT
	 8K/j//CTYBzk5DEkjrGASdOBDdvp+oG3lsa4JN32N+1D/OkU1l4LNKNchEmP9ADVRI
	 fKqeAYeqyryG9HNp+011H6e95/r7jfjE1gUbeAaslZUQUvl2VnLqKECgreUGs5JbvS
	 dN3zNPBZSSCxQ==
Message-ID: <sashiko-outbox-182502@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] kexec_file: Honor the segment alignment for CMA
 allocations
To: "Han Gao" <gaohan@iscas.ac.cn>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Yao
 Zi" <me@ziyao.cc>
Cc: "Han Gao" <rabenda.cn@gmail.com>, kexec@lists.infradead.org
In-Reply-To: <20261023-riscv-kexec-cma-fixes-v1-3-825b90ea23c4@iscas.ac.cn>
References: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
 <20261023-riscv-kexec-cma-fixes-v1-3-825b90ea23c4@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:18:14 +0000
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
> dma_alloc_from_contiguous() limits the requested alignment to
> CONFIG_CMA_ALIGNMENT without reporting it. kexec_alloc_contig() can
> therefore place a segment at a less aligned address than buf_align. On
> RISC-V with 4 KiB pages, the default 1 MiB limit is below the 2 MiB
> kernel alignment, and the new kernel stops at the setup_vm() BUG_ON for
> a misaligned physical address.
>=20
> Release such a block and fall back to the regular memory hole search,
> which honors the alignment.
>=20
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-riscv-kexe=
c-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn?part=3D3


